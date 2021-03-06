class Place {
  int id;
  double lat;
  double lon;
  String name;
  List<String> urls;
  String placeType;
  String description;

  @override
  int get hashCode => super.hashCode;

  Place({
    required this.id,
    required this.lat,
    required this.lon,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });


  @override bool operator ==(Object other) {
    return other is Place && id == other.id;
  }
}
