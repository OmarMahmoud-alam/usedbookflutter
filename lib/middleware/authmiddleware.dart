import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:usedbookshop/models/usermodel.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/variable.dart';

class AuthMiddleware extends GetMiddleware {
  /*Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    var _sigenedInUser = Get.find<GetSignedInUserInfoRepoImp>();
    bool _isSignedIn = await _sigenedInUser.isUserSignedIn();
    if (_isSignedIn) {
      return Get.rootDelegate.toNamed('/home');
    }else {
      return Get.rootDelegate.toNamed('/sign_in');
    }
    return await super.redirectDelegate(route);
  }
*/
  Future<userModel> getcurentuser() async {
    var result = await DioHelper2.getData(url: 'userprofile', token: token!);
    return userModel.fromjson(result.data);
  }

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    Get.log('enter AuthMiddleware ');

    currentuser = await getcurentuser();
    print("current user ${currentuser}");
    if (currentuser?.emailverifiedat == null) {
      // Get.log(authService.currentUser.value.isAuthenticated.toString());
      return Get.rootDelegate.toNamed('/verfyEmail');
    }
    return null;
  }
}
