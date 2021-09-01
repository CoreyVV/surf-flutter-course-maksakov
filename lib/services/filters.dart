import 'dart:core';
import 'dart:math';
import 'package:location/location.dart';

//проверка расстояния до места
Future<bool> checkSight(
  double checkPointLat,
  double checkPointLon,
  // double currentPointLat,
  // double currentPointLon,
  double distanceMin,
  double distanceMax,
) async {
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _currentPosition;
  final Location location = Location();

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return false;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return false;
    }
  }

  _currentPosition = await location.getLocation();

  print(_currentPosition);

  const double ky = 40000 / 360;
  final double kx = cos(pi * _currentPosition.latitude! / 180.0) * ky;
  final double dx = (_currentPosition.longitude! - checkPointLon).abs() * kx;
  final double dy = (_currentPosition.latitude! - checkPointLat).abs() * ky;

  return (sqrt(dx * dx + dy * dy) <= distanceMax) &&
      (sqrt(dx * dx + dy * dy) >= distanceMin);
}
