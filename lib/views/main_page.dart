import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:final_adet/models/location_model.dart';
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
  final GlobalKey<ScaffoldState> _ScreenKey = GlobalKey<ScaffoldState>();
  final MapController mapController = MapController();
  LocationModel? currentLocation;
  bool isMapReady = false; // Flag to track if the map is ready
  bool isLocationFetched = false; // Flag to track if location is fetched

  @override
  void initState() {
    super.initState();
    // Set initial location fetch status to false
    isLocationFetched = false;
  }

  // Fetch the current location of the user
  void getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationServiceDialog('Location Service Disabled', 'Please enable location services.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        _showLocationServiceDialog('Location Permission Denied', 'Please grant location permission.');
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      currentLocation = LocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      isLocationFetched = true; // Location is now fetched
    });

    // Attempt to move the map only if the map is ready and the location is fetched
    _moveToCurrentLocation();
  }

  // Helper function to display dialogs
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

  // Move the map to the current location if both the map is ready and the location is fetched
  void _moveToCurrentLocation() {
    if (isMapReady && isLocationFetched && currentLocation != null) {
      mapController.move(
        LatLng(currentLocation!.latitude, currentLocation!.longitude),
        15.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _ScreenKey,
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
                borderRadius: BorderRadius.only(topLeft:Radius.circular(24),topRight:Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BarIndicator(),
                  const PanelSearch(),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: const [
                        RecentDestinationTile(destination: 'Saint Joseph Hall', description: 'SJH-706',),
                        RecentDestinationTile(destination: 'Sacred Heart Building', description: 'SH-105',),
                        RecentDestinationTile(destination: 'Immaculate Heart Gym', description: 'GYM-201',),
                        RecentDestinationTile(destination: 'Mamerto G Nepo Buiding', description: 'MGN-305',),
                        RecentDestinationTile(destination: 'Peter G Nepomuceno', description: 'PGN-809',),
                      ],
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
                    initialCenter: const LatLng(15.132505, 120.589862),
                    initialZoom: 18.0,
                    minZoom: 5.0,
                    maxZoom: 23,
                    onMapReady: () {
                      setState(() {
                        isMapReady = true;
                      });
                      mapController.mapEventStream.listen((event) {
                        print("Map event occurred: $event");
                      });
                      _moveToCurrentLocation();
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://api.mapbox.com/styles/v1/kctiru/cm0y5kdd501fx01pqbuglh9zu/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia2N0aXJ1IiwiYSI6ImNtMHdoeGI5ZDAyNXUyc3ExN2JscW9ieTAifQ.wu7uC5TxznmmslF5u37wzw',
                      maxNativeZoom: 22,
                    ),
                    LocationMarkerLayer(
                      position: LocationMarkerPosition(
                          latitude: currentLocation?.latitude ?? 0.0,
                          longitude:  currentLocation?.longitude ?? 0.0,
                          accuracy: 20.0
                      ),
                      heading: null,
                    )
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
                      onPressed: () => _ScreenKey.currentState?.openDrawer(),
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
          )
        ],
      ),
      drawer: const Drawer(
        child: drawerView(),
      ),
    );
  }
}
