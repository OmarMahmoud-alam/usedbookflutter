import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/Sharedperference_h.dart';
import 'package:usedbookshop/shared/variable.dart';
import 'package:usedbookshop/view/home.dart';

class LoginController extends GetxController {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isloginLoad = false;
  bool ispassword = true;
  bool marked = false;
  void login() async {
    isloginLoad = true;
    update();
    if (formKey.currentState!.validate()) {
      print("Login button clicked");
      var result = await DioHelper2.postData(url: 'auth/login', data: {
        "email": emailcontroller.text.trim(),
        "password": passwordcontroller.text
      });
      if (result.data['message'] == 'success') {
        token2 = result.data['accessToken'];
        token = 'Bearer ' + token2!;

        print(result.toString());
        await Cachehelp.savestring(key: 'token', value: token!);
        Get.offAllNamed(
          "/home",
        );
      } else {
        Get.snackbar('error', result.data.toString(),
            backgroundColor: Colors.red, duration: const Duration(seconds: 5));
      }
    }
    isloginLoad = false;

    update();
  }
}
