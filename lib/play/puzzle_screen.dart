import 'package:flutter/material.dart';
import 'dart:math';
// Import the Universal Leaderboard Service
import 'package:elearningapp_flutter/leaderboard/leaderboard.dart';

// ============================================================================
// SCIENCE FUSION GAME - Grade 6: Photosynthesis & Changes of Matter
// ============================================================================

// --- Element Visuals/Colors ---
final Map<String, dynamic> scienceVisuals = {
  // === PHOTOSYNTHESIS GAME ===
  // Starting Materials
  "Sunlight": {"color": Colors.amber, "icon": Icons.wb_sunny, "emoji": "☀️"},
  "Water": {
    "color": Colors.blueAccent,
    "icon": Icons.water_drop,
    "emoji": "💧",
  },
  "Carbon Dioxide": {"color": Colors.grey, "icon": Icons.air, "emoji": "💨"},
  "Soil": {"color": Colors.brown, "icon": Icons.landscape, "emoji": "🌱"},

  // Level 1: Basic Plant Parts
  "Roots": {
    "color": Colors.brown.shade700,
    "icon": Icons.arrow_downward,
    "emoji": "🌿",
  },
  "Leaves": {"color": Colors.green, "icon": Icons.eco, "emoji": "🍃"},
  "Stem": {"color": Colors.lightGreen, "icon": Icons.height, "emoji": "🌾"},
  "Chlorophyll": {
    "color": Colors.green.shade600,
    "icon": Icons.lens,
    "emoji": "💚",
  },

  // Level 2: Photosynthesis Process
  "Light Energy": {
    "color": Colors.yellow,
    "icon": Icons.flash_on,
    "emoji": "⚡",
  },
  "Absorbed Water": {
    "color": Colors.lightBlue,
    "icon": Icons.opacity,
    "emoji": "💦",
  },
  "Captured CO2": {
    "color": Colors.blueGrey,
    "icon": Icons.cloud,
    "emoji": "☁️",
  },
  "Plant Cell": {"color": Colors.teal, "icon": Icons.grid_4x4, "emoji": "🔬"},

  // Level 3: Products
  "Glucose": {"color": Colors.orange, "icon": Icons.cookie, "emoji": "🍯"},
  "Oxygen": {
    "color": Colors.lightBlue.shade200,
    "icon": Icons.bubble_chart,
    "emoji": "🫧",
  },
  "Plant Food": {"color": Colors.lime, "icon": Icons.restaurant, "emoji": "🥗"},
  "Growing Plant": {
    "color": Colors.green.shade400,
    "icon": Icons.park,
    "emoji": "🌿",
  },

  // === CHANGES OF MATTER GAME ===
  // Starting States
  "Ice": {
    "color": Colors.lightBlue.shade100,
    "icon": Icons.ac_unit,
    "emoji": "🧊",
  },
  "Liquid Water": {"color": Colors.blue, "icon": Icons.waves, "emoji": "💧"},
  "Heat": {
    "color": Colors.red,
    "icon": Icons.local_fire_department,
    "emoji": "🔥",
  },
  "Cold": {"color": Colors.cyan.shade100, "icon": Icons.ac_unit, "emoji": "❄️"},

  // Level 1: Physical Changes
  "Melting": {
    "color": Colors.lightBlue,
    "icon": Icons.thermostat,
    "emoji": "🌡️",
  },
  "Freezing": {
    "color": Colors.blue.shade200,
    "icon": Icons.severe_cold,
    "emoji": "🥶",
  },
  "Water Vapor": {"color": Colors.white70, "icon": Icons.cloud, "emoji": "☁️"},
  "Condensation": {
    "color": Colors.blueGrey,
    "icon": Icons.water_damage,
    "emoji": "💦",
  },

  // Level 2: States of Matter
  "Solid": {"color": Colors.grey.shade600, "icon": Icons.square, "emoji": "🧱"},
  "Liquid": {"color": Colors.blue.shade300, "icon": Icons.water, "emoji": "💧"},
  "Gas": {"color": Colors.white60, "icon": Icons.air, "emoji": "💨"},
  "Evaporation": {
    "color": Colors.lightBlue.shade200,
    "icon": Icons.arrow_upward,
    "emoji": "⬆️",
  },

  // Level 3: Advanced Concepts
  "Particles": {
    "color": Colors.purple,
    "icon": Icons.blur_circular,
    "emoji": "⚛️",
  },
  "Energy Change": {
    "color": Colors.orange,
    "icon": Icons.sync_alt,
    "emoji": "🔄",
  },
  "Phase Change": {
    "color": Colors.deepPurple,
    "icon": Icons.transform,
    "emoji": "✨",
  },
  "Matter Cycle": {
    "color": Colors.indigo,
    "icon": Icons.restart_alt,
    "emoji": "♻️",
  },
};

