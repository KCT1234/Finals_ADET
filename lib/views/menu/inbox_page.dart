import 'package:flutter/material.dart';
import 'package:final_adet/widgets/inbox/compse_message.dart';
import 'package:final_adet/widgets/inbox/message_detail.dart';
import 'package:final_adet/widgets/inbox/message_search.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  final List<Map<String, String>> _messages = [
    {"sender": "Student 1", "subject": "Meeting Reminder", "time": "2h ago", "snippet": "Don't forget about the meeting..."},
    {"sender": "Student 2", "subject": "Project Update", "time": "1d ago", "snippet": "Here's the latest update on the project..."},

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inbox',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF831515),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(context: context, delegate: MessageSearch());
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              _showMoreOptions(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search messages',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF224193)),
              ),
              onChanged: (value) {

              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  title: Text(message["subject"]!, style: TextStyle(color: Color(0xFF224193))),
                  subtitle: Text(message["sender"]! + " - " + message["snippet"]!, style: TextStyle(color: Color(0xFF6F9BD1))),
                  trailing: Text(message["time"]!, style: TextStyle(color: Color(0xFFDF3C5F))),
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessageDetailPage(message: message),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComposeMessagePage(),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFFDF3C5F),
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.filter_list, color: Color(0xFF224193)),
              title: const Text('Filter Messages'),
              onTap: () {
                Navigator.pop(context);

              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Color(0xFF224193)),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);

              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Color(0xFF224193)),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);

              },
            ),
          ],
        );
      },
    );
  }
}
