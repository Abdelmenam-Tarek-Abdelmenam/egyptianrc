part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final ChatStatus status;
  final List<MessageChat> messages;

  const ChatState({
    required this.status,
    required this.messages,
  });

  factory ChatState.initial() {
    return const ChatState(status: ChatStatus.idle, messages: []);
  }

  ChatState copyWith({ChatStatus? status, List<MessageChat>? messages}) {
    return ChatState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
    );
  }

  ChatState addMessage(MessageChat message) {
    return ChatState(
      status: ChatStatus.idle,
      messages: [message, ...messages],
    );
  }

  @override
  List<Object?> get props => [status, messages.length];
}

enum ChatStatus {
  sendingMessage,
  gettingInitial,
  error,
  idle,
}
