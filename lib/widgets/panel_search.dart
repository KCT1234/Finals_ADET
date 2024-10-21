import 'package:flutter/material.dart';

class PanelSearch extends StatefulWidget {
  final List<String> destinations;
  final ValueChanged<String> onSearchSelect;

  const PanelSearch({
    Key? key,
    required this.destinations,
    required this.onSearchSelect,
  }) : super(key: key);

  @override
  _PanelSearchState createState() => _PanelSearchState();
}

class _PanelSearchState extends State<PanelSearch> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _suggestions = [];

  void _onSearchChanged(String query) {
    // Filter destinations based on the search query
    if (query.isNotEmpty) {
      _suggestions = widget.destinations
          .where((destination) => destination.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      _suggestions = [];
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search destinations...',
            filled: true,
            fillColor: Colors.white,
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          style: const TextStyle(color: Colors.black),  // Keep text in search bar black
          onChanged: _onSearchChanged,
        ),
        if (_suggestions.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            itemCount: _suggestions.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.location_on, color: Colors.white), // Location icon
                    title: Text(
                      _suggestions[index],
                      style: const TextStyle(color: Colors.white),  // Suggestion text in white
                    ),
                    onTap: () {
                      widget.onSearchSelect(_suggestions[index]);
                      _searchController.clear(); // Clear input on selection
                      _suggestions.clear(); // Clear suggestions
                      setState(() {});
                    },
                  ),
                  const Divider(color: Colors.white),  // Add dividing line between suggestions
                ],
              );
            },
          ),
      ],
    );
  }
}


// import 'package:flutter/material.dart';
//
// class PanelSearch extends StatefulWidget {
//   final List<String> destinations;
//   final ValueChanged<String> onSearchSelect;
//
//   const PanelSearch({
//     Key? key,
//     required this.destinations,
//     required this.onSearchSelect,
//   }) : super(key: key);
//
//   @override
//   _PanelSearchState createState() => _PanelSearchState();
// }
//
// class _PanelSearchState extends State<PanelSearch> {
//   final TextEditingController _searchController = TextEditingController();
//   List<String> _suggestions = [];
//
//   void _onSearchChanged(String query) {
//     // Filter destinations based on the search query
//     if (query.isNotEmpty) {
//       _suggestions = widget.destinations
//           .where((destination) => destination.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     } else {
//       _suggestions = [];
//     }
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextField(
//           controller: _searchController,
//           decoration: InputDecoration(
//             hintText: 'Search destinations...',
//             filled: true,
//             fillColor: Colors.white,
//             prefixIcon: const Icon(Icons.search),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(25),
//             ),
//           ),
//           style: const TextStyle(color: Colors.black),  // Keep text in search bar black
//           onChanged: _onSearchChanged,
//         ),
//         if (_suggestions.isNotEmpty)
//           ListView.builder(
//             shrinkWrap: true,
//             itemCount: _suggestions.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(
//                   _suggestions[index],
//                   style: const TextStyle(color: Colors.white),
//                 ),
//                 onTap: () {
//                   widget.onSearchSelect(_suggestions[index]);
//                   _searchController.clear(); // Clear input on selection
//                   _suggestions.clear(); // Clear suggestions
//                   setState(() {});
//                 },
//               );
//             },
//           ),
//       ],
//     );
//   }
// }
