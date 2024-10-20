import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:final_adet/views/login_page.dart';
import 'package:final_adet/controllers/drawer_controller.dart';

class drawerView extends StatelessWidget {
  const drawerView({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser; // Get the current user
    String userName = user != null ? user.email!.split('@')[0] : 'Adet Student'; // Default to 'Adet Student' if no user
    String userEmail = user != null ? user.email! : 'adetstudent00@mail.com'; // Default email

    return SafeArea(
      child: Column(
        children: [
          Container(
            color: const Color.fromARGB(255, 130, 35, 35),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    CupertinoIcons.person,
                    size: 40,
                    color: Color.fromARGB(255, 130, 35, 35),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName, // Display logged-in username
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      userEmail, // Display logged-in user's email
                      style: const TextStyle(
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut(); // Sign out the user
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()), // Redirect to login page
                );
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
