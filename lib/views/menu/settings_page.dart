import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
            onTap: _showChangePasswordDialog,
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

  void _showChangePasswordDialog() {
    final _currentPasswordController = TextEditingController();
    final _newPasswordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _currentPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Current Password',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'New Password',
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm New Password',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Change Password'),
              onPressed: () async {
                // Show loading indicator
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Center(child: CircularProgressIndicator());
                  },
                );

                if (_newPasswordController.text !=
                    _confirmPasswordController.text) {
                  Navigator.of(context).pop(); // Dismiss loading indicator
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('New passwords do not match')),
                  );
                  return;
                }

                try {
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    // Reauthenticate user first
                    AuthCredential credential = EmailAuthProvider.credential(
                      email: user.email!,
                      password: _currentPasswordController.text,
                    );

                    await user.reauthenticateWithCredential(credential);

                    // Change password
                    await user.updatePassword(_newPasswordController.text);

                    Navigator.of(context).pop(); // Dismiss loading indicator
                    Navigator.of(context)
                        .pop(); // Dismiss password change dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Password updated successfully')),
                    );
                  }
                } on FirebaseAuthException catch (e) {
                  Navigator.of(context).pop(); // Dismiss loading indicator
                  String errorMessage =
                      'Failed to change password. Please try again.';
                  if (e.code == 'wrong-password') {
                    errorMessage = 'Current password is incorrect.';
                  } else if (e.code == 'weak-password') {
                    errorMessage = 'The new password is too weak.';
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(errorMessage)),
                  );
                } catch (e) {
                  Navigator.of(context).pop(); // Dismiss loading indicator
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('An error occurred. Please try again.')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
