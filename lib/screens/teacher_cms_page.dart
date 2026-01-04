import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
  List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      const ContentManagementView(),
      const ProgressTrackingView(),
      CommunicationView(onRefresh: () => setState(() {})),
    ];
  }

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
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Content',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Progress',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: accentColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: primaryDark,
        onTap: _onItemTapped,
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
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
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
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
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
      {
        'title': 'The Water Cycle',
        'grade': 'Grade 5',
        'status': 'Live',
        'date': 'Oct 25',
      },
      {
        'title': 'Simple Machines Quiz',
        'grade': 'Grade 4',
        'status': 'Draft',
        'date': 'Nov 18',
      },
      {
        'title': 'Planetary Systems',
        'grade': 'Grade 6',
        'status': 'Pending Review',
        'date': 'Nov 19',
      },
      {
        'title': 'Video: Cell Biology',
        'grade': 'Grade 6',
        'status': 'Live',
        'date': 'Sep 01',
      },
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
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            title: Text(
              item['title']!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              item['grade']! + ' | Last Edit: ' + item['date']!,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
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
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
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
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          _buildRosterList(cardColor, accentColor, warningColor),
        ],
      ),
    );
  }

  // Refactored table to a mobile-friendly list view
  Widget _buildRosterList(
    Color cardColor,
    Color accentColor,
    Color warningColor,
  ) {
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
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            leading: CircleAvatar(
              backgroundColor: scoreColor.withOpacity(0.2),
              child: Text(
                student['name'][0],
                style: TextStyle(
                  color: scoreColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              student['name'],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'Avg. Score: ${student['avg']}%',
              style: TextStyle(color: scoreColor, fontWeight: FontWeight.bold),
            ),
            trailing:
                student['alerts'] > 0
                    ? Icon(Icons.error, color: warningColor, size: 20)
                    : const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                      size: 20,
                    ),
            onTap: () {
              // Action to view student details
            },
          );
        },
      ),
    );
  }
}

// --- COMMUNICATION VIEW (Tab 2) - WITH REAL MESSAGES ---
class CommunicationView extends StatefulWidget {
  final VoidCallback onRefresh;

  const CommunicationView({super.key, required this.onRefresh});

  @override
  State<CommunicationView> createState() => _CommunicationViewState();
}

class _CommunicationViewState extends State<CommunicationView> {
  final Color cardColor = const Color(0xFF1E2140);
  final Color accentColor = const Color(0xFF4CAF50);

  List<Map<String, dynamic>> _messages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    setState(() => _isLoading = true);

    final prefs = await SharedPreferences.getInstance();
    String? messagesJson = prefs.getString('admin_messages');

    if (messagesJson != null) {
      List<dynamic> allMessages = jsonDecode(messagesJson);
      // Filter messages where recipient is "Teacher"
      _messages =
          allMessages
              .map((e) => Map<String, dynamic>.from(e))
              .where((msg) => msg['to'] == 'Teacher')
              .toList();
    }

    setState(() => _isLoading = false);
  }

  Future<void> _markAsRead(Map<String, dynamic> message) async {
    final prefs = await SharedPreferences.getInstance();
    String? messagesJson = prefs.getString('admin_messages');

    if (messagesJson != null) {
      List<dynamic> allMessages = jsonDecode(messagesJson);

      // Find and update the message
      for (var msg in allMessages) {
        if (msg['id'] == message['id']) {
          msg['isRead'] = true;
          break;
        }
      }

      // Save back
      await prefs.setString('admin_messages', jsonEncode(allMessages));

      // Update local state
      setState(() {
        message['isRead'] = true;
      });
    }
  }

  void _viewMessageDetails(Map<String, dynamic> message) {
    _markAsRead(message);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: cardColor,
            title: Row(
              children: [
                const Icon(Icons.message, color: Color(0xFF4CAF50)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    message['subject'] ?? 'No Subject',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDetailRow(Icons.person, 'From', message['from']),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    Icons.access_time,
                    'Sent',
                    _formatTimestamp(message['timestamp']),
                  ),
                  const Divider(color: Colors.white24, height: 24),
                  const Text(
                    'Message:',
                    style: TextStyle(
                      color: Color(0xFF4CAF50),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message['message'] ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF4CAF50), size: 18),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
      ],
    );
  }

  String _formatTimestamp(String timestamp) {
    try {
      final date = DateTime.parse(timestamp);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inMinutes < 60) {
        return '${difference.inMinutes}m ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours}h ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays}d ago';
      } else {
        return '${date.day}/${date.month}/${date.year}';
      }
    } catch (e) {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = _messages.where((m) => !(m['isRead'] ?? false)).length;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Student Messages',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  if (unreadCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$unreadCount new',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    onPressed: _loadMessages,
                    tooltip: 'Refresh Messages',
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Messages List
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: CircularProgressIndicator(color: Color(0xFF4CAF50)),
              ),
            )
          else if (_messages.isEmpty)
            Card(
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: const Padding(
                padding: EdgeInsets.all(40.0),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.inbox, size: 60, color: Colors.white24),
                      SizedBox(height: 16),
                      Text(
                        'No messages yet',
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            Card(
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isRead = message['isRead'] ?? false;

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: isRead ? Colors.grey : accentColor,
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                        if (!isRead)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                    title: Text(
                      message['subject'] ?? 'No Subject',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                            isRead ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From: @${message['from']}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          _formatTimestamp(message['timestamp']),
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.white54,
                    ),
                    onTap: () => _viewMessageDetails(message),
                  );
                },
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ), // Reduced font size
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
        style: TextStyle(
          color: _getColor(),
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
