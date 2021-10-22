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
      //todo: не смог выполнить запрос с полным списком параметров
      // 'lat': lat,
      // 'lng': lng,
      // 'radius': radius,
      // 'typeFilter': typeFilter,
      'nameFilter': nameFilter,
    };
  }
}
