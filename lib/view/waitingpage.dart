import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usedbookshop/models/usermodel.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/variable.dart';
import 'package:usedbookshop/view/home.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({super.key});
  Future<userModel> getcurentuser() async {
    var result = await DioHelper2.getData(url: 'userprofile', token: token!);
    return userModel.fromjson(result.data);
  }

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  void initState() {
    super.initState();
    start();
  }

  void start() async {
    currentuser ??= await widget.getcurentuser();

    await Future.delayed(Duration(seconds: 1));
    Get.offAll(() => Home());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/image/MainLogo.png'),
      ),
    );
  }
}
