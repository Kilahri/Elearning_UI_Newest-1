import 'package:flutter/material.dart';

// --- Data Models and Placeholders ---
class BadgeData {
  final String title;
  final String level;
  final String status;
  final Color color;
  final String category;

  const BadgeData(this.title, this.level, this.status, this.color, this.category);
}

// Placeholder Data for the screen
const Color accentColor = Color(0xFF7B4DFF); // Purple accent
const Color backgroundColor = Color(0xFF0D102C); // Deep blue background
const Color cardColor = Color(0xFF1C1F3E); // Darker card color

const int totalLessons = 60;
const int lessonsCompleted = 45;
const double overallProgress = lessonsCompleted / totalLessons; // 75%
const int badgesUnlocked = 12;
const String masteryLevel = "Junior Scientist";
const String timeSpent = "5 hours this week";
const double averageQuizScore = 85.0;
const String bestQuiz = "98% on 'The Water Cycle' Quiz";

final List<Map<String, dynamic>> topicMasteryData = [
  {"topic": "Biology", "score": 92, "level": "Expert", "color": Colors.green},
  {"topic": "Chemistry", "score": 78, "level": "Proficient", "color": Colors.blue},
  {"topic": "Physics", "score": 65, "level": "Developing", "color": Colors.orange},
  {"topic": "Earth Science", "score": 88, "level": "Expert", "color": Colors.cyan},
];

final List<String> improvementAreas = [
  "Forces and Motion",
  "Chemical Reactions",
  "Plant Structures",
];

final List<BadgeData> allBadges = [
  // Puzzle
  const BadgeData("Logic Master", "Star", "Completed", Colors.deepPurple, "Puzzle"),
  const BadgeData("Sequence Solver", "Senior", "75%", Colors.lightBlue, "Puzzle"),
  const BadgeData("Element Master", "Junior", "0%", Colors.indigo, "Puzzle"),
  // Adventure
  const BadgeData("Explorer", "Senior", "Completed", Colors.teal, "Adventure"),
  const BadgeData("Discovery Scout", "Junior", "40%", Colors.green, "Adventure"),
  const BadgeData("Map Reader", "None", "0%", Colors.grey, "Adventure"),
  // Trivia
  const BadgeData("Quick Thinker", "Star", "Completed", Colors.green, "Trivia"),
  const BadgeData("Knowledge Seeker", "Senior", "25%", Colors.orange, "Trivia"),
  const BadgeData("Fact Hunter", "Junior", "0%", Colors.blue, "Trivia"),
  // Quiz
  const BadgeData("Assessment Ace", "Star", "50%", Colors.redAccent, "Quiz"),
  const BadgeData("Quiz Champ", "Senior", "0%", Colors.orange, "Quiz"),
  const BadgeData("Speed Brain", "None", "0%", Colors.grey, "Quiz"),
];

// Group badges by category for the new layout
final Map<String, List<BadgeData>> groupedBadges = {
  for (var category in allBadges.map((e) => e.category).toSet())
    category: allBadges.where((b) => b.category == category).toList()
};

