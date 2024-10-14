import 'package:flutter/material.dart';

class PanelSearch extends StatelessWidget {
  const PanelSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Where To?',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}