// --- Game Mode Selection ---
enum GameMode { photosynthesis, changesOfMatter }

// --- Level Data for PHOTOSYNTHESIS ---
const List<Map<String, dynamic>> photosynthesisLevels = [
  {
    "level": 1,
    "title": "Building the Plant",
    "description": "Learn about plant parts!",
    "requiredDiscoveries": 4,
    "combos": {
      "Soil+Water": "Roots",
      "Sunlight+Carbon Dioxide": "Leaves",
      "Roots+Sunlight": "Stem",
      "Leaves+Sunlight": "Chlorophyll",
    },
  },
  {
    "level": 2,
    "title": "Photosynthesis Begins",
    "description": "Capture energy and materials!",
    "requiredDiscoveries": 4,
    "combos": {
      "Sunlight+Chlorophyll": "Light Energy",
      "Roots+Water": "Absorbed Water",
      "Leaves+Carbon Dioxide": "Captured CO2",
      "Stem+Chlorophyll": "Plant Cell",
    },
  },
  {
    "level": 3,
    "title": "Making Food & Oxygen",
    "description": "Complete photosynthesis!",
    "requiredDiscoveries": 4,
    "combos": {
      "Light Energy+Captured CO2": "Glucose",
      "Absorbed Water+Light Energy": "Oxygen",
      "Glucose+Plant Cell": "Plant Food",
      "Plant Food+Oxygen": "Growing Plant",
    },
  },
];

// --- Level Data for CHANGES OF MATTER ---
const List<Map<String, dynamic>> matterLevels = [
  {
    "level": 1,
    "title": "Physical Changes",
    "description": "See matter transform!",
    "requiredDiscoveries": 4,
    "combos": {
      "Ice+Heat": "Melting",
      "Liquid Water+Cold": "Freezing",
      "Liquid Water+Heat": "Water Vapor",
      "Water Vapor+Cold": "Condensation",
    },
  },
  {
    "level": 2,
    "title": "States of Matter",
    "description": "Understand solid, liquid, gas!",
    "requiredDiscoveries": 4,
    "combos": {
      "Ice+Melting": "Liquid",
      "Liquid Water+Freezing": "Solid",
      "Water Vapor+Heat": "Gas",
      "Liquid Water+Heat": "Evaporation",
    },
  },
  {
    "level": 3,
    "title": "Matter Science",
    "description": "Master the science!",
    "requiredDiscoveries": 4,
    "combos": {
      "Solid+Liquid": "Particles",
      "Heat+Cold": "Energy Change",
      "Melting+Freezing": "Phase Change",
      "Evaporation+Condensation": "Matter Cycle",
    },
  },
];

// ============================================================================
// MAIN GAME SELECTION SCREEN
// ============================================================================

