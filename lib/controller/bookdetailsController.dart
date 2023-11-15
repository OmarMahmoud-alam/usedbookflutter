import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  List<String?>? addresseString;
  bool loadfavourite = false;
  Bookdetailscontroller({
    required this.id,
  });
  @override
  void onInit() {
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

  void favourite() async {
    loadfavourite = true;
    update();

    if (bookalldata.favourite) {
      final response = await DioHelper2.postData(
        token: token,
        data: {'book_id': bookalldata.book.id},
        url: '/favourite',
      );

      if (response.data['status'] == 200) {
        Get.snackbar('Favourite', response.data["message"],
            backgroundColor: Colors.green);
        bookalldata.favourite = false;
      } else {
        if (response.data["error"] != null) {
          Get.snackbar('Favourite', response.data["error"],
              backgroundColor: Colors.red);
        } else {
          Get.snackbar('Favourite', 'something went wrong pls try again ',
              backgroundColor: Colors.red);
        }
      }
    } else {
      var response = await DioHelper2.deletedata(
          url: 'favourite/delete',
          token: token,
          query: {'book_id': bookalldata.book.id});
      Get.log(response.data.toString());
      if (response.data['status'] == 200) {
        Get.snackbar('Favourite', response.data["message"],
            backgroundColor: Colors.green);
        bookalldata.favourite = true;
      } else {
        Get.snackbar('Favourite', response.data["error"].toString(),
            backgroundColor: Colors.red);
      }
    }
    loadfavourite = false;

    update();
  }
}
