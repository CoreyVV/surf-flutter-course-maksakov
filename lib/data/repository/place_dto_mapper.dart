import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/api_place_dto.dart';

class PlaceDtoMapper {
  static PlaceDto fromApi(ApiPlaceDto place) {
    return PlaceDto(
      id: place.id,
      name: place.name,
      lat: place.lat,
      lon: place.lng,
      distance: place.distance,
      urls: place.urls,
      description: place.description,
      placeType: place.placeType,
    );
  }
}
