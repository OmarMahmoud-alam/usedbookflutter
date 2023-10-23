
class LastmessageModel {
  late int senderid;
  late int receiverid;
  late int chatid;
  late String message;
  late DateTime createdAt;

  LastmessageModel.fromjson(Map<String, dynamic> json) {
    senderid = json['sender_id'];
    receiverid = json['reciever_id'];
    chatid = json['chat_id'];
    message = json['message'];
    createdAt = DateTime.parse(json["created_at"]);
  }

  LastmessageModel({
    required this.senderid,
    required this.receiverid,
    required this.chatid,
    required this.message,
    required this.createdAt,
  });
  
}
