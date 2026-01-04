import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// ============================================================================
// UNIVERSAL LEADERBOARD SERVICE - Use this across all games
// ============================================================================

class UniversalLeaderboardService {
  static const String _allScoresKey = 'universal_all_scores';
  static const String _userStatsKey = 'universal_user_stats';

  // Game identifiers
  static const String GAME_QUIZ = 'quiz';
  static const String GAME_MEMORY = 'memory';
  static const String GAME_PUZZLE = 'puzzle';
  // Add more game IDs as needed

<<<<<<< HEAD
  /// Get display name for a username (falls back to username if not set)
  static Future<String> getDisplayName(String username) async {
    final prefs = await SharedPreferences.getInstance();
    String? displayName = prefs.getString("display_name_$username");
    return displayName ?? username;
  }

=======
>>>>>>> 800672d880d0dff424fb1136ac60193caeb661d9
  /// Save a game score
  /// @param username - Player's username
  /// @param gameId - Unique game identifier (e.g., 'quiz', 'memory', 'puzzle')
  /// @param category - Category within the game (e.g., 'Photosynthesis', 'Level 1')
  /// @param score - Score achieved
  /// @param maxScore - Maximum possible score
  /// @param metadata - Additional game-specific data (optional)
  static Future<void> saveScore({
    required String username,
    required String gameId,
    required String category,
    required int score,
    required int maxScore,
    Map<String, dynamic>? metadata,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // Get existing scores
    List<Map<String, dynamic>> allScores = await _getAllScores();

<<<<<<< HEAD
    // Get display name
    String displayName = await getDisplayName(username);

=======
>>>>>>> 800672d880d0dff424fb1136ac60193caeb661d9
    // Calculate points (0-100 scale for consistency)
    int points = ((score / maxScore) * 100).round();
    int percentage = points;

    // Create score entry
    Map<String, dynamic> scoreEntry = {
      'username': username,
<<<<<<< HEAD
      'displayName': displayName, // Store display name for leaderboard
=======
>>>>>>> 800672d880d0dff424fb1136ac60193caeb661d9
      'gameId': gameId,
      'category': category,
      'score': score,
      'maxScore': maxScore,
      'points': points,
      'percentage': percentage,
      'timestamp': DateTime.now().toIso8601String(),
      'metadata': metadata ?? {},
    };

    // Add to all scores
    allScores.add(scoreEntry);

    // Save to storage
    await prefs.setString(_allScoresKey, jsonEncode(allScores));

    // Update user statistics
    await _updateUserStats(username);
  }

  /// Get all scores (internal use)
  static Future<List<Map<String, dynamic>>> _getAllScores() async {
    final prefs = await SharedPreferences.getInstance();
    String? scoresJson = prefs.getString(_allScoresKey);

    if (scoresJson == null) return [];

    List<dynamic> scoresList = jsonDecode(scoresJson);
    return scoresList.cast<Map<String, dynamic>>();
  }

  /// Get leaderboard for a specific game
  /// @param gameId - Game identifier (null for overall leaderboard)
  /// @param category - Category filter (null for all categories)
  /// @param limit - Maximum number of entries to return (null for all)
  static Future<List<Map<String, dynamic>>> getGameLeaderboard({
    String? gameId,
    String? category,
    int? limit,
  }) async {
    List<Map<String, dynamic>> allScores = await _getAllScores();

    // Filter by game
    if (gameId != null) {
      allScores = allScores.where((s) => s['gameId'] == gameId).toList();
    }

    // Filter by category
    if (category != null) {
      allScores = allScores.where((s) => s['category'] == category).toList();
    }

<<<<<<< HEAD
    // Update display names to ensure they're current
    for (var score in allScores) {
      String username = score['username'] as String;
      // Always get the latest display name (user might have changed it)
      score['displayName'] = await getDisplayName(username);
    }

=======
>>>>>>> 800672d880d0dff424fb1136ac60193caeb661d9
    // Sort by percentage (descending), then by timestamp (most recent first)
    allScores.sort((a, b) {
      int percentageCompare = b['percentage'].compareTo(a['percentage']);
      if (percentageCompare != 0) return percentageCompare;
      return DateTime.parse(
        b['timestamp'],
      ).compareTo(DateTime.parse(a['timestamp']));
    });

    // Apply limit if specified
    if (limit != null && allScores.length > limit) {
      allScores = allScores.sublist(0, limit);
    }

    return allScores;
  }

  /// Get overall leaderboard (all games combined, ranked by total points)
  static Future<List<Map<String, dynamic>>> getOverallLeaderboard() async {
    final prefs = await SharedPreferences.getInstance();
<<<<<<< HEAD
    
    // Get all scores to find all unique players
    List<Map<String, dynamic>> allScores = await _getAllScores();
    
    // Get stats if they exist
    String? statsJson = prefs.getString(_userStatsKey);
    Map<String, dynamic> allStats = {};
    if (statsJson != null) {
      allStats = jsonDecode(statsJson);
    }
    
    // Build a map of all unique usernames from scores
    Map<String, Map<String, dynamic>> playerStats = {};
    
    // First, add existing stats
    for (var entry in allStats.entries) {
      String username = entry.key;
      playerStats[username] = Map<String, dynamic>.from(entry.value);
    }
    
    // Then, ensure all players with scores are included
    for (var score in allScores) {
      String username = score['username'] as String;
      
      if (!playerStats.containsKey(username)) {
        // Initialize stats for this player
        playerStats[username] = {
          'username': username,
          'totalGames': 0,
          'totalPoints': 0,
          'averagePercentage': 0,
          'gameStats': {},
        };
      }
      
      // Calculate stats from scores
      Map<String, dynamic> stats = playerStats[username]!;
      
      // Count games and calculate points
      int gameCount = allScores.where((s) => s['username'] == username).length;
      int totalPoints = allScores
          .where((s) => s['username'] == username)
          .fold(0, (sum, s) => sum + (s['points'] as int? ?? 0));
      double avgPercentage = gameCount > 0 ? (totalPoints / gameCount).round().toDouble() : 0.0;
      
      stats['totalGames'] = gameCount;
      stats['totalPoints'] = totalPoints;
      stats['averagePercentage'] = avgPercentage.round();
    }
    
    // Build leaderboard list with display names
    List<Map<String, dynamic>> leaderboard = [];
    for (var entry in playerStats.entries) {
      String username = entry.key;
      Map<String, dynamic> stats = Map<String, dynamic>.from(entry.value);
      
      // Always get the latest display name
      stats['displayName'] = await getDisplayName(username);
      
      leaderboard.add(stats);
    }
=======
    String? statsJson = prefs.getString(_userStatsKey);

    if (statsJson == null) return [];

    Map<String, dynamic> allStats = jsonDecode(statsJson);
    List<Map<String, dynamic>> leaderboard = [];

    allStats.forEach((username, stats) {
      leaderboard.add(Map<String, dynamic>.from(stats));
    });
>>>>>>> 800672d880d0dff424fb1136ac60193caeb661d9

    // Sort by total points (descending)
    leaderboard.sort((a, b) => b['totalPoints'].compareTo(a['totalPoints']));

    return leaderboard;
  }

  /// Get user statistics
  static Future<Map<String, dynamic>?> getUserStats(String username) async {
    final prefs = await SharedPreferences.getInstance();
    String? statsJson = prefs.getString(_userStatsKey);

    if (statsJson == null) return null;

    Map<String, dynamic> allStats = jsonDecode(statsJson);
    return allStats[username];
  }

  /// Get user's rank in overall leaderboard
  static Future<int> getUserOverallRank(String username) async {
    List<Map<String, dynamic>> leaderboard = await getOverallLeaderboard();

    for (int i = 0; i < leaderboard.length; i++) {
      if (leaderboard[i]['username'] == username) {
        return i + 1;
      }
    }

    return -1;
  }

  /// Get user's rank in a specific game
  static Future<int> getUserGameRank(
    String username,
    String gameId, {
    String? category,
  }) async {
    List<Map<String, dynamic>> leaderboard = await getGameLeaderboard(
      gameId: gameId,
      category: category,
    );

    // Find user's best score
    var userScores =
        leaderboard.where((s) => s['username'] == username).toList();
    if (userScores.isEmpty) return -1;

    return leaderboard.indexOf(userScores.first) + 1;
  }

  /// Get user's game history
  static Future<List<Map<String, dynamic>>> getUserHistory(
    String username, {
    String? gameId,
  }) async {
    List<Map<String, dynamic>> allScores = await _getAllScores();

    // Filter by username
    List<Map<String, dynamic>> userScores =
        allScores.where((s) => s['username'] == username).toList();

    // Filter by game if specified
    if (gameId != null) {
      userScores = userScores.where((s) => s['gameId'] == gameId).toList();
    }

    // Sort by timestamp (most recent first)
    userScores.sort(
      (a, b) => DateTime.parse(
        b['timestamp'],
      ).compareTo(DateTime.parse(a['timestamp'])),
    );

    return userScores;
  }

  /// Update user statistics (internal)
  static Future<void> _updateUserStats(String username) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> allScores = await _getAllScores();

    // Filter user's scores
    List<Map<String, dynamic>> userScores =
        allScores.where((s) => s['username'] == username).toList();

    if (userScores.isEmpty) return;

<<<<<<< HEAD
    // Get display name
    String displayName = await getDisplayName(username);

=======
>>>>>>> 800672d880d0dff424fb1136ac60193caeb661d9
    // Calculate overall statistics
    int totalGames = userScores.length;
    int totalPoints = userScores.fold(
      0,
      (sum, score) => sum + (score['points'] as int),
    );
    double averagePercentage =
        userScores.fold(
          0.0,
          (sum, score) => sum + (score['percentage'] as int),
        ) /
        totalGames;

    // Calculate per-game statistics
    Map<String, Map<String, dynamic>> gameStats = {};
    for (var score in userScores) {
      String gameId = score['gameId'];
      if (!gameStats.containsKey(gameId)) {
        gameStats[gameId] = {
          'gameId': gameId,
          'gamesPlayed': 0,
          'totalPoints': 0,
          'averagePercentage': 0.0,
          'bestScore': 0,
        };
      }

      gameStats[gameId]!['gamesPlayed'] =
          (gameStats[gameId]!['gamesPlayed'] as int) + 1;
      gameStats[gameId]!['totalPoints'] =
          (gameStats[gameId]!['totalPoints'] as int) + (score['points'] as int);

      if (score['percentage'] > gameStats[gameId]!['bestScore']) {
        gameStats[gameId]!['bestScore'] = score['percentage'];
      }
    }

    // Calculate average percentages for each game
    gameStats.forEach((gameId, stats) {
      stats['averagePercentage'] =
          (stats['totalPoints'] / stats['gamesPlayed']).round();
    });

    // Save user stats
    Map<String, dynamic> stats = {
      'username': username,
<<<<<<< HEAD
      'displayName': displayName,
=======
>>>>>>> 800672d880d0dff424fb1136ac60193caeb661d9
      'totalGames': totalGames,
      'totalPoints': totalPoints,
      'averagePercentage': averagePercentage.round(),
      'gameStats': gameStats,
      'lastUpdated': DateTime.now().toIso8601String(),
    };

    // Get all user stats
    String? statsJson = prefs.getString(_userStatsKey);
    Map<String, dynamic> allStats = {};
    if (statsJson != null) {
      allStats = Map<String, dynamic>.from(jsonDecode(statsJson));
    }

    allStats[username] = stats;
    await prefs.setString(_userStatsKey, jsonEncode(allStats));
  }

