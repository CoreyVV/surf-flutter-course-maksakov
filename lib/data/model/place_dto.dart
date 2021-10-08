class PlaceDto {
  int id;
  double lat;
  double lon;
  double distance;
  String name;
  List<String> urls;
  String placeType;
  String description;

  PlaceDto({
    required this.id,
    required this.lat,
    required this.lon,
    required this.distance,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });
}
