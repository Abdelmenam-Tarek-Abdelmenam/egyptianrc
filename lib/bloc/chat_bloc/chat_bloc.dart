import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:egyptianrc/data/models/chat_model.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

import '../../data/error_state.dart';
import '../../domain_layer/repository_implementer/chat_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState.initial()) {
    on<GetInitialMessagesEvent>(_getInitialDataHandler);
    on<AddNewMessagesEvent>(_addNewMessageHandler);
    on<SendMessagesEvent>(_sendNewMessageHandler);

    add(GetInitialMessagesEvent());
  }
  final ChatRepository _repository = ChatRepository();

  Future<void> _getInitialDataHandler(
      GetInitialMessagesEvent event, Emitter emit) async {
    print("getting data");
    emit(state.copyWith(status: ChatStatus.gettingInitial));
    Either<Failure, List<MessageChat>> value = await _repository.getMessages();
    value.fold((failure) {
      print("error");
      failure.show;
      emit(state.copyWith(status: ChatStatus.error));
    }, (right) {
      print("get");
      emit(state.copyWith(messages: right, status: ChatStatus.idle));
    });
    _repository.getChatStream((message) => add(AddNewMessagesEvent(message)));
  }

  void _addNewMessageHandler(AddNewMessagesEvent event, Emitter emit) {
    print("new messsage come ${event.message.content}");
    int index =
        state.messages.indexWhere((element) => element.id == event.message.id);
    print(index);
    if (index < 0) {
      emit(state.addMessage(event.message));
    }
  }

  Future<void> _sendNewMessageHandler(
      SendMessagesEvent event, Emitter emit) async {
    emit(state.copyWith(status: ChatStatus.sendingMessage));

    Either<Failure, MessageChat> value =
        await _repository.sendMessage(event.text);
    value.fold((failure) {
      failure.show;
      emit(state.copyWith(status: ChatStatus.error));
    }, (right) {
      int index =
          state.messages.indexWhere((element) => element.id == right.id);
      print(index);
      if (index < 0) {
        emit(state.addMessage(right));
      }
    });
  }
}
