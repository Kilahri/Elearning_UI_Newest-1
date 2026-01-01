import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Ensure these paths match your project structure exactly
import 'package:elearningapp_flutter/screens/student_signup_screen.dart';
import 'package:elearningapp_flutter/screens/forgot_password_screen.dart';
import 'package:elearningapp_flutter/screens/role_navigation.dart';

// --- Theme Constants ---
const Color kPrimaryColor = Color(0xFF0D102C);
const Color kAccentColor = Color(0xFFFFC107);
const Color kButtonColor = Color(0xFF7B4DFF);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // --- Teacher Credentials (Hardcoded) ---
  final String _adminUser = "Teacher_Science";
  final String _adminPass = "SciLearn2026";

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: const Color(0xFF1C1F3E),
            title: const Text(
              "Login Failed",
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              message,
              style: const TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.purpleAccent),
                ),
              ),
            ],
          ),
    );
  }

  Future<void> _login() async {
    final prefs = await SharedPreferences.getInstance();

    String username = _usernameController.text.trim();
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog("Please enter both username and password.");
      return;
    }

    // 1. CHECK TEACHER ACCOUNT FIRST (Hardcoded logic)
    if (username == _adminUser && password == _adminPass) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => RoleNavigation(role: "teacher", username: username),
        ),
      );
      return; // Stop here, teacher login successful
    }

    // 2. CHECK STUDENT ACCOUNT (From SharedPreferences)
    String savedUsername = prefs.getString("username") ?? "";
    String savedPassword = prefs.getString("password") ?? "";
    String savedRole = prefs.getString("role") ?? "student";

    if (username == savedUsername && password == savedPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => RoleNavigation(role: savedRole, username: username),
        ),
      );
    } else {
      _showErrorDialog("Invalid username or password.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "SciLearn",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: kAccentColor,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.purple,
                      offset: Offset(0, 0),
                    ),
                  ],
                  letterSpacing: 2,
                ),
              ),
              const Text(
                "Science Learning Platform",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 30),

              // Image asset
              Image.asset("lib/assets/owl.png", height: 120),

              const SizedBox(height: 20),
              const Text(
                "Welcome Back!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Log in to continue your learning adventure",
                style: TextStyle(color: Colors.white70, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Username Field
              TextField(
                controller: _usernameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Username",
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF1C1F3E),
                  prefixIcon: const Icon(Icons.person, color: kAccentColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: kButtonColor, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Password Field
              TextField(
                controller: _passwordController,
                style: const TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF1C1F3E),
                  prefixIcon: const Icon(Icons.lock, color: kAccentColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: kButtonColor, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.purpleAccent, fontSize: 16),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StudentSignupScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
