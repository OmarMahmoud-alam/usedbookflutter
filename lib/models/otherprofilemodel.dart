import 'package:usedbookshop/models/prevbookmodel.dart';
import 'package:usedbookshop/models/usermodel.dart';

class Otheruser {
  late userModel user;
  late List<PrevBook> books;
  late int booknumber;

  Otheruser.fromjson(Map<String, dynamic> json) {
    user = userModel.fromjson(json);
    books = [];
    booknumber = json["booksnumber"];
    if (json["books"] != null) {
      var json_book = json["books"];
      for (Map<String, dynamic> element in json_book) {
        books.add(PrevBook.fromjson(element));
      }
    }
  }

  Otheruser({
    required this.user,
    required this.books,
  });
}
