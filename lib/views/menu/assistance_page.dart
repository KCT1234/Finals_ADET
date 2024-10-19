// commneted are to be cotinue on finals

import 'package:flutter/material.dart';
// Import Flutter Map package when integrating the map functionality
// import 'package:flutter_map/flutter_map.dart';
// Import LatLong package when using Flutter Map
// import 'package:latlong2/latlong.dart';

class AssistancePage extends StatefulWidget {
  const AssistancePage({super.key});

  @override
  State<AssistancePage> createState() => _AssistancePageState();
}

class _AssistancePageState extends State<AssistancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Assitance',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF831515),

      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              // Placeholder for the map widget
              // Uncomment and configure the following FlutterMap code when adding map functionality
              /*
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(14.5995, 120.9842), // Center the map
                  zoom: 13.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate: "https://stamen-tiles.a.ssl.fastly.net/toner/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(14.5995, 120.9842),
                        builder: (ctx) => Container(
                          child: IconButton(
                            icon: Icon(Icons.location_pin, color: Colors.red),
                            onPressed: () {
                              _showAssistanceDetails();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              */
              child: Center(
                child: Text(
                  'This section will be updated with interactive features soon.\nStay tuned for more information!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'For assistance, please contact us:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Email: support@example.com',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Phone: 123-456-7890',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Implement contact form or assistance request functionality here / to be continue on finals
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF831515),
                  ),
                  child: const Text('Request Assistance'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Placeholder method for showing assistance details
  // Uncomment and update this method when integrating with actual map data / to be continue on finals

  void _showAssistanceDetails() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Assistance Details'),
          content: const Text('For immediate support, please contact us at support@example.com or call 123-456-7890.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
