import 'package:final_adet/views/login_page.dart';
import 'package:final_adet/controllers/drawer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class drawerView extends StatelessWidget {
  const drawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 130, 35, 35),
            padding: const EdgeInsets.all(16.0),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    CupertinoIcons.person,
                    size: 40,
                    color: Color.fromARGB(255, 130, 35, 35),
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Adet Student',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'adetstudent00@mail.com',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            // Using ListView to make content scrollable
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                drawerController(
                  icon: CupertinoIcons.info,
                  text: 'Inbox',
                  onTap: () {
                    // Handle Inbox action
                  },
                ),
                drawerController(
                  icon: CupertinoIcons.settings,
                  text: 'Settings',
                  onTap: () {
                    // Handle Settings action
                  },
                ),
                drawerController(
                  icon: CupertinoIcons.bell,
                  text: 'Notifications',
                  onTap: () {
                    // Handle Notifications action
                  },
                ),
                drawerController(
                  icon: CupertinoIcons.question_circle,
                  text: 'Help and Feedback',
                  onTap: () {
                    // Handle Help and Feedback action
                  },
                ),
                drawerController(
                  icon: CupertinoIcons.clock,
                  text: 'Activity',
                  onTap: () {
                    // Handle Activity action
                  },
                ),
                drawerController(
                  icon: CupertinoIcons.placemark,
                  text: 'Saved Places',
                  onTap: () {
                    // Handle Saved Places action
                  },
                ),
                drawerController(
                  icon: CupertinoIcons.phone,
                  text: 'Assistance',
                  onTap: () {
                    // Handle Assistance action
                  },
                ),
              ],
            ),
          ),
          // Place the logout button at the bottom, but still scrollable if needed
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700],
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

