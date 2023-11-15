
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/Sharedperference_h.dart';
import 'package:usedbookshop/shared/variable.dart';
import 'package:usedbookshop/view/otp2.dart';

class LoginController extends GetxController {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isloginLoad = false;
  bool ispassword = true;
  bool marked = false;

/*
  @override
  void onInit() {
    Get.log('what\'s the fuck');
    if (token != null) {
      Get.offAllNamed(
        "/home",
      );
    }
    super.onInit();
  }
*/
  void login() async {
    isloginLoad = true;
    update();
    if (formKey.currentState!.validate()) {
      var result = await DioHelper2.postData(url: 'auth/login', data: {
        "email": emailcontroller.text.trim(),
        "password": passwordcontroller.text
      });
      if (result.data['message'] == 'success') {
        token2 = result.data['accessToken'];
        token = 'Bearer ' + token2!;
        if (result.data["verify_at"] != null) {
          await Cachehelp.savestring(key: 'token', value: token2!);

          Get.offAllNamed(
            "/home",
          );
        } else {
          Get.to(() => Otp2(), arguments: emailcontroller.text.toString());
        }
      } else {
        Get.snackbar('error', result.data.toString(),
            backgroundColor: Colors.red, duration: const Duration(seconds: 5));
      }
    }
    isloginLoad = false;

    update();
  }
}
