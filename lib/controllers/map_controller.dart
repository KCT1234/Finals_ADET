import 'dart:async';
import 'dart:convert';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../models/location_model.dart';

class MapController {
  String accessToken = 'pk.eyJ1Ijoia2N0aXJ1IiwiYSI6ImNtMmVhaGxnczBzMmMya3NiZTNmYmc0NGsifQ.X4OpU9Ajb6UvH4DOPneHig';

  Future<List<LatLng>> fetchRoute(LatLng start, LatLng end) async {
    final String url =
        'https://api.mapbox.com/directions/v5/mapbox/walking/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?geometries=geojson&access_token=$accessToken';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> coordinates = data['routes'][0]['geometry']['coordinates'];

      return coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();
    } else {
      throw Exception('Failed to fetch route');
    }
  }

  // Add this method to get the current location
  Future<LocationModel> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition();
    return LocationModel(latitude: position.latitude, longitude: position.longitude);
  }

  Stream<LocationModel> getLocationStream() async* {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }
    }

    // Start a stream of location updates
    Stream<Position> positionStream = Geolocator.getPositionStream();
    await for (Position position in positionStream) {
      yield LocationModel(latitude: position.latitude, longitude: position.longitude);
    }
  }
}
