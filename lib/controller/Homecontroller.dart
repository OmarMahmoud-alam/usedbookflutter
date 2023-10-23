import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:usedbookshop/models/bookmodel.dart';
import 'package:usedbookshop/models/usermodel.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/variable.dart';
import 'package:usedbookshop/utils/onesignal/onesignal.dart';

class Homecontroller extends GetxController {
  final PagingController<int, Book> pagingController =
      PagingController(firstPageKey: 1);
  final _pageSize = 10;
  var isLastPage = false;
  @override
  void onInit() async {
    currentuser ??= await getcurentuser();
    Get.log('2222');
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.onInit();
    // initPlatformState();
  }

  Future<userModel> getcurentuser() async {
    var result = await DioHelper2.getData(url: 'userprofile', token: token!);
    Get.log(result.data.toString());
    return userModel.fromjson(result.data);
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      print(2);

      final newItems = await getnewlistitem(pageKey, _pageSize);
      print(newItems[0].toString());
      print(3.5);

      //final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<List<Book>> getnewlistitem(pageKey, pageSize) async {
    List<Book> newItems = [];
    print(3);

    var result = await DioHelper2.getData(url: 'book', token: token, query: {
      "page_size": pageSize,
      "page": pageKey,
    });
    var arrayOfBooksInJson = result.data['books']['data'];
    var nextlink = result.data['books']['next_page_url'];
    print(nextlink);

    isLastPage = (nextlink == null);
    for (var book in arrayOfBooksInJson) {
      Book item = Book.fromjson(book);
      newItems.add(item);
    }
    print(newItems[0].tostring());
    return newItems;
  }
}
