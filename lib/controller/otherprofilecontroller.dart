import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:usedbookshop/models/otherprofilemodel.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/variable.dart';
import 'package:usedbookshop/utils/onesignal/onesignal.dart';

class OtherprofileController extends GetxController {
  late String userId;
  Otheruser? sellerUser;
  OtherprofileController({required this.userId});
  @override
  void onInit() async {
    var result = await DioHelper2.getData(
        url: 'otheruserprofile', token: token, query: {"user_id": userId});
    print(result.data);

    print(5555555);
    sellerUser = Otheruser.fromjson(result.data["data"]);
    update();

    super.onInit();
  }

  void giverate(int rate) async {
    //TODO::give rate to the other user
    var result = await DioHelper2.postData(
        url: 'rate',
        data: {"seller_id": sellerUser!.user.id, "rating": rate},
        token: token);
    if (result.data["status"] == 200) {
      // OneSignal().sendNotificationWithExtras("You have received a rating from ${Variable.loggedInUser?.name}",{"type":"
      Fluttertoast.showToast(
          msg: 'update rate success', backgroundColor: Colors.blue);
    } else {
      Fluttertoast.showToast(msg: 'update rate failed');
      if (result.data['error'] != null) {
        Fluttertoast.showToast(msg: result.data['error']);
      }
    }
  }
}