  /// Get list of all games the user has played
  static Future<List<String>> getUserGames(String username) async {
    List<Map<String, dynamic>> userScores = await getUserHistory(username);
    Set<String> games = userScores.map((s) => s['gameId'] as String).toSet();
    return games.toList();
  }

  /// Clear all data (for testing/reset)
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_allScoresKey);
    await prefs.remove(_userStatsKey);
  }
}

// ============================================================================
// REUSABLE LEADERBOARD UI COMPONENTS
// ============================================================================

/// Reusable Overall Leaderboard Screen
class UniversalOverallLeaderboardScreen extends StatelessWidget {
  final String username;
  final String title;
  final Color primaryColor;
  final Color secondaryColor;

  const UniversalOverallLeaderboardScreen({
    required this.username,
    this.title = "🏆 Overall Leaderboard",
    this.primaryColor = Colors.amber,
    this.secondaryColor = Colors.orange,
  });

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
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 48),
                  ],
                ),
              ),

              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "All Games Combined",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),

              SizedBox(height: 20),

              // Leaderboard
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: UniversalLeaderboardService.getOverallLeaderboard(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(color: primaryColor),
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
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: leaderboard.length,
      itemBuilder: (context, index) {
        var user = leaderboard[index];
        bool isCurrentUser = user['username'] == username;
<<<<<<< HEAD
        String displayName = user['displayName'] ?? user['username'] ?? 'Unknown';
=======
>>>>>>> 800672d880d0dff424fb1136ac60193caeb661d9
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
                        primaryColor.withOpacity(0.3),
                        secondaryColor.withOpacity(0.2),
                      ],
                    )
                    : null,
            color: isCurrentUser ? null : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isCurrentUser ? primaryColor : Colors.white24,
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
<<<<<<< HEAD
                          displayName,