// --- Main Screen Widget ---

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: cardColor,
        elevation: 4,
        title: const Text("Student Progress & Badges",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // Use SingleChildScrollView for the entire body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // 1. Overall Mastery & Summary
            // =========================================================
            _buildSectionTitle(context, "Overall Mastery & Summary", accentColor),
            const SizedBox(height: 12),
            _buildOverallSummaryCard(
              overallProgress: overallProgress,
              badgesUnlocked: badgesUnlocked,
              masteryLevel: masteryLevel,
              timeSpent: timeSpent,
              accentColor: accentColor,
              cardColor: cardColor,
            ),
            const SizedBox(height: 30),

            // =========================================================
            // 2. Detailed Performance Metrics 📊
            // =========================================================
            _buildSectionTitle(context, "Detailed Performance Metrics 📊", accentColor),
            const SizedBox(height: 12),
            // A. Topic Mastery
            _buildTopicMastery(topicMasteryData, cardColor),
            const SizedBox(height: 20),
            // B. Assessment Analytics
            _buildAssessmentAnalytics(cardColor, averageQuizScore, bestQuiz, improvementAreas),
            const SizedBox(height: 20),
            // C. Learning Engagement
            _buildEngagementMetrics(cardColor),
            const SizedBox(height: 30),

            // =========================================================
            // 3. Specific Achievements (Badges) 🏆
            // =========================================================
            _buildSectionTitle(context, "Specific Achievements (Badges) 🏆", accentColor),
            const SizedBox(height: 12),
            // Renders all badge categories vertically
            _buildBadgeCategories(groupedBadges, cardColor),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets for Layout ---

  Widget _buildSectionTitle(BuildContext context, String title, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 3,
          width: 120,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildOverallSummaryCard({
    required double overallProgress,
    required int badgesUnlocked,
    required String masteryLevel,
    required String timeSpent,
    required Color accentColor,
    required Color cardColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [cardColor, cardColor.withOpacity(0.9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Progress Ring
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: overallProgress,
                  backgroundColor: Colors.white12,
                  valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                  strokeWidth: 8,
                ),
                Text(
                  "${(overallProgress * 100).toInt()}%",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  masteryLevel,
                  style: const TextStyle(
                      color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Total Progress: ${lessonsCompleted}/${totalLessons} lessons",
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.emoji_events, color: accentColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      "$badgesUnlocked Badges Unlocked",
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.timer, color: Colors.teal, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      "Time Spent: $timeSpent",
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicMastery(List<Map<String, dynamic>> data, Color cardColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Topic Mastery", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: data.map((item) {
              Color barColor = item['color'] as Color;
              double score = item['score'] / 100;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        "${item['topic']}:",
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: score,
                        backgroundColor: Colors.white12,
                        valueColor: AlwaysStoppedAnimation<Color>(barColor),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text("${item['score']}% (${item['level']})",
                        style: TextStyle(color: barColor, fontSize: 14)),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAssessmentAnalytics(
      Color cardColor,
      double averageScore,
      String bestQuiz,
      List<String> improvementAreas) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Assessment Analytics", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMetricRow("Average Quiz Score:", "${averageScore.toInt()}%", Colors.yellow),
              _buildMetricRow("Best Performance:", bestQuiz, Colors.lightGreen),
              const SizedBox(height: 10),
              const Text("Areas for Improvement (Top 3):",
                  style: TextStyle(color: Colors.redAccent, fontSize: 15, fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              ...improvementAreas.map((area) => Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 2),
                    child: Text("• $area", style: const TextStyle(color: Colors.white70, fontSize: 14)),
                  )),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildEngagementMetrics(Color cardColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Learning Engagement", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              _buildMetricRow("Lessons Completed:", "${lessonsCompleted}/${totalLessons}", Colors.lightBlue),
              _buildMetricRow("Videos Watched:", "22 hours", Colors.pinkAccent),
              _buildMetricRow("Practice Questions:", "500+", Colors.orange),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricRow(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 15)),
          Text(value, style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Refactored badge section to display all categories vertically
  Widget _buildBadgeCategories(Map<String, List<BadgeData>> groupedBadges, Color cardColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groupedBadges.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: BadgeCategory(
            categoryName: entry.key,
            badges: entry.value,
            cardColor: cardColor,
          ),
        );
      }).toList(),
    );
  }
}

// --- Badge Rendering Widgets (Kept largely the same, removed Expanded) ---

class BadgeCategory extends StatelessWidget {
  final String categoryName;
  final List<BadgeData> badges;
  final Color cardColor;

  const BadgeCategory({
    super.key,
    required this.categoryName,
    required this.badges,
    required this.cardColor,
  });

  IconData getLevelIcon(String level) {
    switch (level) {
      case "Junior":
        return Icons.emoji_events_outlined;
      case "Senior":
        return Icons.military_tech;
      case "Star":
        return Icons.star;
      default:
        return Icons.lock_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const crossAxisCount = 2;
    // Calculate GridView height based on items to avoid errors inside SingleChildScrollView
    const double itemHeight = 180.0;
    final itemWidth = (screenWidth - 32) / crossAxisCount - 8;
    final aspectRatio = itemWidth / itemHeight;
    final gridHeight = (badges.length / crossAxisCount).ceil() * (itemHeight + 16); // height * rows + mainAxisSpacing * rows

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            categoryName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: gridHeight, // Use calculated height instead of Expanded
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(), // Disable internal scrolling
            itemCount: badges.length,
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: aspectRatio,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return BadgeCard(
                badge: badges[index],
                levelIcon: getLevelIcon(badges[index].level),
              );
            },
          ),
        ),
      ],
    );
  }
}

class BadgeCard extends StatelessWidget {
  final BadgeData badge;
  final IconData levelIcon;

  const BadgeCard({
    super.key,
    required this.badge,
    required this.levelIcon,
  });

  @override
  Widget build(BuildContext context) {
    bool isCompleted = badge.status == "Completed";
    double progress = (double.tryParse(badge.status.replaceAll('%', '')) ?? 0.0) / 100;
    bool isNotReached = progress == 0.0 && !isCompleted;

    return Container(
      decoration: BoxDecoration(
        color: cardColor, // Dark card background
        borderRadius: BorderRadius.circular(16),
        boxShadow: isCompleted
            ? [
                BoxShadow(
                  color: badge.color.withOpacity(0.4),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
        border: Border.all(
          color: isCompleted ? badge.color : Colors.white10,
          width: isCompleted ? 2.5 : 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Badge Icon and Title
            Flexible(
              child: Column(
                children: [
                  AnimatedScale(
                    scale: isCompleted ? 1.1 : 1.0,
                    duration: const Duration(milliseconds: 400),
                    child: Icon(
                      levelIcon,
                      // Icon color fades if locked
                      color: badge.color.withOpacity(isNotReached ? 0.3 : 1.0),
                      size: 45,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    badge.title,
                    style: TextStyle(
                      color: isNotReached ? Colors.white54 : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Progress/Status Footer
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    badge.level,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 8),
                if (isCompleted)
                  Text("🏆 ACHIEVED",
                      style: TextStyle(color: Colors.yellow[700], fontWeight: FontWeight.bold, fontSize: 14))
                else if (isNotReached)
                  const Text("🔒 LOCKED (0%)",
                      style: TextStyle(color: Colors.redAccent, fontSize: 14))
                else
                  Column(
                    children: [
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.white12,
                        valueColor: AlwaysStoppedAnimation<Color>(badge.color),
                      ),
                      const SizedBox(height: 4),
                      Text("Progress: ${badge.status}",
                          style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}