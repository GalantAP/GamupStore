import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final Color primaryColor = Colors.indigo.shade700;

  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _locationAccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: primaryColor,
        centerTitle: true,
        elevation: 4,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 8),
          Text(
            'Preferences',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const Divider(thickness: 1.2),
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: _notificationsEnabled,
            activeColor: primaryColor,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _darkModeEnabled,
            activeColor: primaryColor,
            onChanged: (bool value) {
              setState(() {
                _darkModeEnabled = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text('Location Access'),
            value: _locationAccess,
            activeColor: primaryColor,
            onChanged: (bool value) {
              setState(() {
                _locationAccess = value;
              });
            },
          ),
          const SizedBox(height: 24),
          Text(
            'Account',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const Divider(thickness: 1.2),
          ListTile(
            leading: Icon(Icons.lock, color: primaryColor),
            title: const Text('Privacy & Security'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              // Handle privacy settings tap
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy & Security belum tersedia')),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.language, color: primaryColor),
            title: const Text('Language'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Language settings belum tersedia')),
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            'Support',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const Divider(thickness: 1.2),
          ListTile(
            leading: Icon(Icons.help_outline, color: primaryColor),
            title: const Text('Help & Feedback'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help & Feedback belum tersedia')),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline, color: primaryColor),
            title: const Text('About App'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'GamUp Store',
                applicationVersion: '1.0.0',
                applicationIcon: Icon(Icons.videogame_asset, color: primaryColor, size: 32),
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text('A modern game store app built with Flutter. Get your favorite games here!'),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
