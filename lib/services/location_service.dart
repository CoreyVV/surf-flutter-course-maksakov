import 'dart:core';
import 'dart:math';
import 'package:location/location.dart';

class LocationService {
  Future<LocationData> getCurrentPosition() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    final defPosition = LocationData.fromMap(
      <String, dynamic>{'latitude': 51.6754966, 'longitude': 39.2088823},
    );
    final location = Location();

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return defPosition;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return defPosition;
      }
    }

    return location.getLocation();
  }


  double distanceTo(
    LocationData currentPosition,
    LocationData placePosition,
  ) {
    const earthRadiusKm = 6371;

    final dLat = _degreesToRadians(currentPosition.latitude! - placePosition.latitude!);
    final dLon = _degreesToRadians(currentPosition.longitude! - placePosition.longitude!);

    final lat1 = _degreesToRadians(placePosition.latitude!);
    final lat2 = _degreesToRadians(currentPosition.latitude!);

    final catA = sin(dLat/2) * sin(dLat/2) +
        sin(dLon/2) * sin(dLon/2) * cos(lat1) * cos(lat2);
    final gipC = 2 * atan2(sqrt(catA), sqrt(1-catA));

    return earthRadiusKm * gipC;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}
