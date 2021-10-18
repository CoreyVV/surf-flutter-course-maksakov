import 'dart:async';

import 'package:places/data/model/place.dart';

//сделал отдельный интерактор избранных мест
//Место добавляется в поток и метод привязанный к прослушиванию определяет
// действие и добавляет или удаляет место из списка избранных
class FavoritePlaceInteractor {
  final StreamController<Place> _placeFavoriteListController =
      StreamController.broadcast();
  final _listFavoritePlaces = <Place>[];

  List<Place> get getFavoritesPlaces => _listFavoritePlaces;

  void init() {
    _placeFavoriteListController.stream.listen(_listen);
  }

  void dispose() {
    _placeFavoriteListController.close();
  }
  //здесь добавляем место в поток
  void setFavorite(Place place) => _placeFavoriteListController.sink.add(place);

  bool isFavorite(Place place) {
    return _listFavoritePlaces.contains(place);
  }
  //обрабатываем
  void _listen(Place place) {
    !isFavorite(place) ? _addToFavorites(place) : _removeFromFavorites(place);
  }

  void _addToFavorites(Place place) {
    _listFavoritePlaces.add(place);
  }

  void _removeFromFavorites(Place place) {
    _listFavoritePlaces.remove(place);
  }
}
