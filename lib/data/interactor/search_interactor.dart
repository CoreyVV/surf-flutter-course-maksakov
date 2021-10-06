import 'dart:core';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/repository/place_dto_repository.dart';
import 'package:places/services/location_service.dart';

final searchInteractor =
    SearchInteractor(placeDtoRepository: PlaceDtoRepository());

class SearchInteractor {
  final PlaceDtoRepository placeDtoRepository;
  final _history = <String>[];

  List<String> get getHistory => _history;

  SearchInteractor({
    required this.placeDtoRepository,
  });

  Future<List<PlaceDto>> searchPlacesByName(String nameFilter) async {
    final currentPosition = await LocationService().getCurrentPosition();
    final listPlaces = await placeDtoRepository.getFilteredPlaces(
      currentPosition.latitude!,
      currentPosition.longitude!,
      9999.99,
      [''],
      nameFilter,
    );
    listPlaces.sort((a, b) => a.distance.compareTo(b.distance));

    return listPlaces;
  }

  void addToHistory(String nameFilter) {
    if (!_history.contains(nameFilter)) {
      _history.add(nameFilter);
    }
  }

  void removeFromHistory(String nameFilter) {
    _history.remove(nameFilter);
  }

  void clearHistory() {
    _history.clear();
  }
}
