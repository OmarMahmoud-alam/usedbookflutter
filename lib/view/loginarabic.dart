import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usedbookshop/controller/logincontroller.dart';
import 'package:usedbookshop/extensions/colors.dart';
import 'package:usedbookshop/shared/sharedwidget.dart';
import 'package:usedbookshop/view/register.dart';

class Login extends StatelessWidget {
  Login({super.key});
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
                          child: GetBuilder<LoginController>(
                        builder: (_) => TextFormField(
                            textDirection: TextDirection.rtl,
                            controller: loginController.passwordcontroller,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: loginController.ispassword,
                            validator: (Value) {
                              String pattern =
                                  r'^(?=.*?[A-Z])(?=.*?[a-z]).{8}$';
                              RegExp regExp = new RegExp(pattern);
                              if (Value == null) {
                                return 'اكتب الرقم السري لو سمحت';
                              }
                              bool isValidpassword = regExp.hasMatch(Value);
                              //                              print("the password ${registercontroller.passwordcontroller}");
                              // ignore: unnecessary_null_comparison
                              if (!true) {
                                print("Not strong enough");
                                //                                showDialog(context: context ,builder:(BuildContext buildContext)=>AlertDialog(content: Text("not strong enough")));
                                return " كلمة السر يجب أن تحوي على الأق الثانية وعشرون حرفًا باستخدام احرف إبد  الصغيرة، أحرف متزايدة، وأرقام.";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                prefixIconConstraints:
                                    BoxConstraints(minWidth: 23, maxHeight: 20),
                                prefixIcon: GetBuilder<LoginController>(
                                  builder: (_) => GestureDetector(
                                      onTap: () {},
                                      child: Icon(loginController.ispassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined)),
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 2),
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
              Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SizedBox(
                width: double.infinity,
                // height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Spacer(),
                    TextButton(
                        onPressed: () {}, child: const Text('عمل حساب جديد')),
                    Text('لا تملك حساب'),
                  ],
                ),
              ),
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