=======
                          user['username'],
>>>>>>> 800672d880d0dff424fb1136ac60193caeb661d9
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
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "YOU",
                              style: TextStyle(
                                color: Colors.black,
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
                      "${user['totalGames']} games • ${user['averagePercentage']}% avg",
                      style: TextStyle(color: Colors.white60, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${user['totalPoints']}",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 28,
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
            "Play some games to see rankings!",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

/// Reusable Game-Specific Leaderboard Screen
class UniversalGameLeaderboardScreen extends StatefulWidget {
  final String username;
  final String gameId;
  final String gameTitle;
  final List<String> categories;
  final Color primaryColor;
  final Color secondaryColor;
  final String? gameIcon;

  const UniversalGameLeaderboardScreen({
    required this.username,
    required this.gameId,
    required this.gameTitle,
    required this.categories,
    this.primaryColor = Colors.deepPurpleAccent,
    this.secondaryColor = Colors.purpleAccent,
    this.gameIcon,
  });

  @override
  State<UniversalGameLeaderboardScreen> createState() =>
      _UniversalGameLeaderboardScreenState();
}

class _UniversalGameLeaderboardScreenState
    extends State<UniversalGameLeaderboardScreen> {
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.categories.first;
  }

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
                            "${widget.gameIcon ?? '🎮'} ${widget.gameTitle}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Leaderboard",
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

              // Category Filter
              if (widget.categories.length > 1)
                Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.categories.length,
                    itemBuilder: (context, index) {
                      bool isSelected =
                          selectedCategory == widget.categories[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = widget.categories[index];
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? widget.primaryColor
                                    : Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? widget.primaryColor
                                      : Colors.white24,
                            ),
                          ),
                          child: Text(
                            widget.categories[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

              SizedBox(height: 20),

              // Leaderboard
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: UniversalLeaderboardService.getGameLeaderboard(
                    gameId: widget.gameId,
                    category:
                        selectedCategory == "All" ? null : selectedCategory,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: widget.primaryColor,
                        ),
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
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: leaderboard.length,
      itemBuilder: (context, index) {
        var score = leaderboard[index];
        bool isCurrentUser = score['username'] == widget.username;
<<<<<<< HEAD
        String displayName = score['displayName'] ?? score['username'] ?? 'Unknown';
=======
>>>>>>> 800672d880d0dff424fb1136ac60193caeb661d9
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
                        widget.primaryColor.withOpacity(0.3),
                        widget.secondaryColor.withOpacity(0.2),
                      ],
                    )
                    : null,
            color: isCurrentUser ? null : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isCurrentUser ? widget.primaryColor : Colors.white24,
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
<<<<<<< HEAD
                          displayName,
=======
                          score['username'],
>>>>>>> 800672d880d0dff424fb1136ac60193caeb661d9
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
                              color: widget.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "YOU",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (selectedCategory == "All")
                      Text(
                        score['category'],
                        style: TextStyle(color: Colors.white60, fontSize: 14),
                      ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${score['percentage']}%",
                    style: TextStyle(
                      color: widget.primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${score['score']}/${score['maxScore']}",
                    style: TextStyle(color: Colors.white60, fontSize: 14),
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
// GAME IDS - Add your game identifiers here
// ============================================================================

// Usage in your games:
// - Quiz: UniversalLeaderboardService.GAME_QUIZ
// - Science Fusion Photosynthesis: 'photosynthesis'
// - Science Fusion Matter Changes: 'matter_changes'
// - Add more as you create new games
