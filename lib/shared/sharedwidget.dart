import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:usedbookshop/models/usermodel.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/variable.dart';
import 'package:usedbookshop/utils/geolocation/geolocation.dart';
import 'package:usedbookshop/utils/launcher/launcher.dart';
import 'package:usedbookshop/view/chat/chat.dart';
import 'package:usedbookshop/view/chat/chatlistview.dart';
import 'package:usedbookshop/view/home.dart';
import 'package:usedbookshop/view/sellbookcopy.dart';
import 'package:usedbookshop/view/setting/setting2.dart';

Future<dynamic> addAddresse(controller1) {
  return Get.defaultDialog(
      title: 'ADD Addresse',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 32.0,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextField(
                  controller: controller1.latcontroller,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      labelText: 'Latidute',
                      hintMaxLines: 1,
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 4.0))),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: TextField(
                  controller: controller1.longcontroller,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      labelText: 'longitude',
                      hintMaxLines: 1,
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 4.0))),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextButton(
              onPressed: () async {
                print(200);
                var postion = await getGeoLocationPosition();
                if (postion != null) {
                  print("${postion.latitude} ${postion.longitude}");
                  controller1.latcontroller.text = postion.latitude.toString();
                  controller1.longcontroller.text =
                      postion.longitude.toString();
                } else {
                  print('no points');
                }
              },
              child: const Text('my location ')),
          const SizedBox(
            height: 30.0,
          ),
          Center(
            child: Row(
              children: [
                const SizedBox(width: 15),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'cancel',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () async {
                    var result = await DioHelper2.postData(
                        url: 'addresse',
                        token: token,
                        data: {
                          "long": controller1.longcontroller.text,
                          "lat": controller1.latcontroller.text,
                        });
                    if (result.data['message'] == 'Success') {
                      Get.back();
                      Get.snackbar('address', 'have done',
                          backgroundColor: Colors.green);
                    } else {
                      Get.snackbar('address', 'error happened pls try again',
                          backgroundColor: Colors.red);
                    }
                  },
                  child: const Text(
                    'Add addresse',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
          )
        ],
      ),
      radius: 10.0);
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    this.width = double.infinity,
    this.childwidget = const SizedBox(),
    this.background = Colors.blue,
    this.isUpperCase = true,
    this.radius = 3.0,
    this.noWidget = true,
    required this.function,
    required this.text,
  });
  final double width;
  final Color background;
  final bool isUpperCase;
  final double radius;
  final VoidCallback function;
  final String text;
  final bool noWidget;

  final Widget childwidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 41.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: (noWidget)
            ? Text(
                isUpperCase ? text.toUpperCase() : text,
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            : childwidget,
      ),
    );
  }
}

class MainBottomBar extends StatelessWidget {
  final userModel user;

  const MainBottomBar({
    Key? key,
    required this.user,
    // required this.icons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.withOpacity(0),
      child: Container(
        margin: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(60),
          // borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          InkWell(
            onTap: () async {
              print('sms');

              if (user.phone == null) {
                Fluttertoast.showToast(msg: 'he doesn\'t have a mobile number');
              } else {
                await Launcher.makesms(user.phone!);
              }
            },
            child: const Row(
              children: [
                Icon(
                  Icons.sms_outlined,
                  size: 26,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('SMS')
              ],
            ),
          ),
          InkWell(
            onTap: () {
              print('chat');
              if (user.id == currentuser!.id) {
                Get.snackbar('chat', 'you can\'t chat with you self ',
                    backgroundColor: Colors.red);
              } else {
                Get.to(() => ChatScreen(), arguments: user.id);
              }
            },
            child: const Row(
              children: [
                Icon(
                  Icons.forum_outlined,
                  size: 26,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('chat')
              ],
            ),
          ),
          InkWell(
            onTap: () {
              print('4');
              if (user.phone == null) {
                Fluttertoast.showToast(msg: 'he doesn\'t have a mobile number');
              } else {
                Launcher.makePhoneCall(user.phone!);
              }
            },
            child: const Row(
              children: [
                Icon(
                  Icons.phone,
                  size: 26,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('call')
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

void showInSnackBar(BuildContext context, String value) {
  // The value passed to Navigator.pop() or null.
  //ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        value,
      ),
    ),
  );
}

class defaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final ValueChanged<String>? onSubmit;
  final InputBorder border;
  final ValueChanged<String>? onChange;
  final GestureTapCallback? onTap;
  final bool isPassword;
  final FormFieldValidator<String> validate;
  final void Function(PointerDownEvent)? tapout;
  final String? label;
  final String? hint;
  final Widget? prefix;
  final IconData? suffix;
  final Function()? suffixPressed;
  final bool isClickable;
  final Color? fillcolor;
  const defaultFormField({
    super.key,
    required this.controller,
    this.tapout,
    this.fillcolor = Colors.white,
    required this.type,
    this.onSubmit,
    this.border = const OutlineInputBorder(),
    this.onChange,
    this.onTap,
    this.isPassword = false,
    required this.validate,
    this.label,
    this.hint,
    this.prefix,
    this.suffix,
    this.suffixPressed,
    this.isClickable = true,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onTapOutside: tapout,
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTap,
        validator: validate,
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          fillColor: fillcolor,
          labelText: label,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: prefix,
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffix,
                  ),
                )
              : null,
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(
                  width: 1, color: Color.fromARGB(255, 75, 207, 150))),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 75, 207, 150),
            ),
          ),
        ));
  }
}

