import 'package:flutter/material.dart';

// --- MAIN WIDGET ---
class TeacherCMSPage extends StatefulWidget {
  const TeacherCMSPage({super.key});

  @override
  State<TeacherCMSPage> createState() => _TeacherCMSPageState();
}

class _TeacherCMSPageState extends State<TeacherCMSPage> {
  int _selectedIndex = 0;

  final Color primaryDark = const Color(0xFF0D102C);
  final Color cardColor = const Color(0xFF1E2140);
  final Color accentColor = const Color(0xFF4CAF50);
  final Color warningColor = const Color(0xFFFF9800);

  // Define all views here
  final List<Widget> _widgetOptions = const <Widget>[
    ContentManagementView(),
    ProgressTrackingView(),
    CommunicationView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDark,
      appBar: AppBar(
        title: const Text(
          "Science CMS & Teacher Hub",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: primaryDark,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {},
            tooltip: 'Profile',
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      
      
    );
  }
}


// --- CONTENT MANAGEMENT VIEW (Tab 0) ---
class ContentManagementView extends StatelessWidget {
  const ContentManagementView({super.key});

  final Color cardColor = const Color(0xFF1E2140);
  final Color accentColor = const Color(0xFF4CAF50);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header and Create Button
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Content Overview',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // Button is now compact for mobile
                ElevatedButton.icon(
                  onPressed: () {
                    // Mock function to create new content
                  },
                  icon: const Icon(Icons.add, size: 18, color: Colors.white),
                  label: const Text('Create'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),

          // Key Metrics Cards (Changed from 4-column to 2-column grid for mobile)
          GridView.count(
            crossAxisCount: 2, // Optimized for mobile screen width
            shrinkWrap: true,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _MetricCard(
                title: 'Live Lessons',
                value: '142',
                icon: Icons.check_circle_outline,
                color: accentColor,
                cardColor: cardColor,
              ),
              _MetricCard(
                title: 'Drafts in Progress',
                value: '7',
                icon: Icons.edit_note,
                color: Colors.blueAccent,
                cardColor: cardColor,
              ),
              _MetricCard(
                title: 'Pending Admin Review',
                value: '2',
                icon: Icons.pending_actions,
                color: Colors.orange,
                cardColor: cardColor,
              ),
              _MetricCard(
                title: 'Total Questions in Bank',
                value: '850',
                icon: Icons.help_outline,
                color: Colors.purpleAccent,
                cardColor: cardColor,
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Detailed Content List
          Text(
            'Recent Activity & Lesson Status',
            style: TextStyle(color: Colors.grey[300], fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          _buildContentStatusList(cardColor, accentColor),
        ],
      ),
    );
  }

  // Refactored table to a mobile-friendly list view
  Widget _buildContentStatusList(Color cardColor, Color accentColor) {
    final List<Map<String, String>> data = [
      {'title': 'The Water Cycle', 'grade': 'Grade 5', 'status': 'Live', 'date': 'Oct 25'},
      {'title': 'Simple Machines Quiz', 'grade': 'Grade 4', 'status': 'Draft', 'date': 'Nov 18'},
      {'title': 'Planetary Systems', 'grade': 'Grade 6', 'status': 'Pending Review', 'date': 'Nov 19'},
      {'title': 'Video: Cell Biology', 'grade': 'Grade 6', 'status': 'Live', 'date': 'Sep 01'},
    ];

    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(item['title']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            subtitle: Text(item['grade']! + ' | Last Edit: ' + item['date']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _StatusPill(status: item['status']!, accentColor: accentColor),
                const SizedBox(width: 8),
                const Icon(Icons.edit, color: Colors.grey, size: 20),
              ],
            ),
            onTap: () {
              // Action to open lesson editor
            },
          );
        },
      ),
    );
  }
}

