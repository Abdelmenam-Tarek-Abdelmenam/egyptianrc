import 'package:egyptianrc/bloc/auth_bloc/auth_status_bloc.dart';
import 'package:egyptianrc/data/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../data_sources/pref_repository.dart';
import '../error_state.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthRepository() : _auth = firebase_auth.FirebaseAuth.instance;

  Future<void> requestMobileVerification(String phone,
      Function(String) callback, Function(Failure) errorHandler) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) =>
          errorHandler(Failure.fromFirebaseCode(e.code)),
      codeSent: (String verificationId, int? _) => callback(verificationId),
      timeout: const Duration(minutes: 2),
      codeAutoRetrievalTimeout: (String _) {},
    );
  }

  Future<User?> checkMobileVerification(
      String validateCode, String code) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: validateCode, smsCode: code);
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      return userCredential.user;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw Failure.fromFirebaseCode(e.code);
    } catch (e) {
      throw const Failure();
    }
  }

  Future<User?> signInUsingGoogle() async {
    try {
      final firebase_auth.AuthCredential credential;
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      User? user = (await _auth.signInWithCredential(credential)).user;
      return user;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw Failure.fromFirebaseCode(e.code);
    } catch (e) {
      throw const Failure();
    }
  }

  static Future<void> signOut() async {
    PreferenceRepository.clearAll();
    AuthBloc.user = AppUser.empty();
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
  }
}
