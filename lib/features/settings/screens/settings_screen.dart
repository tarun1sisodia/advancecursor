import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_attendance/app/routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const _SettingsSection(
            title: 'Account',
            children: [
              _SettingsTile(
                icon: Icons.person,
                title: 'Profile',
                route: Routes.profile,
              ),
              _SettingsTile(
                icon: Icons.security,
                title: 'Privacy & Security',
                route: Routes.settings,
              ),
            ],
          ),
          const _SettingsSection(
            title: 'App Settings',
            children: [
              _SettingsTile(
                icon: Icons.notifications,
                title: 'Notifications',
                route: Routes.settings,
              ),
              _SettingsTile(
                icon: Icons.language,
                title: 'Language',
                route: Routes.settings,
              ),
              _SettingsTile(
                icon: Icons.sync,
                title: 'Sync Status',
                route: Routes.syncStatus,
              ),
            ],
          ),
          const _SettingsSection(
            title: 'About',
            children: [
              _SettingsTile(
                icon: Icons.info,
                title: 'About Smart Campus',
                route: Routes.about,
              ),
            ],
          ),
          const SizedBox(height: 20), // Add some space before the logout button
          _buildLogoutButton(context), // Logout button
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
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

  Future<void> _handleLogout(BuildContext context) async {
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('hasSeenOnboarding'); // Clear onboarding flag
    Navigator.pushReplacementNamed(context, Routes.login); // Navigate to login
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
      ],
    );
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
