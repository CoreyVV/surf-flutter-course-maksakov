import 'package:mobx/mobx.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';

part 'place_list_store.g.dart';

class PlaceListStore = PlaceListStoreBase with _$PlaceListStore;

abstract class PlaceListStoreBase with Store {
  final PlaceInteractor placeInteractor;

  @observable
  ObservableFuture<List<Place>>? getListPlacesFuture;

  PlaceListStoreBase(this.placeInteractor);

  @action
  void getListPlaces() {
    final future = placeInteractor.getListPlaces;
    getListPlacesFuture = ObservableFuture(future);
  }

}