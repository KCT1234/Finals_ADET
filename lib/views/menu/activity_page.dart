import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
//import 'package:latlong2/latlong.dart'; to be edit on finals

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  // Sample activity data
  final List<Map<String, String>> _activities = [
    {"title": "Visited Plaza De Corazon Building", "time": "2h ago"},
    {"title": "Checked map style: Satellite", "time": "1d ago"},
    {"title": "Saved new location: St. Martha Hall Building", "time": "3d ago"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Activities',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF831515),

      ),
      body: Column(
        children: [
          // Map Preview Section
          Container(
            height: 200,
            padding: const EdgeInsets.all(8.0),
            child: FlutterMap(
              options: const MapOptions(
                //center: LatLng(14.5995, 120.9842), // Center on a specific location
                //zoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://api.mapbox.com/styles/v1/kctiru/cm0y5kdd501fx01pqbuglh9zu/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoia2N0aXJ1IiwiYSI6ImNtMHdoeGI5ZDAyNXUyc3ExN2JscW9ieTAifQ.wu7uC5TxznmmslF5u37wzw",
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          // Activity Feed Section
          Expanded(
            child: ListView.builder(
              itemCount: _activities.length,
              itemBuilder: (context, index) {
                final activity = _activities[index];
                return ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  title: Text(activity["title"]!, style: const TextStyle(color: Color(0xFF224193))),
                  subtitle: Text("Time: ${activity["time"]!}", style: const TextStyle(color: Color(0xFF6F9BD1))),
                  leading: const Icon(Icons.history, color: Color(0xFFE3C5B2)),
                  tileColor: const Color(0xFFE9E7E0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  splashColor: const Color(0xFFDF3C5F).withOpacity(0.1),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}