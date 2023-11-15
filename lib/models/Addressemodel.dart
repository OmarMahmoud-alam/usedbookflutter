class Addresses {
  late int id;
  late int userId;
  late String long;
  late String lat;

  Addresses.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    long = json["long"];
    lat = json["lat"];
  }
  Addresses({
    required this.id,
    required this.userId,
    required this.long,
    required this.lat,
  });

  Addresses copyWith({
    int? id,
    int? userId,
    String? long,
    String? lat,
  }) =>
      Addresses(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        long: long ?? this.long,
        lat: lat ?? this.lat,
      );
  String toString2() {
    //  implement toString
    return 'the lat =$lat and the long=$long';
  }

  @override
  String toString() {
    // implement toString
    return 'the lat =$lat ';
  }
}
