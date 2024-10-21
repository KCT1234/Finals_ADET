import 'package:flutter/material.dart';

class HelpFeedbackPage extends StatefulWidget {
  const HelpFeedbackPage({super.key});

  @override
  State<HelpFeedbackPage> createState() => _HelpFeedbackPageState();
}

class _HelpFeedbackPageState extends State<HelpFeedbackPage> {
  // Controller for feedback form
  final _feedbackController = TextEditingController();

  // List of help topics
  final List<String> _helpTopics = [
    'How to navigate the map',
    'How to save places on the map',
    'How to update map preferences',
    'Troubleshooting map issues',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help and Feedback',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF831515),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Help Topics',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: const Color(0xFFDF3C5F)),
            ),
            const SizedBox(height: 8.0),
            ..._helpTopics.map((topic) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(topic, style: const TextStyle(fontSize: 16.0)),
                  leading:
                      const Icon(Icons.help_outline, color: Color(0xFF6F9BD1)),
                  onTap: () {
                    // Handle tap for each help topic, possibly navigate to a detailed page
                  },
                )),
            const SizedBox(height: 16.0),
            Text(
              'Submit Feedback',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: const Color(0xFFDF3C5F)),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _feedbackController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your feedback or report an issue...',
                filled: true,
                fillColor: Color(0xFFE9E7E0),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle feedback submission
                final feedback = _feedbackController.text;
                if (feedback.isNotEmpty) {
                  // Process the feedback (e.g., send to a server or save locally)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Feedback submitted successfully!'),
                      backgroundColor: Color(0xFF6F9BD1),
                    ),
                  );
                  _feedbackController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF224193),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 5,
              ),
              child: const Text('Submit Feedback'),
            ),
            const SizedBox(height: 16.0),
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
                // Implement contact form or assistance request functionality here
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF831515),
              ),
              child: const Text('Request Assistance'),
            ),
          ],
        ),
      ),
    );
  }
}
