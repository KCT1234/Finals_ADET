import 'package:flutter/material.dart';

class MessageSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear, color: Color(0xFFDF3C5F)), // Vivid Pink
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Color(0xFFDF3C5F)), // Vivid Pink
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results here
    return Center(
      child: Text('Search Results', style: TextStyle(color: Color(0xFF6F9BD1))), // Light Blue
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement search suggestions here
    return Center(
      child: Text('Search Suggestions', style: TextStyle(color: Color(0xFF6F9BD1))), // Light Blue
    );
  }
}