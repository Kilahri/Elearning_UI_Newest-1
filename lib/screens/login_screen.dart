import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Corrected absolute imports
import 'package:elearningapp_flutter/screens/student_signup_screen.dart';
import 'package:elearningapp_flutter/screens/forgot_password_screen.dart';
import 'package:elearningapp_flutter/screens/role_navigation.dart';

// --- Theme Constants for Consistency ---
const Color kPrimaryColor = Color(0xFF0D102C); // Dark Background
const Color kAccentColor = Color(0xFFFFC107); // Amber/Yellow
const Color kButtonColor = Color(0xFF7B4DFF); // Purple Button

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Helper method to show consistent error dialogs
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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

    String savedUsername = prefs.getString("username") ?? "";
    String savedPassword = prefs.getString("password") ?? "";
    String savedRole = prefs.getString("role") ?? ""; // student / teacher / admin

    String username = _usernameController.text.trim();
    String password = _passwordController.text;

    // 🚀 FIX: Prevent login with empty fields. This stops "" == "" from succeeding.
    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog("Please enter both username and password.");
      return;
    }

    // Now, proceed with validation logic:
    if (username == savedUsername && password == savedPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RoleNavigation(role: savedRole),
        ),
      );
    } else {
      // Use the cleaner error dialog for invalid credentials
      _showErrorDialog("Invalid username or password.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0), // Increased padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🧪 ENHANCEMENT: App Name (SciLearn)
              const Text(
                "SciLearn",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: kAccentColor, // Use accent color for a 'pop'
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

              // Owl Image
              Image.asset("lib/assets/owl.png", height: 120), // Slightly reduced height for better fit
              const SizedBox(height: 20),

              // Welcome Text
              const Text(
                "Welcome Back!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28, // Larger font
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                "Log in to continue your learning adventure",
                style: TextStyle(color: Colors.white70, fontSize: 16), // Larger description text
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40), // Increased spacing before form

              // Username Field
              TextField(
                controller: _usernameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Username",
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF1C1F3E),
                  prefixIcon: const Icon(Icons.person, color: kAccentColor), // Accent icon color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: kButtonColor, width: 2), // Focus glow
                  ),
                ),
              ),
              const SizedBox(height: 20), // Increased spacing

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
                  prefixIcon: const Icon(Icons.lock, color: kAccentColor), // Accent icon color
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
              const SizedBox(height: 30), // Increased spacing

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 55, // Taller button
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Pill-shaped button
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Forgot Password
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                  );
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.purpleAccent, fontSize: 16),
                ),
              ),

              // Sign Up
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StudentSignupScreen()),
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