import 'package:druto/models/hub.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

List<Hub> isLocationWithinAnyHub(
    {required List<Hub> hubs, required LatLng location}) {
  List<Hub> matchingHubs = [];
  for (final hub in hubs) {
    if (PolygonUtil.containsLocation(
      location,
      hub.polygonPoints
          .map((e) => LatLng(e.lat.toDouble(), e.lng.toDouble()))
          .toList(),
      false,
    )) {
      matchingHubs.add(hub);
    }
  }
  return matchingHubs;
}
