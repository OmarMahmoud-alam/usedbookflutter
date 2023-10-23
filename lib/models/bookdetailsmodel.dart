import 'package:usedbookshop/models/Addressemodel.dart';
import 'package:usedbookshop/models/Categorymodel.dart';
import 'package:usedbookshop/models/bookmodel.dart';
import 'package:usedbookshop/models/usermodel.dart';

class BookDetails {
  late Book book;
  late userModel seller;
  //late DateTime createdAt;
  List<String>? image;
  late bool favourite;
  late List<CategoryModul> categories;
//  late Addresses addresses;

  BookDetails.fromjson(Map<String, dynamic> json) {
    this.book = Book.fromjson(json);
    this.seller = userModel.fromjson(json["users"]);
    if (json["image"] != null) {
      image = [];
      for (var oneimage in json["image"]) {
        image!.add(oneimage.toString());
      }
    }
    this.favourite = json["favourite"];
    // addresses = Addresses.fromjson(json['address']);
  }

  BookDetails({
    required this.book,
    this.image,
    required this.categories,
    required this.favourite,
    // required this.addresses,
  });

  tostring() {
    //return 'Book{id: $id, userId: $userId, bookname: $bookname, author: $author, status: $status}';
  }
}
