import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egyptianrc/bloc/auth_bloc/auth_status_bloc.dart';

const String activeColl = "active";
const String archiveColl = "archive";
const String usersColl = "users";

class FireStoreRepository {
  StreamSubscription? listener;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  String get _uniqueId => DateTime.now().microsecondsSinceEpoch.toString();
  String get _userId => AuthBloc.user.id;

  void buildListener(Function(List<Map<String, dynamic>>) callBack) {
    killListener();
    listener = _fireStore
        .collection(activeColl)
        .snapshots()
        .listen((event) => callBack(event.docs.map((e) => e.data()).toList()));
  }

  Future<void> uploadPost(Map<String, dynamic> postMap) async =>
      await _fireStore.collection(activeColl).doc(_uniqueId).set(postMap);

  Future<void> setArchivePost(Map<String, dynamic> postMap) async =>
      await _fireStore.collection(archiveColl).doc(_uniqueId).set(postMap);

  Future<void> deleteActivePost(String id) async =>
      await _fireStore.collection(activeColl).doc(id).delete();

  Future<Map<String, dynamic>?> getPost(String id, String postType) async {
    DocumentSnapshot<Map<String, dynamic>> data =
        await _fireStore.collection(postType).doc(id).get();
    return data.data();
  }

  Future<List<Map<String, dynamic>>> readAllActivePosts() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await _fireStore.collection(activeColl).get();
    return data.docs.map((e) => e.data()).toList();
  }

  Future<List<Map<String, dynamic>>> readAllArchivePosts() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await _fireStore.collection(archiveColl).get();
    return data.docs.map((e) => e.data()).toList();
  }

  Future<Map<String, dynamic>?> getUserInfo(String id) async {
    DocumentSnapshot<Map<String, dynamic>> data =
        await _fireStore.collection(usersColl).doc(id).get();
    return data.data();
  }

  Future<void> setUserInfo(Map<String, dynamic> data) async =>
      await _fireStore.collection(usersColl).doc(_userId).set(data);

  void updateUserInfo(Map<String, dynamic> data) async =>
      await _fireStore.collection(usersColl).doc(_userId).update(data);

  void killListener() {
    if (listener != null) {
      listener!.cancel();
    }
  }
}
