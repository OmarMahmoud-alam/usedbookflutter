import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/Sharedperference_h.dart';
import 'package:usedbookshop/shared/variable.dart';
import 'package:usedbookshop/view/home.dart';

class Otp2 extends StatefulWidget {
  Otp2({super.key});
  final String email = Get.arguments ?? currentuser!.email;
  var otpController = OtpFieldController();
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp2> {
  final TextEditingController firstcontroller = TextEditingController();
  final TextEditingController secondcontroller = TextEditingController();
  final TextEditingController thirdcontroller = TextEditingController();
  final TextEditingController fourthcontroller = TextEditingController();
  late String otp = "";
  bool isverifyload = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              /*   Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/illustration-3.png',
                ),
              ),
           */
              SizedBox(
                height: 24,
              ),
              Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 28, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Center(
                      child: OTPTextField(
                          controller: widget.otpController,
                          length: 6,
                          width: MediaQuery.of(context).size.width,
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldWidth: 45,
                          fieldStyle: FieldStyle.box,
                          outlineBorderRadius: 15,
                          style: TextStyle(fontSize: 17),
                          onChanged: (pin) {},
                          onCompleted: (pin) {
                            print("Completed: " + pin);
                            otp = pin;
                          }),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: isverifyload
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  isverifyload = true;
                                });
                                print(widget.email);
                                print(otp);
                                if (otp.length < 6) {
                                  Get.snackbar('otp', 'complete otp pls');
                                } else {
                                  Get.log(widget.email);
                                  Get.log(otp);
                                  var result = await DioHelper2.postData(
                                      url: 'verifiedby/otp',
                                      token: token,
                                      data: {
                                        "email": widget.email,
                                        "otp": int.parse(otp)
                                      });
                                  if (result.data['code'] == 1) {
                                    print('done');
                                    Fluttertoast.showToast(
                                        msg: "email is verified");
                                    await Cachehelp.savestring(
                                        key: 'token', value: token2!);

                                    Get.to(() => Home());
                                  } else {
                                    setState(() {
                                      isverifyload = false;
                                    });
                                    Get.snackbar('otp', result.data.toString());
                                    print('dasdad');
                                    Fluttertoast.showToast(
                                        msg: "Something went wrong");
                                  }
                                }
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.purple),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Text(
                                  'Verify',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 18,
              ),
              InkWell(
                onTap: () async {
                  try {
                    var result = await DioHelper2.getData(
                        url: 'verify/otp/resend',
                        token: token,
                        query: {"email": widget.email});
                    if (result.data['code'] == 1) {
                      print('done');
                      Fluttertoast.showToast(msg: "email is verified");
                    } else {
                      setState(() {
                        isverifyload = false;
                      });
                      Get.snackbar('otp', result.data.toString());
                      print('dasdad');
                      Fluttertoast.showToast(msg: "Something went wrong");
                    }
                  } catch (e) {
                    Fluttertoast.showToast(msg: "Something went 22");
                    print('dasd' + e.toString());
                  }
                },
                child: const Text(
                  "Resend New Code",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
