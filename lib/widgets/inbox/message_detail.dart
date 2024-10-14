import 'package:flutter/material.dart';

class MessageDetailPage extends StatelessWidget {
  final Map<String, String> message;

  const MessageDetailPage({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(message["subject"]!),
        backgroundColor: const Color(0xFF224193), // Dark Blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("From: ${message["sender"]}", style: const TextStyle(color: Color(0xFF6F9BD1))), // Light Blue
            const SizedBox(height: 10),
            Text("Received: ${message["time"]}", style: const TextStyle(color: Color(0xFFDF3C5F))), // Vivid Pink
            const SizedBox(height: 20),
            Text(message["snippet"]!, style: const TextStyle(color: Color(0xFFE9E7E0))), // Light Beige
            // Add more message details here
          ],
        ),
      ),
    );
  }
}
