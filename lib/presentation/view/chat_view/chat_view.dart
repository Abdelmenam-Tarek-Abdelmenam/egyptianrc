import 'package:egyptianrc/bloc/auth_bloc/auth_status_bloc.dart';
import 'package:egyptianrc/data/models/app_user.dart';
import 'package:egyptianrc/presentation/resources/asstes_manager.dart';
import 'package:egyptianrc/presentation/resources/string_manager.dart';
import 'package:egyptianrc/presentation/shared/toast_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/chat_bloc/chat_bloc.dart';
import '../../../data/models/chat_model.dart';

class ChatView extends StatelessWidget {
  ChatView({this.user, Key? key}) : super(key: key);
  final AppUser? user;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  String get userId => AuthBloc.user.id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(user?.id),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          title: Text(
            user == null ? StringManger.chatWithRc : user?.name ?? "Guest",
            style: const TextStyle(color: Colors.red),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return Column(
              children: [
                Flexible(
                  child: state.status != ChatStatus.gettingInitial
                      ? state.messages.isNotEmpty
                          ? ListView.builder(
                              padding: const EdgeInsets.all(10),
                              itemBuilder: (context, index) =>
                                  buildItem(index, state.messages[index]),
                              itemCount: state.messages.length,
                              reverse: true,
                              controller: listScrollController,
                            )
                          : const Center(child: Text(StringManger.noMessage))
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
                buildInput(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildItem(int index, MessageChat messageChat) {
    bool myMessage = messageChat.idFrom.toLowerCase() == userId.toLowerCase();
    if (user == null ? myMessage : !myMessage) {
      // Right (my message)
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            width: 200,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8)),
            margin: const EdgeInsets.only(bottom: 20, right: 10),
            child: Text(
              messageChat.content,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      );
    } else {
      return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Material(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(18),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(
                    AssetsManager.logo,
                    width: 35,
                    height: 35,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8)),
                  margin: const EdgeInsets.only(left: 10),
                  child: Text(
                    messageChat.content,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            // Time
            if (index == 0)
              Container(
                margin: const EdgeInsets.only(right: 50, top: 10, bottom: 5),
                child: Text(
                  messageChat.timestamp,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontStyle: FontStyle.italic),
                ),
              ),
          ],
        ),
      );
    }
  }

  Widget buildInput(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.red, width: 0.5)),
          color: Colors.white),
      child: Row(
        children: <Widget>[
          // Edit text
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                onSubmitted: (value) => onSendMessage(context),
                style: const TextStyle(color: Colors.black, fontSize: 15),
                controller: textEditingController,
                decoration: const InputDecoration.collapsed(
                  hintText: StringManger.writeMessage,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                autofocus: true,
              ),
            ),
          ),

          // Button send message
          Material(
            color: Colors.red,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              color: Colors.red,
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  return state.status == ChatStatus.sendingMessage
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () => onSendMessage(context));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onSendMessage(BuildContext context) {
    if (textEditingController.text.trim().isNotEmpty) {
      context
          .read<ChatBloc>()
          .add(SendMessagesEvent(textEditingController.text));
      textEditingController.clear();
      if (listScrollController.hasClients) {
        listScrollController.animateTo(0,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
      showToast(StringManger.emptyMessage);
    }
  }
}
