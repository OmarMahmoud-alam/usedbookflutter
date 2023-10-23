class CategoryModul {
  late int id;
  late String name;
  CategoryModul.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  CategoryModul({
    required this.id,
    required this.name,
  });

  CategoryModul copyWith({
    int? id,
    String? name,
  }) =>
      CategoryModul(
        id: id ?? this.id,
        name: name ?? this.name,
      );
}
