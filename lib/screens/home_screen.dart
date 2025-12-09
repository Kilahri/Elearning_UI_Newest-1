import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

// 1. Define SettingsScreenPlaceholder for correct navigation (based on user request)
class SettingsScreenPlaceholder extends StatelessWidget {
  const SettingsScreenPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SETTINGS", style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF415A77)),
      backgroundColor: const Color(0xFF0D1B2A),
      body: const Center(child: Text("This is the Settings Screen.", style: TextStyle(color: Colors.white70, fontSize: 18))),
    );
  }
}

// --- Placeholder Screens (Assuming these will be separate files later) ---
class PlayScreenPlaceholder extends StatelessWidget {
  const PlayScreenPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PLAY: Games & Quizzes", style: TextStyle(color: Colors.white)), backgroundColor: Colors.deepPurple),
      backgroundColor: const Color(0xFF0D102C),
      body: const Center(child: Text("Welcome to the Play Zone!", style: TextStyle(color: Colors.white70, fontSize: 18))),
    );
  }
}

class WatchScreenPlaceholder extends StatelessWidget {
  const WatchScreenPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("WATCH: Science Videos", style: TextStyle(color: Colors.white)), backgroundColor: Colors.teal),
      backgroundColor: const Color(0xFF0D102C),
      body: const Center(child: Text("Welcome to the Video Library!", style: TextStyle(color: Colors.white70, fontSize: 18))),
    );
  }
}

class ReadScreenPlaceholder extends StatelessWidget {
  const ReadScreenPlaceholder({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("READ: Articles & Books", style: TextStyle(color: Colors.white)), backgroundColor: Colors.orange),
      backgroundColor: const Color(0xFF0D102C),
      body: const Center(child: Text("Welcome to the Reading Section!", style: TextStyle(color: Colors.white70, fontSize: 18))),
    );
  }
}
// ---------------------------------------------------------------------

class HomeScreen extends StatelessWidget {
  final String role;
  const HomeScreen({super.key, required this.role});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D102C), Color(0xFF1E2152)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🚀 FIXED & ENHANCED: Top Branded Header with Settings Button
                _buildHeader(context, role),

                const SizedBox(height: 12),

                // Header Banner
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7B4DFF), Color(0xFF5B36C9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Explore Science",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Play • Watch • Read\nLearn and enjoy everyday!",
                              style: TextStyle(fontSize: 14, color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                      Image.asset("lib/assets/owl.png", height: 100, width: 100),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Activities Section Title
                _sectionTitle("Activities", "View all"),
                const SizedBox(height: 12),

                // Activities List (Functional)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // FUNCTIONAL: Navigate to PlayScreenPlaceholder
                      _activityCard(
                        title: "PLAY",
                        subtitle: "Games & Quizzes",
                        color: Colors.deepPurple,
                        imagePath: "lib/assets/play.png",
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) => const PlayScreenPlaceholder()));
                        },
                      ),
                      const SizedBox(width: 12),
                      // FUNCTIONAL: Navigate to WatchScreenPlaceholder
                      _activityCard(
                        title: "WATCH",
                        subtitle: "Science Videos",
                        color: Colors.teal,
                        imagePath: "lib/assets/video.png",
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) => const WatchScreenPlaceholder()));
                        },
                      ),
                      const SizedBox(width: 12),
                      // FUNCTIONAL: Navigate to ReadScreenPlaceholder
                      _activityCard(
                        title: "READ",
                        subtitle: "Articles & Books",
                        color: Colors.orange,
                        imagePath: "lib/assets/popularRead.png",
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) => const ReadScreenPlaceholder()));
                        },
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Popular Section Title
                _sectionTitle("Popular", "View all"),
                const SizedBox(height: 16),

                // Popular Items (Functional)
                // FUNCTIONAL: Navigate to PlayScreenPlaceholder
                _popularItem(
                  title: "Puzzle, Matching Game, Quizzes and more",
                  tag: "GAMES",
                  color: Colors.deepPurple,
                  imagePath: "lib/assets/popularPlay.png",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => const PlayScreenPlaceholder()));
                  },
                ),
                // FUNCTIONAL: Navigate to WatchScreenPlaceholder
                _popularItem(
                  title: "Science Videos - Earth, Space and Life",
                  tag: "VIDEOS",
                  color: Colors.teal,
                  imagePath: "lib/assets/video.png",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => const WatchScreenPlaceholder()));
                  },
                ),
                // FUNCTIONAL: Navigate to ReadScreenPlaceholder
                _popularItem(
                  title: "Science Books & Articles",
                  tag: "READ",
                  color: Colors.orange,
                  imagePath: "lib/assets/popularRead.png",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => const ReadScreenPlaceholder()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets for UI structure ---

  // FIXED: Added the Settings IconButton and logic
  Widget _buildHeader(BuildContext context, String role) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SciLearn App Name
            Row(
              children: const [
                Icon(Icons.science, color: Color(0xFFFFC107), size: 28),
                SizedBox(width: 6),
                Text(
                  "SciLearn",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),

            // Settings Button (FIXED NAVIGATION)
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white70, size: 24),
              onPressed: () {
                // This is the line that was fixed to navigate to the correct screen.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreenPlaceholder()),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Welcome Message (moved from banner)
        Text(
          "Welcome $role 👋",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title, String viewAllText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: () {
            // Placeholder for View All functionality
          },
          child: Text(
            viewAllText,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ),
      ],
    );
  }

  // Activity Card (Updated)
  static Widget _activityCard({
    required String title,
    required String subtitle,
    required Color color,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160, // Adjusted width
        height: 120, // Adjusted height
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.8), // Solid color for depth
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Section (Title)
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            
            // Bottom Section (Subtitle and Image)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    height: 40,
                    width: 40,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Popular Item (Updated to be functional)
  static Widget _popularItem({
    required String title,
    required String tag,
    required Color color,
    required String imagePath,
    required VoidCallback onTap, // ADDED for functionality
  }) {
    return GestureDetector(
      onTap: onTap, // Making the item clickable
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFF1C1F3E), // Consistent background color
          border: Border.all(color: color.withOpacity(0.5), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            // Left Image
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
            ),

            // Middle Text
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            // Right Tag + Play Button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tag,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Icon(Icons.play_circle_fill, color: Colors.white, size: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}