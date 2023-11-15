
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
//import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:usedbookshop/models/bookmodel.dart';
import 'package:usedbookshop/models/usermodel.dart';
import 'package:usedbookshop/shared/Dio_h.dart';
import 'package:usedbookshop/shared/variable.dart';

class Homecontroller extends GetxController {
  final PagingController<int, Book> pagingController =
      PagingController(firstPageKey: 1);
  final _pageSize = 10;
  var isLastPage = false;
  @override
  void onInit() async {
    currentuser ??= await getcurentuser();

    listenerpage();
    super.onInit();
    // initPlatformState();
  }

  void listenerpage() {
    pagingController.addPageRequestListener((pageKey) async {
      await fetchPage(pageKey);
    });
  }

  Future<userModel> getcurentuser() async {
    var result = await DioHelper2.getData(url: 'userprofile', token: token!);
    Get.log(result.data.toString());
    return userModel.fromjson(result.data);
  }

  Future<void> fetchPage(int pageKey) async {
    try {

      final newItems = await getnewlistitem(pageKey, _pageSize);

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

    var result = await DioHelper2.getData(url: 'book', token: token, query: {
      "page_size": pageSize,
      "page": pageKey,
    });
    var arrayOfBooksInJson = result.data['books']['data'];
    var nextlink = result.data['books']['next_page_url'];

    isLastPage = (nextlink == null);
    for (var book in arrayOfBooksInJson) {
      Book item = Book.fromjson(book);
      newItems.add(item);
    }
    return newItems;
  }
}
