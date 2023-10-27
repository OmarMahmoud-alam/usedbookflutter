import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:usedbookshop/models/bookdetailsmodel.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/variable.dart';

import '../utils/geolocation/geolocation.dart';

class Bookdetailscontroller extends GetxController implements GetxService {
  final String id;
  List<String> banner = [];
  late List<Widget> categorieswidget;
  late BookDetails bookalldata;
  int categorylength = 0;
 List< String?>? addresseString;
  Bookdetailscontroller({
    required this.id,
  });
  @override
  void onInit() {
    // TODO: implement onInit
    bookdata();
    super.onInit();
  }

  void bookdata() async {
    var result = await DioHelper2.getData(
      url: 'book/${id.toString()}',
      token: token,
    );
    var arrayOfBooksInJson = result.data['data'];
    bookalldata = BookDetails.fromjson(arrayOfBooksInJson);
    if (bookalldata.image != null && bookalldata.image!.isNotEmpty) {
      Get.log(bookalldata.image!.length.toString());
      banner = bookalldata.image!;
    } else {
      banner.add(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYjKwYPI1gdldEX46vAS1TWadwhS_RpEkl9Q&usqp=CAU');
    }
    categorylength = bookalldata.book.categories.length;

    update();
    addresseString = await GetAddressFromLatLong(
        double.parse(bookalldata.book.addresses.lat),
        double.parse(bookalldata.book.addresses.long));
    update();
  }
}
