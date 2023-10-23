import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:get/get.dart';
import 'package:usedbookshop/models/usermodel.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/Sharedperference_h.dart';
import 'package:usedbookshop/view/loginEnglish.dart';

String? token ;
String? token2 ;
const String mainUrl = "http://192.168.1.12:8080/api/";
const double containerlength = 200;
const double boxsizedlengthofsellpage = 50;
bool darkmode = false;

userModel?
    currentuser; /*= userModel(
    id: 5,
    name: "Omar",
    email: "omar.freecourse@gmail.com",
    phone: "01095513638",
    createdAt: DateTime.now(),
    numberrates: 3);*/
const List<String> statelist = [
  'none',
  'Alexandria',
  'Aswan',
  'Assiut',
  'Beheira',
  'Beni',
  'Suef',
  'Cairo',
  'Dakahlia',
  'Damietta',
  'Fayoum',
  'Gharbia',
  'Giza',
  'Ismailia',
  'Kafr',
  'el-Sheikh',
  'Matrouh',
  'Minya',
  'Menofia',
  'New Valley',
  'North Sinai',
  'Port Said',
  'Qualyubia',
  'Qena',
  'Red Sea',
  'Al-Sharqia',
  'Soha',
  'South Sinai',
  'Suez',
  'Luxor'
];

void logout() {
  print('logged out');
  DioHelper2.getData(url: 'auth/logout', token: token!);
  //عايزين كمان نضيف جزء one signal
  Cachehelp.removedata(key: 'token');
  Get.deleteAll(force: true);

  Get.offAll(() => Login2());
}

String timeAgo(DateTime d) {
  Duration diff = DateTime.now().difference(d);
  if (diff.inDays > 365) {
    return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  }
  if (diff.inDays > 30) {
    return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  }
  if (diff.inDays > 7) {
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  }
  if (diff.inDays > 0) {
    return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
  }
  if (diff.inHours > 0) {
    return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
  }
  if (diff.inMinutes > 0) {
    return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
  }
  return "just now";
}

String convertToAgo(DateTime input) {
  Duration diff = DateTime.now().difference(input);

  if (diff.inDays >= 1) {
    return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
  } else if (diff.inHours >= 1) {
    return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
  } else if (diff.inSeconds >= 1) {
    return '${diff.inSeconds} second${diff.inSeconds == 1 ? '' : 's'} ago';
  } else {
    return 'just now';
  }
}
