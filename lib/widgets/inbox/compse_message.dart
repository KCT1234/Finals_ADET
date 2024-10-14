import 'package:flutter/material.dart';

class ComposeMessagePage extends StatelessWidget {
  const ComposeMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compose New Message'),
        backgroundColor: const Color(0xFF224193), // Dark Blue
      ),
      body: const Center(
        child: Text('Compose New Message Page'),
        // Add form or functionality for composing a new message
      ),
    );
  }
}
