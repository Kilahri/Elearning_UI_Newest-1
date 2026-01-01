import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'analytics_screen.dart'; // <-- Import the new screen

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Mock student preference states
  bool _isDarkMode = true;
  bool _isHighContrastMode = false;
  bool _isNotificationEnabled = true;

  // Primary accent color for icons and switch handles
  final Color _primaryAccentColor = const Color(0xFF415A77);
  final Color _sectionTitleColor = const Color(0xFF98C1D9);
  final Color _logoutColor = const Color(0xFFE63946);

  // Helper to show a simple dialog for unimplemented functionality
  void _showFunctionalityDialog(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature functionality will be implemented soon!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Helper widget for section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: _sectionTitleColor,
        ),
      ),
    );
  }

  // Helper widget for standard settings tiles (navigation/tap actions)
  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      color: const Color(0xFF1B263B), // Card background
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: _primaryAccentColor, size: 24),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle:
            subtitle != null
                ? Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                )
                : null,
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.white54,
        ),
        onTap: onTap,
      ),
    );
  }

  // Helper widget for settings tiles with a switch
  Widget _buildSettingsSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    String? subtitle,
  }) {
    return Card(
      color: const Color(0xFF1B263B), // Card background
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SwitchListTile(
        tileColor: Colors.transparent,
        secondary: Icon(icon, color: _primaryAccentColor, size: 24),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle:
            subtitle != null
                ? Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                )
                : null,
        value: value,
        onChanged: onChanged,
        activeColor: _primaryAccentColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A), // Dark owl theme background
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B263B),
        elevation: 0,
        title: const Text("Settings", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 10),

          // --- Student Tools Section ---
          _buildSectionTitle("Student Tools & Data"),
          // 1. View Progress & Badges (NOW FUNCTIONAL)
          _buildSettingsTile(
            icon: Icons.bar_chart,
            title: "View Progress & Badges",
            subtitle: "See your mastery levels and unlocked achievements",
            onTap: () {
              // ⭐ Functionally links to the AnalyticsScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AnalyticsScreen(),
                ),
              );
            },
          ),
          // 2. Manage Saved Lessons/Notes
          _buildSettingsTile(
            icon: Icons.bookmark_border,
            title: "Saved Items & Notes",
            subtitle: "Review your saved lessons and video notes",
            onTap: () => _showFunctionalityDialog("Saved Items"),
          ),

          const SizedBox(height: 20),

          // --- Account Section ---
          _buildSectionTitle("Account"),
          _buildSettingsTile(
            icon: Icons.person,
            title: "Edit Profile",
            subtitle: "Update your name, age, and class details",
            onTap: () => _showFunctionalityDialog("Edit Profile"),
          ),
          _buildSettingsTile(
            icon: Icons.lock,
            title: "Change Password",
            subtitle: "Update your account password",
            onTap: () => _showFunctionalityDialog("Change Password"),
          ),

          const SizedBox(height: 20),

          // --- Accessibility & Preferences Section ---
          _buildSectionTitle("Display & Preferences"),
          // Theme Toggle
          _buildSettingsSwitchTile(
            icon: Icons.palette,
            title: "Dark Mode",
            subtitle: "Toggle between light and dark themes",
            value: _isDarkMode,
            onChanged: (bool newValue) {
              setState(() {
                _isDarkMode = newValue;
              });
              _showFunctionalityDialog("Theme Change");
            },
          ),
          // High Contrast Mode
          _buildSettingsSwitchTile(
            icon: Icons.contrast,
            title: "High Contrast Mode",
            subtitle: "Enhance color and text for better readability",
            value: _isHighContrastMode,
            onChanged: (bool newValue) {
              setState(() {
                _isHighContrastMode = newValue;
              });
              _showFunctionalityDialog("High Contrast Mode");
            },
          ),
          // Notifications Toggle
          _buildSettingsSwitchTile(
            icon: Icons.notifications,
            title: "Notifications",
            subtitle: "Receive alerts for new lessons and quizzes",
            value: _isNotificationEnabled,
            onChanged: (bool newValue) {
              setState(() {
                _isNotificationEnabled = newValue;
              });
              _showFunctionalityDialog("Notifications");
            },
          ),

          const SizedBox(height: 20),

          // --- Support Section ---
          _buildSectionTitle("Help & Support"),
          _buildSettingsTile(
            icon: Icons.help_outline,
            title: "Help Center & FAQ",
            subtitle: "Find answers to common questions",
            onTap: () => _showFunctionalityDialog("Help Center"),
          ),
          _buildSettingsTile(
            icon: Icons.email_outlined,
            title: "Contact Support",
            subtitle: "Get assistance from our support team",
            onTap: () => _showFunctionalityDialog("Contact Support"),
          ),

          const SizedBox(height: 30),

          // Logout Button (Functional)
          ElevatedButton.icon(
            onPressed: () {
              // Functional: Navigate to LoginScreen and clear stack
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false, // clears all previous routes
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _logoutColor, // Red for logout action
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.logout, color: Colors.white),
            label: const Text(
              "Logout",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
