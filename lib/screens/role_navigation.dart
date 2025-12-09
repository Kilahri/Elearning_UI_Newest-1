import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'play_screen.dart';
import 'watch_screen.dart';
import 'read_screen.dart';
import 'analytics_screen.dart';
import 'settings_screen.dart';

// THESE TWO MUST EXIST
import 'teacher_cms_page.dart' show TeacherCMSPage; 
import 'progress_tracking_view.dart';



// 🎨 Updated Constants for dark theme
const Color kStudentColor = Color(0xFFFFC107);
const Color kTeacherColor = Color(0xFF42A5F5);
const Color kDarkGradientStart = Color(0xFF0D102C);
const Color kDarkGradientEnd = Color(0xFF1E2152);
const double kIconSize = 30.0;
const double kSelectedFontSize = 14.0;

class RoleNavigation extends StatefulWidget {
  final String role;
  const RoleNavigation({super.key, required this.role});

  @override
  State<RoleNavigation> createState() => _RoleNavigationState();
}

class _RoleNavigationState extends State<RoleNavigation> {
  int _selectedIndex = 0;

  late List<Widget> _pages;
  late List<BottomNavigationBarItem> _studentTabs;
  late List<BottomNavigationBarItem> _teacherAdminTabs;

  @override
  void initState() {
    super.initState();

    // ALL POSSIBLE PAGES
    _pages = [
      HomeScreen(role: widget.role),         // 0
      PlayScreen(role: widget.role),         // 1
      const WatchScreen(),                   // 2
      const ReadScreen(),                    // 3
      const AnalyticsScreen(),               // 4
      const SettingsScreen(),                // 5
      const TeacherCMSPage(),                // 6  → Teacher CMS
      const ProgressTrackingView(),          // 7  → Separate Progress Tracking Page
    ];

    // STUDENT TABS
    _studentTabs = const [
      BottomNavigationBarItem(
          icon: Icon(Icons.star_half_rounded, size: kIconSize),
          label: "My Zone"),
      BottomNavigationBarItem(
          icon: Icon(Icons.sports_esports, size: kIconSize),
          label: "Play Games"),
      BottomNavigationBarItem(
          icon: Icon(Icons.movie_filter_rounded, size: kIconSize),
          label: "Watch"),
      BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_rounded, size: kIconSize),
          label: "Read Books"),
      BottomNavigationBarItem(
          icon: Icon(Icons.settings, size: kIconSize),
          label: "Settings"),
    ];

    // TEACHER / ADMIN TABS (NO HOME, NO ANALYTICS PAGE)
    _teacherAdminTabs = const [
      BottomNavigationBarItem(
        icon: Icon(Icons.menu_book, size: kIconSize),
        label: "Content",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.analytics, size: kIconSize),
        label: "Progress",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chat_bubble_outline, size: kIconSize),
        label: "Comments",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person, size: kIconSize),
        label: "Profile",
      ),
    ];
  }

  // NAVIGATION SWITCH
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // STUDENT VS TEACHER NAVIGATION ITEMS
  List<BottomNavigationBarItem> _getNavigationItems() {
    return (widget.role == 'Teacher' || widget.role == 'Admin')
        ? _teacherAdminTabs
        : _studentTabs;
  }

  // MAP TABS TO PAGE INDEX
  int _getPageMapIndex(int selectedIndex) {
  if (widget.role == 'Teacher' || widget.role == 'Admin') {
    // Teacher/Admin mapping (keep as is or fix if needed)
    switch (selectedIndex) {
      case 0: return 6; // Content → TeacherCMSPage
      case 1: return 7; // Progress → ProgressTrackingView
      case 2: return 6; // Communication still inside CMS
      case 3: return 5; // Profile → Settings
      default: return 6;
    }
  } else {
    // Student mapping
    switch (selectedIndex) {
      case 0: return 0; // My Zone/Home
      case 1: return 1; // Play
      case 2: return 2; // Watch
      case 3: return 3; // Read
      case 4: return 5; // Settings → was 4/Analytics
      default: return 0;
    }
  }
}


  @override
  Widget build(BuildContext context) {
    final navItems = _getNavigationItems();
    final bool isStudent = !(widget.role == 'Teacher' || widget.role == 'Admin');

    final Color selectedColor = isStudent ? kStudentColor : kTeacherColor;
    final Color unselectedColor = selectedColor.withOpacity(0.6);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [kDarkGradientStart, kDarkGradientEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _pages[_getPageMapIndex(_selectedIndex)],
      ),

      // 🔥 FIXED — NO ERRORS
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: selectedColor,
        unselectedItemColor: unselectedColor,
        selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: kSelectedFontSize),
        unselectedLabelStyle: const TextStyle(fontSize: 12.0),
        backgroundColor: kDarkGradientEnd,
        elevation: 10,
        items: navItems,
      ),
    );
  }
}
