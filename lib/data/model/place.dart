class Place {
  String id;
  double lat;
  double lon;
  String name;
  List<String> urls;
  String placeType;
  String description;

  Place({
    required this.id,
    required this.lat,
    required this.lon,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });
}
