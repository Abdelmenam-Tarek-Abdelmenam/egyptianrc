import 'package:firebase_database/firebase_database.dart';

import '../../../bloc/auth_bloc/auth_status_bloc.dart';

const _messagesChild = "messages";
const _seenUserChild = "userSeen";
const _seenAdminChild = "adminSeen";

class RealTimeDataBaseRepository {
  final DatabaseReference reference = FirebaseDatabase.instance.ref();
  String get userId => AuthBloc.user.id;

  Future<bool> getSeenInfo() async {
    DataSnapshot data =
        await reference.child(userId).child(_seenUserChild).get();

    return (data.value as bool?) ?? false;
  }

  Future<void> setSeenInfo() async =>
      await reference.child(userId).update({_seenUserChild: false});

  Future<void> setAdminSeen() async =>
      await reference.child(userId).update({_seenAdminChild: true});

  void setCallback(Function(String key, Object value) callback) {
    reference.child(userId).child(_messagesChild).onChildAdded.listen((event) {
      callback(event.snapshot.key!, event.snapshot.value!);
    });
  }

  Future<List<DataSnapshot>> getMessages() async {
    DataSnapshot data =
        await reference.child(userId).child(_messagesChild).get();
    return data.children.toList();
  }

  Future<void> sendMessage(String id, Map<String, dynamic> data) async =>
      await reference.child(userId).child(_messagesChild).child(id).set(data);
}
