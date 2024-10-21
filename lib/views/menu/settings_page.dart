import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Default selected map style

  // List of map style

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF831515),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          _buildSectionTitle('Profile Settings'),
          _buildSettingsTile(
            title: 'Edit Profile',
            icon: CupertinoIcons.person,
            onTap: () {
              Navigator.pushNamed(context, '/editProfile');
            },
          ),
          _buildSettingsTile(
            title: 'Change Password',
            icon: CupertinoIcons.lock,
            onTap: () {
              Navigator.pushNamed(context, '/changePassword');
            },
          ),
          const SizedBox(height: 16.0),
          _buildSectionTitle('Account Settings'),
          _buildSettingsTile(
            title: 'Manage Account',
            icon: CupertinoIcons.person_2,
            onTap: () {
              Navigator.pushNamed(context, '/manageAccount');
            },
          ),
          _buildSettingsTile(
            title: 'Privacy Settings',
            icon: CupertinoIcons.shield,
            onTap: () {
              Navigator.pushNamed(context, '/privacySettings');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: const Color(0xFFDF3C5F),
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: Icon(icon, color: const Color(0xFF224193)),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
      onTap: onTap,
      tileColor: const Color(0xFFE3C5B2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      splashColor: const Color(0xFFDF3C5F).withOpacity(0.1),
    );
  }
}
