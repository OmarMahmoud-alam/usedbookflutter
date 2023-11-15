import 'package:get/get.dart';
import 'package:usedbookshop/models/usermodel.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/Sharedperference_h.dart';
import 'package:usedbookshop/view/loginEnglish.dart';

String? token;
String? token2;
const String mainUrlforlaravel =
    'https://usedbookshop.c1.is'; // "http://192.168.1.12:8080";
const String mainUrl = "$mainUrlforlaravel/api/";

const double containerlength = 200;
const double boxsizedlengthofsellpage = 50;
bool darkmode = false;

userModel?
    currentuser; 
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

void logout() async {
  print('logged out');
  await DioHelper2.getData(url: 'auth/logout', token: token!);
  //عايزين كمان نضيف جزء one signal
  Cachehelp.removedata(key: 'token');
  Get.deleteAll(force: true);
  token = null;
  token2 = null;
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
