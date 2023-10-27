import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:usedbookshop/controller/bookdetailsController.dart';
import 'package:usedbookshop/extensions/colors.dart';
import 'package:usedbookshop/middleware/loginmiddleware.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/Sharedperference_h.dart';
import 'package:usedbookshop/shared/variable.dart';
import 'package:usedbookshop/view/bookdetailsView.dart';
import 'package:usedbookshop/view/chat/chat.dart';
import 'package:usedbookshop/view/chat/chatlistview.dart';
import 'package:usedbookshop/view/home.dart';
import 'package:usedbookshop/view/loginEnglish.dart';
import 'package:usedbookshop/view/otherprofileview.dart';
import 'package:usedbookshop/view/otp2.dart';
import 'package:usedbookshop/view/registerenglish.dart';
import 'package:usedbookshop/view/sellbookcopy.dart';
import 'package:usedbookshop/view/setting/setting2.dart';
import 'package:usedbookshop/view/waitingpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper2.init();
  await Cachehelp.init();
  /*await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });*/
  token2 = Cachehelp.getdata(key: 'token');
  if (token2 != null) token = 'Bearer ' + token2!;
  Get.log(token2 ?? '1222222');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(token);
    return GetMaterialApp(
      //  home: ListChatView(),
      theme: ThemeData(
        primaryColor: '#03C988'.toColor(),
        primarySwatch: Colors.lightGreen, //.withOpacity(0.1),
      ),
      initialRoute: '/',

      getPages: [
        GetPage(
            participatesInRootNavigator: true,
            name: '/',
            page: () => Login2(),
            middlewares: [LoginMiddleware()]),
        GetPage(
          name: '/register',
          page: () => Register2(),
          transition: Transition.downToUp,
        ),
        GetPage(
          name: '/waitingpage',
          page: () => WaitingPage(),
          transition: Transition.leftToRight,
          //     middlewares: [AuthMiddleware()]
        ),
        GetPage(
          name: '/home',
          page: () => Home(),
          transition: Transition.leftToRight,
          //     middlewares: [AuthMiddleware()]
        ),
        GetPage(
          name: '/setting',
          page: () => Settingapp(),
          transition: Transition.downToUp,
        ),
        GetPage(
          name: '/Listchat',
          page: () => ListChatView(),
          transition: Transition.downToUp,
        ),
        GetPage(
          name: '/chat',
          page: () => ChatScreen(),
          transition: Transition.downToUp,
        ),
        GetPage(
          name: '/userprofile',
          page: () => Otherprofileview(),
          transition: Transition.downToUp,
        ),
        GetPage(
            name: '/onebook',
            page: () => OnebookView(),
            transition: Transition.downToUp,
            binding: BindingsBuilder(() {
              Get.lazyPut<Bookdetailscontroller>(
                () => Bookdetailscontroller(id: Get.arguments.toString()),
                fenix: true,
              );
            })),
        GetPage(
          name: '/verfyEmail',
          page: () => Otp2(),
          transition: Transition.downToUp,
        ),
        GetPage(
          name: '/sellbook',
          page: () => SellBookMain(),
          transition: Transition.downToUp,
        ),
      ],
      debugShowCheckedModeBanner: false,
      /*  navigatorObservers: [
        GetObserver(MiddleWare.observer), // Attach middleware observer
      ],*/
    );
  }
}
