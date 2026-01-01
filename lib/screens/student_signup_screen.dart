import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:elearningapp_flutter/screens/role_navigation.dart';

// Theme Colors
const Color kPrimaryColor = Color(0xFF6A1B9A);
const Color kAccentColor = Color(0xFFFFC107);
const double kLargeFontSize = 18.0;
const double kSpacing = 22.0;

class StudentSignupScreen extends StatefulWidget {
  const StudentSignupScreen({super.key});

  @override
  State<StudentSignupScreen> createState() => _StudentSignupScreenState();
}

class _StudentSignupScreenState extends State<StudentSignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _parentContactController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? selectedGrade = "Grade 4";
  final List<String> grades = ["Grade 4", "Grade 5", "Grade 6"];

  String? selectedSection;
  final List<String> sections = ["Section A", "Section B", "Section C"];

  final String selectedRole = "student"; // Only students on this screen

  Future<void> _signup() async {
    if (_nameController.text.isEmpty ||
        selectedGrade == null ||
        selectedSection == null ||
        _usernameController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please complete all *required* fields."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", _nameController.text.trim());
    await prefs.setString("username", _usernameController.text.trim());
    await prefs.setString("password", _passwordController.text.trim());
    await prefs.setString("role", selectedRole);
    await prefs.setString("grade", selectedGrade!);
    await prefs.setString("section", selectedSection!);

    if (_studentIdController.text.isNotEmpty) {
      await prefs.setString("studentId", _studentIdController.text.trim());
    }
    if (_parentContactController.text.isNotEmpty) {
      await prefs.setString(
        "parentContact",
        _parentContactController.text.trim(),
      );
    }

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (context) => RoleNavigation(
              role: selectedRole,
              username: _usernameController.text.trim(),
            ),
      ),
    );
  }

  // Reusable TextField
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
    TextInputType type = TextInputType.text,
    List<TextInputFormatter>? formatter,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: type,
      inputFormatters: formatter,
      style: const TextStyle(color: kPrimaryColor, fontSize: kLargeFontSize),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: kPrimaryColor),
        prefixIcon: Icon(icon, color: kAccentColor),
        filled: true,
        fillColor: kPrimaryColor.withOpacity(0.1),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  // Reusable Dropdown
  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      items:
          items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: kAccentColor),
        filled: true,
        fillColor: kPrimaryColor.withOpacity(0.1),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Student Sign Up 🧪",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              "Fill in your details to start learning!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              ),
            ),
            const SizedBox(height: kSpacing * 1.5),

            // Name
            _buildTextField(
              controller: _nameController,
              label: "Full Name (Required) *",
              icon: Icons.person,
            ),
            const SizedBox(height: kSpacing),

            // Grade
            _buildDropdown(
              label: "Grade Level (Required) *",
              icon: Icons.school,
              value: selectedGrade,
              items: grades,
              onChanged: (v) => setState(() => selectedGrade = v),
            ),
            const SizedBox(height: kSpacing),

            // Section
            _buildDropdown(
              label: "Section (Required) *",
              icon: Icons.group,
              value: selectedSection,
              items: sections,
              onChanged: (v) => setState(() => selectedSection = v),
            ),
            const SizedBox(height: kSpacing),

            // Student ID (Optional)
            _buildTextField(
              controller: _studentIdController,
              label: "Student ID (Optional)",
              icon: Icons.badge,
              type: TextInputType.number,
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: kSpacing),

            // Parent Contact (Optional)
            _buildTextField(
              controller: _parentContactController,
              label: "Parent/Guardian Contact (Optional)",
              icon: Icons.phone,
              type: TextInputType.phone,
            ),
            const SizedBox(height: kSpacing),

            const Divider(thickness: 1.2, color: kPrimaryColor),
            const SizedBox(height: kSpacing),

            // Username
            _buildTextField(
              controller: _usernameController,
              label: "Username (Required) *",
              icon: Icons.vpn_key,
            ),
            const SizedBox(height: kSpacing),

            // Password
            _buildTextField(
              controller: _passwordController,
              label: "Password (Required) *",
              icon: Icons.lock,
              obscure: true,
            ),
            const SizedBox(height: kSpacing * 2),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: _signup,
                icon: const Icon(Icons.check_circle),
                label: const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentColor,
                  foregroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
