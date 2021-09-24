class ApiPlace {
  String id;
  double lat;
  double lon;
  String name;
  List<String> urls;
  String placeType;
  String description;

  ApiPlace.fromApi(Map<String, dynamic> map)
      : id = map['id'].toString(),
        lon = map['lng'] as double,
        lat = map['lat'] as double,
        name = map['name'] as String,
        urls = List<String>.from(map['urls'] as List),
        placeType = map['placeType'] as String,
        description = map['description'] as String;
}
