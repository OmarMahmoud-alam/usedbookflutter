import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:usedbookshop/models/usermodel.dart';

class chatmessageModel {
  int? senderid;
  int? receiverid;
  late String message;
  late userModel user;
  DateTime? createdAt;

  chatmessageModel.fromjson(Map<String, dynamic> json) {
    senderid = json["sender_id"];
    receiverid = json["reciever_id"];
    message = json["message"];
    user = userModel.fromjson(json["user"]);
    createdAt = DateTime.parse(json["created_at"]);
  }
  chatmessageModel({this.senderid, this.receiverid, required this.message});

  toJson() => <String, dynamic>{
        'reciever_id': receiverid,
        'message': message,
      };
  ChatMessage get toChatMessage {
    return ChatMessage(
      user: user.toChatUser,
      text: message,
      createdAt: createdAt!,
    );
  }
}
