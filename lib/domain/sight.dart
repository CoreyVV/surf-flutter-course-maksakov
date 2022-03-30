import 'package:places/mocks.dart';

class Sight {
  final String id;
  final String name;
  final double lat;
  final double lon;
  final String url;
  final String details;
  final List<String> images;
  final String type;
  final bool isVisited;
  final bool isPlanned;

  Sight({
    required this.name,
    required this.lat,
    required this.lon,
    required this.url,
    required this.images,
    required this.details,
    required this.type,
    this.isVisited = false,
    this.isPlanned = false,
    this.id = '0005',
  });

  static Sight? getSight(String id) {
    return mocks.where((sight) => sight.id == id).first;
  }
}

class SightType {
  static const String cafe = 'cafe';
  static const String hotel = 'hotel';
  static const String museum = 'museum';
  static const String park = 'park';
  static const String particularPlace = 'particular_place';
  static const String restaurant = 'restaurant';
}
