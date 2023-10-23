import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usedbookshop/controller/RegisterController.dart';
import 'package:usedbookshop/extensions/colors.dart';
import 'package:usedbookshop/shared/sharedwidget.dart';

class Register extends StatelessWidget {
  Register({super.key});
  final Registercontroller registercontroller = Get.put(Registercontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: '#F0EEEE'.toColor(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //  leading: Image.asset('assets/image/close.png'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const QwalGWidget(),
            const SizedBox(
              height: 77,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 21),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(17)),
              child: Form(
                key: registercontroller.formKey2,
                child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 30,
                          child: GetBuilder<Registercontroller>(
                            builder: (_) => TextFormField(
                                controller: registercontroller.namecontroller,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.length < 2) {
                                    return "name length must be 2 text or more ";
                                  } else {
                                    return null;
                                  }
                                },
                                textDirection: TextDirection.rtl,
                                decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 2),
                                    hintText: '  الاسم',
                                    hintTextDirection: TextDirection.rtl)),
                          ),
                        ),
                      ),
                      Image.asset('assets/image/person.png'),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 30,
                          child: GetBuilder<Registercontroller>(
                            builder: (_) => TextFormField(
                                controller: registercontroller.emailcontroller,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value == null) {
                                    return "please enter your email";
                                  }
                                  final bool emailValid = RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value);
                                  if (!emailValid) {
                                    return "Please enter a valid email";
                                  } else {
                                    return null;
                                  }
                                },
                                textDirection: TextDirection.rtl,
                                decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 2),
                                    hintText: '  الايميل',
                                    hintTextDirection: TextDirection.rtl)),
                          ),
                        ),
                      ),
                      Image.asset('assets/image/person.png'),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: GetBuilder<Registercontroller>(
                        builder: (_) => TextFormField(
                            textDirection: TextDirection.rtl,
                            controller: registercontroller.passwordcontroller,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: registercontroller.ispassword,
                            validator: (value) {
                              String pattern =
                                  r'^(?=.*?[A-Z])(?=.*?[a-z]).{8}$';
                              RegExp regExp = RegExp(pattern);
                              if (value == null) {
                                return 'اكتب الرقم السري لو سمحت';
                              }
                              bool isValidpassword = regExp.hasMatch(value);
                              //                              print("the password ${registercontroller.passwordcontroller}");
                              // ignore: unnecessary_null_comparison
                              isValidpassword = true;

                              if (!isValidpassword) {
                                log("Not strong enough");
                                //                                showDialog(context: context ,builder:(BuildContext buildContext)=>AlertDialog(content: Text("not strong enough")));
                                return " كلمة السر يجب أن تحوي على الأق الثانية وعشرون حرفًا باستخدام احرف إبد  الصغيرة، أحرف متزايدة، وأرقام.";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                prefixIconConstraints:
                                    BoxConstraints(minWidth: 23, maxHeight: 20),
                                prefix: GestureDetector(
                                    //padding: EdgeInsets.zero,
                                    onTap: () {
                                      //registercontroller.register();
                                    },
                                    child: Icon(registercontroller.ispassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined)),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 3),
                                hintText: '  كلمة مرور ',
                                hintTextDirection: TextDirection.rtl)),
                      )),
                      Image.asset('assets/image/lock.png'),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: GetBuilder<Registercontroller>(
                        builder: (_) => TextFormField(
                            textDirection: TextDirection.rtl,
                            controller:
                                registercontroller.confirmPassswordcontroller,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: registercontroller.ispassword2,
                            validator: (value) {
                              if (value == null ||
                                  value !=
                                      registercontroller
                                          .passwordcontroller.text) {
                                return "كلمة المرور غير مطابقه";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                prefixIconConstraints:
                                    BoxConstraints(minWidth: 23, maxHeight: 20),
                                prefix: IconButton(
                                    onPressed: () {
                                      //registercontroller.register();
                                    },
                                    icon: Icon(registercontroller.ispassword2
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined)),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 3),
                                hintText: '  كلمة مرور ',
                                hintTextDirection: TextDirection.rtl)),
                      )),
                      Image.asset('assets/image/lock.png'),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: const Text('نسيت كلمة المرور')),
                      const Spacer(),
                      const Text('تذكرني'),
                      NoPaddingCheckbox(
                        onChange: (bool newValue) {},
                        isMarked: false,
                      ),
                    ],
                  )
                ]),
              ),
            ),
            MainButton(
              function: () {
                registercontroller.register();
              },
              text: 'تسجيل الدخول',
              background: '#03C988'.toColor(),
            )
          ],
        ),
      ),
    );
  }
}
