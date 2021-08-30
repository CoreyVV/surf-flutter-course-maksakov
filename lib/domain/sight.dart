import 'package:places/mocks.dart';

class SightType {
  static final String cafe = 'cafe';
  static final String hotel = 'hotel';
  static final String museum = 'museum';
  static final String park = 'park';
  static final String particular_place = 'particular_place';
  static final String restourant = 'restourant';
}

class Sight {
  final String id;
  final String name;
  final double lat;
  final double lon;
  final String url;
  final String details;
  final List<String> images;
  final String type;

  Sight({
    this.id = '0005',
    required this.name,
    required this.lat,
    required this.lon,
    required this.url,
    required this.images,
    required this.details,
    required this.type,
  });

  static Sight? getSight(String id) {
    return mocks.where((sight) => (sight.id == id)).first;
  }
}