class ScienceFusionHome extends StatelessWidget {
  final String username;
  const ScienceFusionHome({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D102C), Color(0xFF2A1B4A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "🧪 Science Fusion Lab",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Hi, $username! Let's learn science!",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.leaderboard,
                        color: Colors.amber,
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => ScienceFusionLeaderboard(
                                  username: username,
                                ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Game Mode Cards
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildGameCard(
                      context,
                      title: "🌿 Photosynthesis Lab",
                      description: "Learn how plants make food from sunlight!",
                      color: Colors.green,
                      icon: Icons.eco,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => ScienceFusionGame(
                                  username: username,
                                  gameMode: GameMode.photosynthesis,
                                ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    _buildGameCard(
                      context,
                      title: "🧊 Changes of Matter Lab",
                      description:
                          "Discover how matter changes between states!",
                      color: Colors.blue,
                      icon: Icons.science,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => ScienceFusionGame(
                                  username: username,
                                  gameMode: GameMode.changesOfMatter,
                                ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameCard(
    BuildContext context, {
    required String title,
    required String description,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.6), color.withOpacity(0.3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 2),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, size: 40, color: Colors.white),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white70),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// MAIN GAME SCREEN
// ============================================================================

class ScienceFusionGame extends StatefulWidget {
  final String username;
  final GameMode gameMode;

  const ScienceFusionGame({required this.username, required this.gameMode});

  @override
  State<ScienceFusionGame> createState() => _ScienceFusionGameState();
}

class _ScienceFusionGameState extends State<ScienceFusionGame> {
  int currentLevel = 1;
  List<String> discoveredElements = [];
  String? targetElement;
  int score = 0;
  int hintsUsed = 0;
  int timeBonus = 0;
  DateTime? levelStartTime;

  List<String> baseElements = [];
  List<Map<String, dynamic>> levelData = [];
  String gameTitle = "";
  String gameId = "";

  @override
  void initState() {
    super.initState();
    _initializeGame();
    levelStartTime = DateTime.now();
  }

  void _initializeGame() {
    if (widget.gameMode == GameMode.photosynthesis) {
      baseElements = ["Sunlight", "Water", "Carbon Dioxide", "Soil"];
      levelData = photosynthesisLevels;
      gameTitle = "Photosynthesis Lab";
      gameId = "photosynthesis";
    } else {
      baseElements = ["Ice", "Liquid Water", "Heat", "Cold"];
      levelData = matterLevels;
      gameTitle = "Changes of Matter Lab";
      gameId = "matter_changes";
    }

    discoveredElements.addAll(baseElements);
    _pickNewTarget();
  }

  Map<String, String> get allAvailableCombos {
    Map<String, String> combos = {};
    for (int i = 0; i < currentLevel; i++) {
      combos.addAll(levelData[i]['combos'].cast<String, String>());
    }
    return combos;
  }

  List<String> get currentLevelTargets {
    return levelData[currentLevel - 1]['combos'].values
        .toSet()
        .toList()
        .cast<String>();
  }

  int get currentLevelDiscoveredTargetCount {
    return currentLevelTargets
        .where((e) => discoveredElements.contains(e))
        .length;
  }

  bool get isStageComplete =>
      currentLevelDiscoveredTargetCount ==
      levelData[currentLevel - 1]['requiredDiscoveries'];

  void _pickNewTarget() {
    if (isStageComplete) {
      targetElement = null;
      setState(() {});
      return;
    }

    final List<String> undiscoveredTargets =
        currentLevelTargets
            .where((element) => !discoveredElements.contains(element))
            .toList();

    if (undiscoveredTargets.isNotEmpty) {
      targetElement =
          undiscoveredTargets[Random().nextInt(undiscoveredTargets.length)];
    } else {
      targetElement = null;
    }
    setState(() {});
  }

  void _advanceLevel() {
    if (currentLevel < levelData.length) {
      // Calculate time bonus for completing level
      if (levelStartTime != null) {
        int secondsTaken = DateTime.now().difference(levelStartTime!).inSeconds;
        // Bonus points: faster completion = more bonus (max 50 points)
        timeBonus = max(0, 50 - secondsTaken ~/ 2);
        score += timeBonus;
      }

      currentLevel++;
      levelStartTime = DateTime.now();
      _showMessage(
        "🎉 Level Complete! +$timeBonus time bonus!\nAdvancing to Level $currentLevel",
        Colors.purpleAccent,
      );
      _pickNewTarget();
    } else {
      _completeGame();
    }
    setState(() {});
  }

  void _completeGame() async {
    // Calculate final score with bonuses
    int hintPenalty = hintsUsed * 5;
    int finalScore = max(0, score - hintPenalty);
    int maxScore = (levelData.length * 40 * 4) + 150; // Max possible score

    _showMessage(
      "🏆 Game Complete!\nFinal Score: $finalScore\n(Hint Penalty: -$hintPenalty)",
      Colors.amber,
    );

    // Save to Universal Leaderboard
    await UniversalLeaderboardService.saveScore(
      username: widget.username,
      gameId: gameId,
      category: "Level ${levelData.length}",
      score: finalScore,
      maxScore: maxScore,
      metadata: {
        'levelsCompleted': currentLevel,
        'hintsUsed': hintsUsed,
        'timeBonus': timeBonus,
        'discoveredElements': discoveredElements.length,
      },
    );

    // Show completion dialog
    await Future.delayed(Duration(seconds: 2));
    if (mounted) {
      _showCompletionDialog(finalScore, maxScore);
    }
  }

  void _showCompletionDialog(int finalScore, int maxScore) {
    int percentage = ((finalScore / maxScore) * 100).round();
    String rank =
        percentage >= 90
            ? "🏆 Master Scientist!"
            : percentage >= 75
            ? "🥇 Expert Scientist!"
            : percentage >= 60
            ? "🥈 Great Scientist!"
            : "🥉 Good Scientist!";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => AlertDialog(
            backgroundColor: Color(0xFF1C1F3E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Column(
              children: [
                Text("🎉", style: TextStyle(fontSize: 60)),
                SizedBox(height: 10),
                Text(
                  "Lab Complete!",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  rank,
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$finalScore / $maxScore",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$percentage% Perfect",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Discoveries: ${discoveredElements.length}",
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Hints Used: $hintsUsed",
                        style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  "Back to Menu",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => ScienceFusionLeaderboard(
                            username: widget.username,
                          ),
                    ),
                  );
                },
                child: Text(
                  "View Leaderboard",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
    );
  }

  void _combine(String target, String dragged) {
    if (target == dragged) return;
    if (isStageComplete) return;

    String? result;
    final Map<String, String> combos = allAvailableCombos;

    combos.forEach((key, value) {
      final parts = key.split('+');
      if ((parts.contains(target) && parts.contains(dragged))) {
        result = value;
      }
    });

    if (result != null) {
      if (!discoveredElements.contains(result)) {
        setState(() {
          discoveredElements.add(result!);
          score += 10;

          if (currentLevelTargets.contains(result)) {
            if (result == targetElement) {
              score += 30;
              _showMessage(
                "🎯 Perfect! You found the target: $result! (+40 pts)",
                Colors.greenAccent,
              );
            } else {
              score += 10;
              _showMessage(
                "✨ Great! You discovered: $result (+20 pts)",
                Colors.lightBlueAccent,
              );
            }
            Future.delayed(const Duration(milliseconds: 500), _pickNewTarget);
          } else {
            _showMessage(
              "✨ New discovery: $result (+10 pts)",
              Colors.lightBlueAccent,
            );
          }
        });
      } else {
        _showMessage("⚠️ Already discovered!", Colors.orangeAccent);
      }
    } else {
      _showMessage("❌ These don't combine", Colors.redAccent);
    }
  }

  void _showHint() {
    if (targetElement == null) return;

    final Map<String, String> combos = allAvailableCombos;
    String? hint;

    combos.forEach((key, value) {
      if (value == targetElement) {
        final parts = key.split('+');
        hint = "Try combining: ${parts[0]} + ${parts[1]}";
      }
    });

    if (hint != null) {
      hintsUsed++;
      score = max(0, score - 5);
      _showMessage("💡 Hint (-5 pts): $hint", Colors.yellowAccent);
    }
  }

  void _showMessage(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<String?> _showDiscoveredElementSelection(BuildContext context) async {
    final List<String> available =
        discoveredElements.where((e) => !baseElements.contains(e)).toList();

    if (available.isEmpty) {
      _showMessage(
        "No discoveries yet! Try combining base elements first!",
        Colors.orange,
      );
      return null;
    }

    return await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1C1F3E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Select a Discovery to Combine",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${available.length} discoveries available",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children:
                        available.map((element) {
                          return GestureDetector(
                            onTap: () => Navigator.pop(context, element),
                            child: _tile(element, size: 80.0),
                          );
                        }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final int requiredDiscoveries =
        levelData[currentLevel - 1]['requiredDiscoveries'];
    final int discoveredCount = currentLevelDiscoveredTargetCount;
    final double progress =
        requiredDiscoveries > 0 ? discoveredCount / requiredDiscoveries : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFF0D102C),
      appBar: AppBar(
        backgroundColor:
            widget.gameMode == GameMode.photosynthesis
                ? Colors.green.shade700
                : Colors.blue.shade700,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              gameTitle,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              "Level $currentLevel: ${levelData[currentLevel - 1]['title']}",
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.lightbulb_outline),
            onPressed: _showHint,
            tooltip: "Get Hint (-5 pts)",
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          // Info Panel
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildTargetDisplay(),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white24,
                  color: Colors.greenAccent,
                  minHeight: 8,
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Score: $score",
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Progress: $discoveredCount/$requiredDiscoveries",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "Hints: $hintsUsed",
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade900.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade700),
              ),
              child: Text(
                levelData[currentLevel - 1]['description'],
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "🧪 Drag elements onto each other or use the Fusion Pad!",
              style: TextStyle(color: Colors.white70, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 10),

          // Base Elements Grid
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: baseElements.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                final element = baseElements[index];
                return _draggableTile(element);
              },
            ),
          ),

          // Fusion Pad
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: DragTarget<String>(
              onWillAccept: (incoming) => incoming != null,
              onAccept: (incoming) async {
                String? selectedElement = await _showDiscoveredElementSelection(
                  context,
                );
                if (selectedElement != null) {
                  _combine(incoming!, selectedElement);
                }
              },
              builder: (context, candidate, rejected) {
                return Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient:
                        candidate.isNotEmpty
                            ? LinearGradient(
                              colors: [
                                Colors.green.shade600,
                                Colors.green.shade400,
                              ],
                            )
                            : null,
                    color: candidate.isEmpty ? const Color(0xFF1C1F3E) : null,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color:
                          candidate.isNotEmpty
                              ? Colors.greenAccent
                              : Colors.white38,
                      width: 2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      candidate.isNotEmpty
                          ? "🧪 Release to Open Fusion Menu"
                          : "🔬 Drag Base Element Here\nto Fuse with Discoveries",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _draggableTile(String element) {
    return LongPressDraggable<String>(
      data: element,
      feedback: Material(
        color: Colors.transparent,
        child: _tile(element, isDragging: true, size: 80.0),
      ),
      childWhenDragging: Opacity(
        opacity: 0.35,
        child: _tile(element, size: 80.0),
      ),
      child: DragTarget<String>(
        onWillAccept:
            (incoming) =>
                incoming != element && baseElements.contains(incoming),
        onAccept: (incoming) => _combine(element, incoming!),
        builder:
            (context, candidate, rejected) =>
                _tile(element, isHighlighted: candidate.isNotEmpty, size: 80.0),
      ),
    );
  }

  Widget _buildTargetDisplay() {
    if (isStageComplete && currentLevel < levelData.length) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text(
              "✅ Level Complete! Amazing work!",
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _advanceLevel,
              icon: const Icon(Icons.arrow_forward_ios),
              label: Text("Continue to Level ${currentLevel + 1}"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (currentLevel == levelData.length && isStageComplete) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text(
              "🏆 ALL LEVELS COMPLETE!",
              style: TextStyle(
                color: Colors.amber,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _completeGame,
              child: Text("Finish & Save Score"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1F3E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amberAccent, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "🎯 Target: ",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          _elementIcon(targetElement!, size: 28),
          const SizedBox(width: 8),
          Text(
            targetElement!,
            style: const TextStyle(
              color: Colors.amberAccent,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tile(
    String text, {
    bool isDragging = false,
    bool isHighlighted = false,
    double size = 80.0,
  }) {
    final elementProps =
        scienceVisuals[text] ??
        {"color": Colors.grey, "icon": Icons.help_outline, "emoji": "❓"};
    final Color elementColor = elementProps['color'];
    final String emoji = elementProps['emoji'];
    final double fontSize = size * 0.14;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: size,
      width: size,
      decoration: BoxDecoration(
        color:
            isHighlighted ? Colors.purpleAccent : elementColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDragging ? Colors.orangeAccent : Colors.white24,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: elementColor.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: TextStyle(fontSize: size * 0.35)),
          const SizedBox(height: 4),
          Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _elementIcon(String element, {double size = 40}) {
    final elementProps = scienceVisuals[element] ?? {"emoji": "❓"};
    return Text(elementProps['emoji'], style: TextStyle(fontSize: size));
  }
}

// ============================================================================
// GAME-SPECIFIC LEADERBOARD
// ============================================================================

class ScienceFusionLeaderboard extends StatefulWidget {
  final String username;
  const ScienceFusionLeaderboard({required this.username});

  @override
  State<ScienceFusionLeaderboard> createState() =>
      _ScienceFusionLeaderboardState();
}

class _ScienceFusionLeaderboardState extends State<ScienceFusionLeaderboard> {
  String selectedGame = "photosynthesis";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D102C), Color(0xFF2A1B4A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "🏆 Science Fusion Rankings",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Top Scientists",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 48),
                  ],
                ),
              ),

              // Game Selector
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap:
                            () =>
                                setState(() => selectedGame = "photosynthesis"),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color:
                                selectedGame == "photosynthesis"
                                    ? Colors.green
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Text(
                            "🌿 Photosynthesis",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap:
                            () =>
                                setState(() => selectedGame = "matter_changes"),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color:
                                selectedGame == "matter_changes"
                                    ? Colors.blue
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Text(
                            "🧊 Matter Changes",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Leaderboard
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: UniversalLeaderboardService.getGameLeaderboard(
                    gameId: selectedGame,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.amber),
                      );
                    }

                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return _buildEmptyState();
                    }

                    return _buildLeaderboardList(snapshot.data!);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboardList(List<Map<String, dynamic>> leaderboard) {
    Color themeColor =
        selectedGame == "photosynthesis" ? Colors.green : Colors.blue;

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: leaderboard.length,
      itemBuilder: (context, index) {
        var score = leaderboard[index];
        bool isCurrentUser = score['username'] == widget.username;
        String medal =
            index == 0
                ? "🥇"
                : index == 1
                ? "🥈"
                : index == 2
                ? "🥉"
                : "";

        return Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient:
                isCurrentUser
                    ? LinearGradient(
                      colors: [
                        themeColor.withOpacity(0.3),
                        themeColor.withOpacity(0.15),
                      ],
                    )
                    : null,
            color: isCurrentUser ? null : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isCurrentUser ? themeColor : Colors.white24,
              width: isCurrentUser ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                child: Text(
                  medal.isEmpty ? "#${index + 1}" : medal,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: medal.isEmpty ? 18 : 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          score['username'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isCurrentUser) ...[
                          SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: themeColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "YOU",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Discoveries: ${score['metadata']?['discoveredElements'] ?? 'N/A'}",
                      style: TextStyle(color: Colors.white60, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${score['points']}",
                    style: TextStyle(
                      color: themeColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "points",
                    style: TextStyle(color: Colors.white60, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("📊", style: TextStyle(fontSize: 60)),
          SizedBox(height: 20),
          Text(
            "No scores yet!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Be the first to play!",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// MOCK UNIVERSAL LEADERBOARD SERVICE (Replace with actual import)
// ============================================================================

class UniversalLeaderboardService {
  static Future<void> saveScore({
    required String username,
    required String gameId,
    required String category,
    required int score,
    required int maxScore,
    Map<String, dynamic>? metadata,
  }) async {
    // This will be replaced by the actual UniversalLeaderboardService
    print("Score saved: $username - $gameId - $score/$maxScore");
  }

  static Future<List<Map<String, dynamic>>> getGameLeaderboard({
    String? gameId,
    String? category,
    int? limit,
  }) async {
    // Mock data - replace with actual service
    return [];
  }
}
