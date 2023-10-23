import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:usedbookshop/shared/variable.dart';
import 'package:usedbookshop/view/chat/chatlistview.dart';
import 'package:usedbookshop/view/home.dart';
import 'package:usedbookshop/view/sellbookcopy.dart';
import 'package:usedbookshop/view/setting/setting2.dart';

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
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          fillColor: fillcolor,
          labelText: label,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
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
          focusedBorder: OutlineInputBorder(
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
            decoration: BoxDecoration(
              color: Colors.green,
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              accountName: Text(
                currentuser!.name.toString(),
                style: TextStyle(fontSize: 18),
              ),
              accountEmail: Text(currentuser!.email),
              currentAccountPictureSize: Size.square(60),
              currentAccountPicture: CircleAvatar(
                  //  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(currentuser!.imageurl ??
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnmNlNjIVoEaTFGsCD0l4O0EfejvHUiWKKwL02aircxA2mci75RwrgXwhIbdYTmYm9f-8&usqp=CAU")
                  //Text
                  ), //circleAvatar
            ), //UserAccountDrawerHeader
          ), //DrawerHeader
          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: const Text('Buy Books'),
            onTap: () {
              Get.off(() => Home());
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
              Get.off(() => Settingapp());
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
