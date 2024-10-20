import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:final_adet/controllers/map_controller.dart' as mapLogic; // Alias import for custom controller
import 'package:final_adet/models/location_model.dart';
import 'package:final_adet/models/Destination.dart';
import 'drawer_view.dart';
import 'package:final_adet/widgets/bar_indicator.dart';
import 'package:final_adet/widgets/panel_search.dart';
import 'package:final_adet/widgets/recent_destination.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  final GlobalKey<ScaffoldState> _screenKey = GlobalKey<ScaffoldState>();
  final MapController mapController = MapController();
  final mapLogic.MapController mapLogicController = mapLogic.MapController();
  LocationModel? currentLocation;
  bool isMapReady = false;
  bool isLocationFetched = false;

  final List<Destination> destinations = [
    Destination(name: 'Don Juan D. Nepomuceno Building', latitude: 15.133502, longitude: 120.590243),
    Destination(name: 'Saint Joseph Hall', latitude: 15.132736, longitude: 120.589111),
    Destination(name: 'Sacred Heart Building', latitude: 15.131356, longitude: 120.589356),
    Destination(name: 'Immaculate Heart Gym', latitude: 15.132015, longitude: 120.588663),
    Destination(name: 'Mamerto G Nepo Building', latitude: 15.133047, longitude: 120.589626),
    Destination(name: 'Peter G Nepomuceno', latitude: 15.132747, longitude: 120.590138),
  ];

  List<LatLng> routePoints = [];

  void handleSearchSelect(Destination selectedDestination) async {
    if (currentLocation == null) {
      _showLocationServiceDialog('Current Location Not Found', 'Please fetch your current location first.');
      return;
    }

    mapController.move(
      LatLng(selectedDestination.latitude, selectedDestination.longitude),
      18.0,
    );

    try {
      final route = await mapLogicController.fetchRoute(
        LatLng(currentLocation!.latitude, currentLocation!.longitude),
        LatLng(selectedDestination.latitude, selectedDestination.longitude),
      );

      setState(() {
        routePoints = route;
      });
    } catch (error) {
      _showLocationServiceDialog('Error', 'Could not fetch route. Please try again.');
    }
  }

  void _showLocationServiceDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void getCurrentLocation() async {
    try {
      LocationModel location = await mapLogicController.getCurrentLocation();

      setState(() {
        currentLocation = location;
        isLocationFetched = true;
      });

      _moveToCurrentLocation();
    } catch (error) {
      _showLocationServiceDialog('Error', error.toString());
    }
  }

  void _moveToCurrentLocation() {
    if (isMapReady && isLocationFetched && currentLocation != null) {
      mapController.move(
        LatLng(currentLocation!.latitude, currentLocation!.longitude),
        18.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _screenKey,
      body: Stack(
        children: [
          SlidingUpPanel(
            minHeight: 135,
            maxHeight: 550,
            backdropEnabled: true,
            color: Colors.transparent,
            panel: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 130, 35, 35),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BarIndicator(),
                  PanelSearch(
                    destinations: destinations.map((d) => d.name).toList(),
                    onSearchSelect: (selectedName) {
                      final selectedDestination = destinations.firstWhere((d) => d.name == selectedName);
                      handleSearchSelect(selectedDestination);
                    },
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: destinations.map((destination) {
                        return RecentDestinationTile(destination: destination.name, description: 'Description here');
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            body: Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: LatLng(15.132505, 120.589862),
                    initialZoom: 18.0,
                    minZoom: 5.0,
                    maxZoom: 23,
                    onMapReady: () {
                      setState(() {
                        isMapReady = true;
                      });
                      _moveToCurrentLocation();
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://api.mapbox.com/styles/v1/kctiru/cm2c3cdhl009l01poc7xihjc7/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia2N0aXJ1IiwiYSI6ImNtMmVhaGxnczBzMmMya3NiZTNmYmc0NGsifQ.X4OpU9Ajb6UvH4DOPneHig',
                      maxNativeZoom: 22,
                    ),
                    LocationMarkerLayer(
                      position: LocationMarkerPosition(
                        latitude: currentLocation?.latitude ?? 0.0,
                        longitude: currentLocation?.longitude ?? 0.0,
                        accuracy: 20.0,
                      ),
                      heading: null,
                    ),
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: routePoints,
                          strokeWidth: 4.0,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 130, 35, 35),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        size: 45,
                        Icons.menu,
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      onPressed: () => _screenKey.currentState?.openDrawer(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 165,
                  left: 20,
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 130, 35, 35),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        size: 45,
                        Icons.my_location_rounded,
                        color: Colors.white,
                      ),
                      alignment: Alignment.center,
                      onPressed: () {
                        getCurrentLocation();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: drawerView(),
      ),
    );
  }
}