class Maindrawer extends StatelessWidget {
  const Maindrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.

        padding: EdgeInsets.zero,

        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.green),
              accountName: Text(
                currentuser!.name.toString(),
                style: const TextStyle(fontSize: 18),
              ),
              accountEmail: Text(currentuser!.email),
              currentAccountPictureSize: const Size.square(60),
              currentAccountPicture: CircleAvatar(
                  //  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(currentuser!.imageurl ??
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnmNlNjIVoEaTFGsCD0l4O0EfejvHUiWKKwL02aircxA2mci75RwrgXwhIbdYTmYm9f-8&usqp=CAU")
                  //Text
                  ), //circleAvatar
            ), //UserAccountDrawerHeader
          ), //DrawerHeader
          ListTile(
            leading: const Icon(
              Icons.home,
            ),
            title: const Text('Buy Books'),
            onTap: () {
              Get.offAllNamed('/home');
              // Get.off(() => Home());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.sell_rounded,
            ),
            title: const Text('sell my book'),
            onTap: () {
              Get.to(() => SellBookMain());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.chat,
            ),
            title: const Text('chat'),
            onTap: () {
              Get.off(() => ListChatView());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
            ),
            title: const Text('setting'),
            onTap: () {
              Get.to(() => Settingapp());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
            ),
            title: const Text('Logout'),
            onTap: () {
              // Get.off(() => Settingapp());
              logout();
            },
          ),
        ],
      ),
    );
  }
}

/*
Future<bool?> toast({
  required String txt,
  color = Colors.red,
  time = 1,
}) {
  return Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: time,
      backgroundColor: color,
      textColor: Colors.green,
      fontSize: 16.0);
}

Future<dynamic> navigateto({required context, required Widget widget}) async =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

*/

class MainButton extends StatelessWidget {
  MainButton({
    super.key,
    this.width = double.infinity,
    this.background = Colors.blue,
    this.isUpperCase = true,
    this.radius = 21.0,
    required this.function,
    required this.text,
  });
  final double width;
  final Color background;
  final bool isUpperCase;
  final double radius;
  void Function()? function;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 9, horizontal: 50),
      width: width,
      height: 41.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class QwalGWidget extends StatelessWidget {
  const QwalGWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/image/qwaflG.png");
  }
}

class NoPaddingCheckbox extends StatelessWidget {
  final bool isMarked;
  final Function(bool newValue) onChange;
  final double size;

  const NoPaddingCheckbox({
    super.key,
    required this.isMarked,
    required this.onChange,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size, maxWidth: size),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Icon(_getIconData(), size: size),
        onPressed: () => onChange(!isMarked),
      ),
    );
  }

  IconData _getIconData() {
    if (isMarked) {
      return Icons.check_box;
    }

    return Icons.check_box_outline_blank;
  }
}

class _CheckboxDemo extends StatefulWidget {
  @override
  _CheckboxDemoState createState() => _CheckboxDemoState();
}

class _CheckboxDemoState extends State<_CheckboxDemo> with RestorationMixin {
  RestorableBoolN checkboxValueA = RestorableBoolN(true);

  @override
  String get restorationId => 'checkbox_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(checkboxValueA, 'checkbox_a');
  }

  @override
  void dispose() {
    checkboxValueA.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: checkboxValueA.value,
          onChanged: (value) {
            setState(() {
              checkboxValueA.value = value;
            });
          },
        ),
      ],
    );
  }
}

class MapsSheet2 {
  static show({
    required Function(AvailableMap map) onMapTap,
  }) async {
    final availableMaps = await MapLauncher.installedMaps;

    // ignore: use_build_context_synchronously
    Get.bottomSheet(SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => onMapTap(map),
                        title: Text(map.mapName),
                        /* leading: SvgPicture.asset(
                              map.icon,
                              height: 30.0,
                              width: 30.0,
                            ),*/
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class MapsSheet {
  static show({
    required BuildContext context,
    required Function(AvailableMap map) onMapTap,
  }) async {
    final availableMaps = await MapLauncher.installedMaps;

    // ignore: use_build_context_synchronously
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Wrap(
                      children: <Widget>[
                        for (var map in availableMaps)
                          ListTile(
                            onTap: () => onMapTap(map),
                            title: Text(map.mapName),
                            /* leading: SvgPicture.asset(
                              map.icon,
                              height: 30.0,
                              width: 30.0,
                            ),*/
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
