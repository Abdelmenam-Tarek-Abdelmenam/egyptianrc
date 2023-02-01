import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../presentation/shared/toast_helper.dart';
import '../data_sources/pref_repository.dart';
import '../error_state.dart';
import '../models/app_user.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthRepository() : _auth = firebase_auth.FirebaseAuth.instance;

  Future<AppUser> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        sendConfirmationMail(user);
        return AppUser.fromFirebaseUser(user);
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw Failure.fromFirebaseCode(e.code);
    } catch (e) {
      throw const Failure();
    }
    return AppUser.empty();
  }

  Future<AppUser> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      User? user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        if (user.emailVerified) {
          return AppUser.fromFirebaseUser(user);
        } else {
          sendConfirmationMail(user);
          throw firebase_auth.FirebaseAuthException(code: "Email not verified");
        }
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw Failure.fromFirebaseCode(e.code);
    } catch (e) {
      throw const Failure();
    }
    return AppUser.empty();
  }

  Future<void> sendConfirmationMail(User user) async {
    await user.sendEmailVerification().whenComplete(() {
      showToast("Verification email sent to our email please check it",
          type: ToastType.info);
    });
  }

  Future<AppUser> signInUsingGoogle() async {
    try {
      final firebase_auth.AuthCredential credential;
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      User? user = (await _auth.signInWithCredential(credential)).user;
      if (user != null) {
        return AppUser.fromFirebaseUser(user);
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw Failure.fromFirebaseCode(e.code);
    } catch (e) {
      throw const Failure();
    }
    return AppUser.empty();
  }

  static Future<void> signOut() async {
    PreferenceRepository.clearAll();
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
  }

  Future<void> forgetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw Failure.fromFirebaseCode(e.code);
    } catch (_) {
      throw const Failure();
    }
  }
}
