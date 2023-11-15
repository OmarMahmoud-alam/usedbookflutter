import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usedbookshop/controller/logincontroller.dart';
import 'package:usedbookshop/extensions/colors.dart';
import 'package:usedbookshop/shared/sharedwidget.dart';
import 'package:usedbookshop/view/registerenglish.dart';

class Login2 extends StatelessWidget {
  Login2({super.key});
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: '#F0EEEE'.toColor(),
      /*appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Image.asset('assets/image/close.png'),
      ),*/
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
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
                key: loginController.formKey,
                child: Column(children: [
                  Row(
                    children: [
                      Image.asset('assets/image/personn.png'),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 30,
                          child: GetBuilder<LoginController>(
                            builder: (_) => TextFormField(
                                controller: loginController.emailcontroller,
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
                                        horizontal: 2, vertical: 4),
                                    hintText: ' Email',
                                    hintTextDirection: TextDirection.ltr)),
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
                      Image.asset('assets/image/lock.png'),
                      Expanded(
                          child: GetBuilder<LoginController>(
                        builder: (_) => TextFormField(
                            //textDirection: TextDirection.rtl,
                            controller: loginController.passwordcontroller,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: loginController.ispassword,
                            validator: (Value) {
                              if (Value == null) {
                                return 'write the password pls';
                              }
                              return null;
                              /*  String pattern =
                                  r'^(?=.*?[A-Z])(?=.*?[a-z]).{8}$';
                              RegExp regExp = RegExp(pattern); 
                              bool isValidpassword = regExp.hasMatch(Value);
                              //                              print("the password ${registercontroller.passwordcontroller}");
                              // ignore: unnecessary_null_comparison
                             if (!true) {
                                print("Not strong enough");
                                //                                showDialog(context: context ,builder:(BuildContext buildContext)=>AlertDialog(content: Text("not strong enough")));
                                return " كلمة السر يجب أن تحوي على الأق الثانية وعشرون حرفًا باستخدام احرف إبد  الصغيرة، أحرف متزايدة، وأرقام.";
                              } else {
                                return null;
                              }*/
                            },
                            decoration: InputDecoration(
                              suffixIconConstraints:
                                  BoxConstraints(minWidth: 23, maxHeight: 20),

                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    loginController.ispassword =
                                        !loginController.ispassword;
                                    loginController.update();
                                  },
                                  child: Icon(loginController.ispassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined)),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 4),
                              hintText: '  password',
                              // hintTextDirection: TextDirection.rtl
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
                      NoPaddingCheckbox(
                        onChange: (bool newValue) {
                          loginController.marked = newValue;
                        },
                        isMarked: loginController.marked,
                      ),
                      const Text('remember me'),
                      const Spacer(),
                      TextButton(
                          onPressed: () {},
                          child: const Text('forget password')),
                    ],
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SizedBox(
                width: double.infinity,
                // height: 50,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      ' i don\'t have account',
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
                          Get.offAll(() => Register2());
                        },
                        child: const Text(
                          '  create account now ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GetBuilder<LoginController>(
              builder: (_) => MainButton(
                function: () {
                  loginController.login();
                },
                text: ' Log in',
                background: '#03C988'.toColor(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
