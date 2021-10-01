class ApiPlace {
  int id;
  double lat;
  double lng;
  String name;
  List<String> urls;
  String placeType;
  String description;

  ApiPlace.fromApi(Map<String, dynamic> map)
      : id = map['id'] as int,
        lng = map['lng'] as double,
        lat = map['lat'] as double,
        name = map['name'] as String,
        urls = List<String>.from(map['urls'] as List),
        placeType = map['placeType'] as String,
        description = map['description'] as String;
}
