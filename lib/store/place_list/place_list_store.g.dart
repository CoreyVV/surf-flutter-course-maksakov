// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlaceListStore on PlaceListStoreBase, Store {
  final _$getListPlacesFutureAtom =
      Atom(name: 'PlaceListStoreBase.getListPlacesFuture');

  @override
  ObservableFuture<List<Place>>? get getListPlacesFuture {
    _$getListPlacesFutureAtom.reportRead();
    return super.getListPlacesFuture;
  }

  @override
  set getListPlacesFuture(ObservableFuture<List<Place>>? value) {
    _$getListPlacesFutureAtom.reportWrite(value, super.getListPlacesFuture, () {
      super.getListPlacesFuture = value;
    });
  }

  final _$PlaceListStoreBaseActionController =
      ActionController(name: 'PlaceListStoreBase');

  @override
  void getListPlaces() {
    final _$actionInfo = _$PlaceListStoreBaseActionController.startAction(
        name: 'PlaceListStoreBase.getListPlaces');
    try {
      return super.getListPlaces();
    } finally {
      _$PlaceListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
getListPlacesFuture: ${getListPlacesFuture}
    ''';
  }
}
