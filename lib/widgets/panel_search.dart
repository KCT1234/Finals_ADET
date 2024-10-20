import 'package:flutter/material.dart';

class PanelSearch extends StatefulWidget {
  final List<String> destinations;
  final ValueChanged<String> onSearchSelect;
  // final VoidCallback onSearchActivated;

  const PanelSearch({
    super.key,
    required this.destinations,
    required this.onSearchSelect,
    // required this.onSearchActivated,
  });

  @override
  _PanelSearchState createState() => _PanelSearchState();
}

class _PanelSearchState extends State<PanelSearch> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _suggestions = [];

  void _onSearchChanged(String query) {
    // Activate the search
    if (query.isNotEmpty) {
      // widget.onSearchActivated();
    }

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
          decoration: const InputDecoration(
            hintText: 'Search destinations...',
            border: OutlineInputBorder(),
          ),
          onChanged: _onSearchChanged,
        ),
        if (_suggestions.isNotEmpty)
          ListView.builder(
            shrinkWrap: true,
            itemCount: _suggestions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_suggestions[index]),
                onTap: () {
                  widget.onSearchSelect(_suggestions[index]);
                  _searchController.clear(); // Clear input on selection
                  _suggestions.clear(); // Clear suggestions
                  setState(() {});
                },
              );
            },
          ),
      ],
    );
  }
}
