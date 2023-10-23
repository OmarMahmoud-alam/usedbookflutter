import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:usedbookshop/shared/variable.dart';

class LoginMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    Get.log('enter LoginMiddleware ');
    if (token != null) {
      // Get.log(authService.currentUser.value.isAuthenticated.toString());
      return const RouteSettings(name: '/home');
     /* Get.offAllNamed(
          "/home",
        );*/
    }
    print(token);
    return null;
  }
}
