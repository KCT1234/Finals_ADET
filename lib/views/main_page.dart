import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:final_adet/models/location_model.dart';
import 'login_page.dart';
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
  final mapController = MapController();
  LocationModel? currentLocation;
  @override
  Widget build(BuildContext context){
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
                Scaffold(
                  body: Stack(
                    children: [
                      FlutterMap(
                        mapController: MapController(),
                        options: MapOptions(
                            initialCenter: const LatLng(15.132505, 120.589862),
                            initialZoom: 18.0,
                            minZoom: 5.0,
                            maxZoom: 23,
                            onMapReady: (){
                              mapController.mapEventStream.listen((evt) {});
                            }
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://api.mapbox.com/styles/v1/kctiru/cm0y5kdd501fx01pqbuglh9zu/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia2N0aXJ1IiwiYSI6ImNtMHdoeGI5ZDAyNXUyc3ExN2JscW9ieTAifQ.wu7uC5TxznmmslF5u37wzw',
                            maxNativeZoom: 22,
                          ),
                          const MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(15.132505, 120.589862),
                                width: 70,
                                height: 70,
                                alignment: Alignment.topCenter,
                                child: Icon(
                                  Icons.location_pin,
                                  color: Color.fromARGB(255, 130, 35, 35),
                                  size: 60,
                                ),
                              )
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
                            onPressed: (){
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        width:  MediaQuery.of(context).size.width * 0.75,
        child: drawerView(),
      ),
    );
  }
}
