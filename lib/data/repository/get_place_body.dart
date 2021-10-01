class GetPlaceBody {
  final int id;
  final double lat;
  final double lng;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;

  GetPlaceBody({
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });

  Map<String, dynamic> toApi() {
    return <String, dynamic>{
      'id': id,
      'lat': lat,
      'lon': lng,
      'name': name,
      'urls': urls,
      'placeType': placeType,
      'description': description,
    };
  }
}
