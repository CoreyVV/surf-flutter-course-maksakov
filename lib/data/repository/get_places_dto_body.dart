class GetPlaceDtoBody {
  final double lat;
  final double lng;
  final double radius;
  final List<String> typeFilter;
  final String nameFilter;

  GetPlaceDtoBody({
    required this.lat,
    required this.lng,
    required this.radius,
    required this.typeFilter,
    required this.nameFilter,
  });

  Map<String, dynamic> toApi() {
    return <String, dynamic>{
      'lat': lat,
      'lon': lng,
      'distance': radius,
      'typeFilter': typeFilter,
      'nameFilter': nameFilter,
    };
  }
}