// --- PROGRESS TRACKING VIEW (Tab 1) ---
class ProgressTrackingView extends StatelessWidget {
  const ProgressTrackingView({super.key});
  final Color cardColor = const Color(0xFF1E2140);
  final Color accentColor = const Color(0xFF4CAF50);
  final Color warningColor = const Color(0xFFFF9800);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Student Progress Analytics',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // Key Analytics Cards (Changed from 3-column to 2-column grid for mobile)
          GridView.count(
            crossAxisCount: 2, // Optimized for mobile screen width
            shrinkWrap: true,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _MetricCard(
                title: 'Class Average Score',
                value: '84.5%',
                icon: Icons.trending_up,
                color: accentColor,
                cardColor: cardColor,
              ),
              _MetricCard(
                title: 'Students Needing Help',
                value: '5',
                icon: Icons.person_search,
                color: warningColor,
                cardColor: cardColor,
              ),
              _MetricCard(
                title: 'Assignments Completed',
                value: '32',
                icon: Icons.assignment_turned_in,
                color: Colors.cyan,
                cardColor: cardColor,
              ),
              // Empty spacer card for alignment
              const SizedBox.shrink(),
            ],
          ),
          const SizedBox(height: 30),

          // Student Roster with Metrics
          Text(
            'Roster & Individual Performance',
            style: TextStyle(color: Colors.grey[300], fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          _buildRosterList(cardColor, accentColor, warningColor),
        ],
      ),
    );
  }

  // Refactored table to a mobile-friendly list view
  Widget _buildRosterList(Color cardColor, Color accentColor, Color warningColor) {
    final List<Map<String, dynamic>> students = [
      {'name': 'Alice Johnson', 'avg': 92, 'alerts': 0},
      {'name': 'Ben Carter', 'avg': 68, 'alerts': 2},
      {'name': 'Chloe Davis', 'avg': 81, 'alerts': 0},
      {'name': 'David Lee', 'avg': 73, 'alerts': 1},
    ];

    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          final scoreColor = student['avg'] > 75 ? accentColor : warningColor;
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: CircleAvatar(
              backgroundColor: scoreColor.withOpacity(0.2),
              child: Text(student['name'][0], style: TextStyle(color: scoreColor, fontWeight: FontWeight.bold)),
            ),
            title: Text(student['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            subtitle: Text('Avg. Score: ${student['avg']}%', style: TextStyle(color: scoreColor, fontWeight: FontWeight.bold)),
            trailing: student['alerts'] > 0
                ? Icon(Icons.error, color: warningColor, size: 20)
                : const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
            onTap: () {
              // Action to view student details
            },
          );
        },
      ),
    );
  }
}

// --- COMMUNICATION VIEW (Tab 2) ---
class CommunicationView extends StatelessWidget {
  const CommunicationView({super.key});

  final Color cardColor = const Color(0xFF1E2140);
  final Color accentColor = const Color(0xFF4CAF50);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16), // Padding adjustment for bottom nav
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Announcements & Q&A',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Q&A / Discussion Moderation Card
          Card(
            color: cardColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pending Q&A Messages',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  const Divider(color: Color(0xFF2E3150), height: 30),
                  _QaItem(
                    cardColor: cardColor,
                    topic: 'Magnetism Unit',
                    question: 'Why doesn\'t every metal stick to a magnet?',
                    student: 'Liam M. (G5)',
                  ),
                  _QaItem(
                    cardColor: cardColor,
                    topic: 'Ecosystems Lesson',
                    question: 'Can we use outside videos for the project?',
                    student: 'Sophia K. (G4)',
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward, size: 18),
                      label: const Text('View All Q&A'),
                      style:
                          TextButton.styleFrom(foregroundColor: accentColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Send Announcement Card
          Card(
            color: cardColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Send New Announcement',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      fillColor: const Color(0xFF2E3150),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Message Content',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      fillColor: const Color(0xFF2E3150),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.send, color: Colors.white, size: 18),
                      label: const Text('Send'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// --- REUSABLE HELPER WIDGETS ---

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final Color cardColor;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Reduced padding for mobile
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.grey[400], fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(icon, color: color, size: 24),
              ],
            ),
            Text(
              value,
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold), // Reduced font size
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String status;
  final Color accentColor;

  const _StatusPill({required this.status, required this.accentColor});

  Color _getColor() {
    switch (status) {
      case 'Live':
        return accentColor;
      case 'Draft':
        return Colors.blue;
      case 'Pending Review':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _getColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _getColor(), width: 1),
      ),
      child: Text(
        status,
        style: TextStyle(color: _getColor(), fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _QaItem extends StatelessWidget {
  final Color cardColor;
  final String topic;
  final String question;
  final String student;

  const _QaItem({
    required this.cardColor,
    required this.topic,
    required this.question,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF2E3150)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Topic: $topic | $student',
            style: const TextStyle(color: Color(0xFF4CAF50), fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            question,
            style: const TextStyle(color: Colors.white),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50).withOpacity(0.8),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: const Text('Reply', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}