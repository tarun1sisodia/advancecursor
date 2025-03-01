import 'package:flutter/material.dart';
import 'package:smart_attendance/app/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.lightBlue),
            child: Text(
              'Settings',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          const _SettingsTile(
            icon: Icons.person,
            title: 'Profile',
            route: Routes.profile,
          ),
          const _SettingsTile(
            icon: Icons.security,
            title: 'Privacy & Security',
            route: Routes.settings,
          ),
          const _SettingsTile(
            icon: Icons.notifications,
            title: 'Notifications',
            route: Routes.settings,
          ),
          const _SettingsTile(
            icon: Icons.language,
            title: 'Language',
            route: Routes.settings,
          ),
          const _SettingsTile(
            icon: Icons.sync,
            title: 'Sync Status',
            route: Routes.syncStatus,
          ),
          const _SettingsTile(
            icon: Icons.info,
            title: 'About Smart Campus',
            route: Routes.about,
          ),
          const SizedBox(height: 20), // Add some space before the logout button
          _buildLogoutButton(context), // Logout button
        ],
      ),
    );
  }

  static Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          await _handleLogout(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, // Change color to indicate logout
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        child: const Text('Log Out'),
      ),
    );
  }

  static Future<void> _handleLogout(BuildContext context) async {
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('hasSeenOnboarding'); // Clear onboarding flag
    Navigator.pushReplacementNamed(context, Routes.login); // Navigate to login
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }
}
