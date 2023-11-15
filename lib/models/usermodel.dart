import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:get/get_core/src/get_main.dart';

class userModel {
  late int id;
  late String name;
  String? state;
  String? emailverifiedat;
  late String email;
  String? addressId;
  int? darkmode;
  String? phone;
  String? myrate;
  String? avragerate;
  int? numberrates;
  String? imageurl;
  late DateTime createdAt;

  userModel.fromjson(Map<String, dynamic> json) {
    Get.log(json.toString());
    id = json["id"];
    name = json["name"];
    emailverifiedat = json["email_verified_at"];
    email = json["email"];
    state = json["state"];
    darkmode = json["darkmode"];
    numberrates = json["numberofrating"];
    addressId = json["address_id"].toString();
    phone = json["phone"];
    myrate = json["myrate"].toString();
    Get.log(myrate.toString());

    avragerate = json["avergerate"];
    imageurl = json["image"];
    createdAt = DateTime.parse(json["created_at"]);
  }
  userModel copyWith({
    int? id,
    String? name,
    String? email,
    String? addressId,
    String? state,
    String? phone,
    String? avragerate,
    String? imageurl,
    bool? darkmode,
  }) =>
      userModel(
          id: id ?? this.id,
          state: state ?? this.state,
          name: name ?? this.name,
          darkmode: this.darkmode,
          email: email ?? this.email,
          addressId: addressId ?? this.addressId,
          phone: phone ?? this.phone,
          avragerate: avragerate ?? this.avragerate,
          imageurl: name ?? this.imageurl,
          numberrates: numberrates,
          createdAt: createdAt);

  userModel({
    required this.id,
    required this.name,
    required this.email,
    this.numberrates,
    this.addressId,
    this.darkmode = 0,
    this.phone,
    this.state,
    this.myrate,
    this.avragerate,
    this.imageurl,
    required this.createdAt,
  });
  ChatUser get toChatUser {
    if (imageurl != null) {
      return ChatUser(
        id: id.toString(),
        profileImage: imageurl,
        firstName: name,
      );
    } else {
      return ChatUser(
        id: id.toString(),
        firstName: name,
      );
    }
  }

  String getcreateat() {
    return "${this.createdAt.day}/${this.createdAt.month}/${this.createdAt.year}";
  }
}
