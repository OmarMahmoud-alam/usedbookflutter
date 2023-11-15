
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usedbookshop/controller/RegisterController.dart';
import 'package:usedbookshop/extensions/colors.dart';
import 'package:usedbookshop/shared/sharedwidget.dart';
import 'package:usedbookshop/view/loginEnglish.dart';

class Register2 extends StatelessWidget {
  Register2({super.key});
  final Registercontroller registercontroller = Get.put(Registercontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: '#F0EEEE'.toColor(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
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
                      SizedBox(
                        width: 3,
                      ),
                      Image.asset('assets/image/personn.png'),
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
                                //    textDirection: TextDirection.rtl,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 5),
                                  hintText: 'name',
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Icon(
                        size: 21,
                        Icons.email_rounded,
                        color: Color.fromARGB(255, 2, 252, 23),
                      ),
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
                                // textDirection: TextDirection.rtl,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  hintText: 'Email',
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                      Image.asset('assets/image/lock.png'),
                      Expanded(
                          child: GetBuilder<Registercontroller>(
                        builder: (_) => TextFormField(
                            //     textDirection: TextDirection.rtl,
                            controller: registercontroller.passwordcontroller,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: registercontroller.ispassword,
                            validator: (value) {
                              /* String pattern =
                                  r'^(?=.*?[A-Z])(?=.*?[a-z]).{8}$';
                              RegExp regExp = RegExp(pattern);*/
                              if (value == null) {
                                return 'اكتب الرقم السري لو سمحت';
                              }
                              return null;
                              //bool isValidpassword = true;
                              //   bool isValidpassword = regExp.hasMatch(value);
                              //                              print("the password ${registercontroller.passwordcontroller}");
                              // ignore: unnecessary_null_comparison
                              // isValidpassword = true;

                              /*  if (!isValidpassword) {
                                log("Not strong enough");
                                //                                showDialog(context: context ,builder:(BuildContext buildContext)=>AlertDialog(content: Text("not strong enough")));
                                return " كلمة السر يجب أن تحوي على الأق الثانية وعشرون حرفًا باستخدام احرف إبد  الصغيرة، أحرف متزايدة، وأرقام.";
                              } else {
                                return null;
                              }*/
                            },
                            decoration: InputDecoration(
                              suffixIconConstraints:
                                  BoxConstraints(minWidth: 23, maxHeight: 20),
                              suffixIcon: InkWell(
                                  //padding: EdgeInsets.zero,
                                  onTap: () {
                                    registercontroller.ispassword =
                                        !registercontroller.ispassword;
                                    registercontroller.update();
                                  },
                                  child: Icon(
                                    registercontroller.ispassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    size: 20,
                                  )),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              hintText: ' password',
                            )),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 3,
                      ),
                      Image.asset('assets/image/lock.png'),
                      Expanded(
                          child: GetBuilder<Registercontroller>(
                        builder: (_) => TextFormField(
                            //  textDirection: TextDirection.rtl,
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
                              suffixIconConstraints:
                                  BoxConstraints(minWidth: 6, maxHeight: 10),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    registercontroller.ispassword2 =
                                        !registercontroller.ispassword2;
                                    registercontroller.update();
                                  },
                                  child: Icon(
                                    registercontroller.ispassword2
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    size: 20,
                                  )),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              hintText: 'confirm password ',
                            )),
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    // height: 50,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'I already have account',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size(50, 20),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                alignment: Alignment.centerLeft),
                            onPressed: () {
                              Get.offAll(() => Login2());
                            },
                            child: const Text(
                              ' sign in',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            )),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            GetBuilder<Registercontroller>(
              builder: (_) => registercontroller.isregisterload
                  ? const CircularProgressIndicator()
                  : MainButton(
                      function: () {
                        registercontroller.register();
                      },
                      text: 'register ',
                      background: '#03C988'.toColor(),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
