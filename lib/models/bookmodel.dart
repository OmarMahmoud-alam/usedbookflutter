import 'package:usedbookshop/models/Addressemodel.dart';
import 'package:usedbookshop/models/Categorymodel.dart';

class Book {
  late int id;
  late int userId;
  late String username;
  late String useremail;
  late String name;
  String? author;
  late String status;
  late String price;
  late String discription;
  //late String createdAt;
  late DateTime createdAt;
  String? image;
  late List<CategoryModul> categories;
  late Addresses addresses;

  Book.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    username = json["users"]["name"];
    useremail = json["users"]["email"];
    name = json["name"];
    author = json["author"] ?? 'no one';
    status = json["status"];
    price = json["price"];
    discription = json["discription"];
    createdAt = DateTime.parse(json["created_at"]);
    if (json["image"] != null) {
      image = json["image"][0];
    }
    categories = [];
    if (json["categories"] != null) {
      var json_categories = json["categories"];
      for (Map<String, dynamic> element in json_categories) {
        categories.add(CategoryModul.fromjson(element));
      }
    } else {
      print(id.toString());
    }
    addresses = Addresses.fromjson(json['addresses']);
  }

  Book({
    required this.id,
    required this.userId,
    required this.name,
    this.author,
    required this.status,
    required this.username,
    required this.useremail,
    required this.price,
    required this.discription,
    required this.createdAt,
    required this.image,
    required this.categories,
    // required this.addresses,
  });
  String getdate() {
    return "${this.createdAt.day}/${this.createdAt.month}/${this.createdAt.year}";
  }

  Book copyWith({
    int? id,
    int? userId,
    String? name,
    String? username,
    String? useremail,
    String? author,
    String? status,
    String? price,
    String? discription,
    DateTime? createdAt,
    dynamic image,
    List<CategoryModul>? categories,
    //Addresses? addresses,
  }) =>
      Book(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        username: username ?? this.username,
        useremail: useremail ?? this.useremail,
        author: author ?? this.author,
        status: status ?? this.status,
        price: price ?? this.price,
        discription: discription ?? this.discription,
        createdAt: this.createdAt,
        image: image ?? this.image,
        categories: categories ?? this.categories,
        //    addresses: addresses ?? this.addresses,
      );

  tostring() {
    return 'Book{id: $id, userId: $userId, name: $name, author: $author, status: $status}';
  }
}
