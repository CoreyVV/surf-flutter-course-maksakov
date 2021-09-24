import 'package:places/data/model/place.dart';
import 'package:places/data/repository/api_place.dart';

class PlaceMapper {
  static Place fromApi(ApiPlace place) {
    return Place(
      id: place.id,
      name: place.name,
      lat: place.lat as double,
      lon: place.lon as double,
      urls: place.urls,
      description: place.description,
      placeType: place.placeType,
    );
  }
}


