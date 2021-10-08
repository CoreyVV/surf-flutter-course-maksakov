import 'package:places/data/model/place.dart';
import 'package:places/data/repository/api_place.dart';

class PlaceMapper {
  static Place fromApi(ApiPlace place) {
    return Place(
      id: place.id,
      name: place.name,
      lat: place.lat,
      lon: place.lng,
      urls: place.urls,
      description: place.description,
      placeType: place.placeType,
    );
  }
}


