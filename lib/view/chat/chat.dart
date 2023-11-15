import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:get/get.dart';
import 'package:usedbookshop/controller/chatController.dart';

import 'package:usedbookshop/shared/variable.dart';
import 'package:usedbookshop/utils/laravel_echo.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final ChatController chatcontroller =
      Get.put(ChatController(otheruserid: Get.arguments.toString()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chats'),
        ),
        body: GetBuilder<ChatController>(
          builder: (_) => DashChat(
            currentUser: currentuser!.toChatUser,
            onSend: (ChatMessage chatMessage) {
              print(144);

              chatcontroller.sendmessage(LaravelEcho.socketId, chatMessage);
            },
            messages: chatcontroller.messagesList,
            messageListOptions: MessageListOptions(
              onLoadEarlier: () async {
                chatcontroller.LoadMoreChatMessage();

                /// Loads more messages
              },
            ),
          ),
        ));
  }
}
