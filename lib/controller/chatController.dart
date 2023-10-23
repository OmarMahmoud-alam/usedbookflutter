import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:usedbookshop/models/chatmessageModel.dart';
import 'package:usedbookshop/models/usermodel.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/variable.dart';
import 'package:usedbookshop/utils/laravel_echo.dart';

class ChatController extends GetxController {
  final _pageSize = 10;
  var isLastPage = false;
  int nextpage = 1;
  String otheruserid;
  List<ChatMessage> messagesList = [];
  late String chat_id;
  @override
  ChatController({
    required this.otheruserid,
  });
  void onInit() {
    // LoadMoreChatMessage();

    LaravelEcho.init(token: token2!);
    listener();
    super.onInit();
    LoadMoreChatMessage();
  }

  @override
  void dispose() {
    LaravelEcho.instance.disconnect();
    leaveChatChannel();
    Get.delete<ChatController>();
    super.dispose();
  }

  void listener() {
    //  var instance = LaravelEcho.instance;
    // PrivateChannel channel = instance.private('chat.${chat_id}');
    if (int.parse(otheruserid) > currentuser!.id) {
      chat_id = otheruserid + currentuser!.id.toString();
    } else {
      chat_id = currentuser!.id.toString() + otheruserid;
    }
    // while (true) {
    print('59 ' + chat_id);
    //await Future.delayed(Duration(milliseconds: 500));

    LaravelEcho.instance.private('chat.${chat_id}').listen('.message.sent',
        (e) {
      print('das');
      if (e is PusherEvent) {
        print('dassss');

        if (e.data != null) {
          _handleNewMessage(jsonDecode(e.data!));
        }
      }
    }).error((err) {
      print('sdad' + err);
    });
    //s  sleep(Duration(seconds: 5));
    //   yield 5;
    // }

    //
  }

  void _handleNewMessage(Map<String, dynamic> data) {
    final chatMessage = chatmessageModel.fromjson(data['message']);
    messagesList = [chatMessage.toChatMessage, ...messagesList];
    update();
  }

  void leaveChatChannel() {
    try {
      LaravelEcho.instance.leave('chat.${chat_id}');
    } catch (err) {
      print("Error Leaving Channel $err");
    }
  }

  void LoadMoreChatMessage() async {
    if (isLastPage) {
      print("enter the last page");

      Fluttertoast.showToast(msg: 'no more message');
    } else {
      print("before enter the getChatMessages");

      final result = await getChatMessages(
        page: nextpage,
      );

      if (result.isNotEmpty) {
        messagesList.addAll(result);
        update();
      } else {}
    }
  }

  Future<List<ChatMessage>> getChatMessages({
    required int page,
  }) async {
    List<ChatMessage> messagesList2 = [];
    final response = await DioHelper2.getData(
      token: token,
      url: 'getmessage',
      query: {
        'page': page,
        'otheruser': otheruserid,
      },
    );
    print(response.data["message "]);

    if (response.data["message "] == "succes") {
      print('12345');
      chatmessageModel? temp;
      for (var element in response.data["data"]) {
        temp = chatmessageModel.fromjson(element);
        messagesList2.add(temp.toChatMessage);
      }
    }
    nextpage++;
    if (nextpage > response.data["total pages"]) isLastPage = true;
    return messagesList2;
  }

  void sendmessage(socketId, ChatMessage message) async {
    await createChatMessage(
        chatmessageModel(
          senderid: currentuser!.id,
          receiverid: int.parse(otheruserid),
          message: message.text,
        ),
        socketId);
  }

  Future<chatmessageModel?> createChatMessage(
    chatmessageModel request,
    String socketId,
  ) async {
    final response = await DioHelper2.postData(
      token: token,
      data: request.toJson(),
      socketId: socketId,
      url: '/message',
    );

    return (response.data['success'] != null)
        ? chatmessageModel.fromjson(response.data["message"])
        : null;
  }
}
