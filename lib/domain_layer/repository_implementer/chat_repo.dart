import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:egyptianrc/data/error_state.dart';
import 'package:egyptianrc/data/models/chat_model.dart';
import 'package:egyptianrc/data/repositories/notification_repository.dart';
import 'package:egyptianrc/domain_layer/date_extensions.dart';
import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../bloc/auth_bloc/auth_status_bloc.dart';
import '../../data/data_sources/web_services/realtime_repository.dart';

class ChatRepository {
  final RealTimeDataBaseRepository repository = RealTimeDataBaseRepository();
  String get userId => AuthBloc.user.id;

  void getChatStream(Function(MessageChat) callback) => repository
      .setCallback((key, value) => callback(MessageChat.fromJson(value, key)));

  Future<Either<Failure, List<MessageChat>>> getMessages() async {
    try {
      List<DataSnapshot> data = await repository.getMessages();
      List<MessageChat> messages = data
          .map((e) => MessageChat.fromJson(e.value, e.key!))
          .toList()
        ..sort((a, b) => b.id.compareTo(a.id));
      await repository.setSeenInfo();
      AuthBloc.user.seen = false;
      return Right(messages);
    } on FirebaseException catch (err) {
      return Left(Failure.fromFirebaseCode(err.code));
    } catch (_) {
      return const Left(Failure(StringManger.messageReadError));
    }
  }

  Future<Either<Failure, MessageChat>> sendMessage(String content) async {
    try {
      MessageChat messageChat = MessageChat(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        idFrom: AuthBloc.user.id,
        timestamp: DateTime.now().formatDate,
        content: content,
      );

      await repository.sendMessage(messageChat.id, messageChat.toJson());
      await repository.setAdminSeen();
      NotificationSender().postData(
        sendData: {},
        title: "رساله جديده",
        body: content,
        receiver: "admin",
      );
      return Right(messageChat);
    } on FirebaseException catch (err) {
      return Left(Failure.fromFirebaseCode(err.code));
    } catch (_) {
      return const Left(Failure(StringManger.messageSendError));
    }
  }
}
