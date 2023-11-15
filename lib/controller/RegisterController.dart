import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/variable.dart';
import 'package:usedbookshop/view/otp2.dart';

class Registercontroller extends GetxController {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController confirmPassswordcontroller =
      TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  bool ispassword = true;
  bool ispassword2 = true;
  bool isregisterload = false;

  void register() async {
    if (formKey2.currentState!.validate()) {
      log("Login button clicked");
      isregisterload = true;
      update();
      var result = await DioHelper2.postData(url: 'auth/register', data: {
        "name": namecontroller.text.trim(),
        "email": emailcontroller.text.trim(),
        "password": passwordcontroller.text,
        "c_password": confirmPassswordcontroller.text,
      });
      if (result.data['status'] == '422') {
        Get.snackbar('error', result.data["error"].toString());
        isregisterload = false;
        update();
      } else {
        token2 = result.data['accessToken'];

        String? message = result.data['message'];
        if (token2 != null) {
          token = 'Bearer ' + token2!;
        //  await Cachehelp.savestring(key: 'token', value: token!);
          Get.to(() => Otp2(), arguments: emailcontroller.text.toString());
        } else if (message != null) {
          Get.log(message);
        }
        isregisterload = false;
        update();

      }
    }
  }
}
