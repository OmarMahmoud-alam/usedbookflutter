import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:usedbookshop/models/bookdetailsmodel.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/variable.dart';

class Bookdetailscontroller extends GetxController implements GetxService {
  final String id;
  List<String> banner = [];
  late List<Widget> categorieswidget;
  late BookDetails bookalldata;
  int categorylength = 0;
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
    if (bookalldata.image != null) {
      banner = bookalldata.image!;
    } else {
      banner.add(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYjKwYPI1gdldEX46vAS1TWadwhS_RpEkl9Q&usqp=CAU');
    }
    categorieswidget = bookalldata.book.categories.map((e) {
      return Card(
          margin: const EdgeInsets.only(right: 5),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(e.name),
          ));
    }).toList();
    categorylength = bookalldata.book.categories.length;

    update();
  }
}
