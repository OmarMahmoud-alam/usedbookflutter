import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:usedbookshop/shared/variable.dart';

class LoginMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (token != null) {
      print(token);

      // Get.log(authService.currentUser.value.isAuthenticated.toString());
      return const RouteSettings(name: "/waitingpage");
    }
    return null;
  }
}
