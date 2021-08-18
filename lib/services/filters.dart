import 'dart:math';
import 'dart:core';

//проверка расстояния до места
bool checkSight(
  double checkPointLat,
  double checkPointLon,
  double currentPointLat,
  double currentPointLon,
  double distanceMin,
  double distanceMax,
) {
  var ky = 40000 / 360;
  var kx = cos(pi * currentPointLat / 180.0) * ky;
  var dx = (currentPointLon - checkPointLon).abs() * kx;
  var dy = (currentPointLat - checkPointLat).abs() * ky;
  return (sqrt(dx * dx + dy * dy) <= distanceMax) &&
      (sqrt(dx * dx + dy * dy) >= distanceMin);
}
