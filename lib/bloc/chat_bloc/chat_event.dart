part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class GetInitialMessagesEvent extends ChatEvent {}

class SendMessagesEvent extends ChatEvent {
  final String text;

  const SendMessagesEvent(this.text);
  @override
  List<Object?> get props => [text];
}

class AddNewMessagesEvent extends ChatEvent {
  final MessageChat message;

  const AddNewMessagesEvent(this.message);
  @override
  List<Object?> get props => [message.id];
}
