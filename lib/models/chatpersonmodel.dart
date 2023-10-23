import 'package:usedbookshop/models/Lastmessage.dart';
import 'package:usedbookshop/models/usermodel.dart';

class ChatPersonmodel {
  late userModel user;
  late LastmessageModel message;

  ChatPersonmodel.fromjson(Map<String, dynamic> json) {
    if (json['users2'] != null) {
      user = userModel.fromjson(json['users2']);
    } else {
      user = userModel.fromjson(json['users1']);
    }
    message = LastmessageModel.fromjson(json["lastmessage"][0]);
  }

  ChatPersonmodel({
    required this.user,
  });
}
