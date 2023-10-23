import 'dart:developer';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:usedbookshop/models/chatpersonmodel.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/variable.dart';

class ListchatController extends GetxController {
  late List<ChatPersonmodel> chats;
  late bool chatlistintial = false;
  @override
  void onInit() async {
    chats = [];
    ChatPersonmodel cpm;
    var result = await DioHelper2.getData(url: 'getchats', token: token);
    print(result.data);
    if (result.data['status'] == '200') {
      print(100);
      for (var element in result.data['data']['1']) {
        cpm = ChatPersonmodel.fromjson(element);
        chats.add(cpm);
      }
      for (var element in result.data['data']['2']) {
        cpm = ChatPersonmodel.fromjson(element);
        chats.add(cpm);
      }
    }
    print(chats.toString());
    chatlistintial = true;
    update();
    super.onInit();
  }
}
