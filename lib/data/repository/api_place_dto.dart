class ApiPlaceDto {
  int id;
  double lat;
  double lng;
  double distance;
  String name;
  List<String> urls;
  String placeType;
  String description;

  ApiPlaceDto.fromApi(Map<String, dynamic> map)
      : id = map['id'] as int,
        lng = map['lng'] as double,
        lat = map['lat'] as double,
        // distance = map['distance'] as double,
        distance = 9999.99,
        name = map['name'] as String,
        urls = List<String>.from(map['urls'] as List),
        placeType = map['placeType'] as String,
        description = map['description'] as String;
}
