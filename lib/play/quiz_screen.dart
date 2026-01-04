import 'package:flutter/material.dart';
// ✅ ADD THIS - Import leaderboard
import 'package:elearningapp_flutter/leaderboard/leaderboard.dart';

// Main Quiz Screen - Topic Selection
class QuizScreen extends StatefulWidget {
  final String role;
  final String username; // ✅ ADD THIS

  const QuizScreen({
    Key? key,
    required this.role,
    required this.username, // ✅ ADD THIS
  }) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String? selectedTopic;

  final Map<String, Map<String, dynamic>> topics = {
    "Changes of Matter": {
      "icon": "🧪",
      "color": Color(0xFFFF6B9D),
      "questions": [
        {
          "question": "What happens when ice melts into water?",
          "options": [
            "Chemical change",
            "Physical change",
            "No change",
            "Nuclear change",
          ],
          "answer": "Physical change",
        },
        {
          "question": "Which is an example of a chemical change?",
          "options": [
            "Boiling water",
            "Cutting paper",
            "Burning wood",
            "Melting chocolate",
          ],
          "answer": "Burning wood",
        },
        {
          "question": "What are the three states of matter?",
          "options": [
            "Hot, cold, warm",
            "Solid, liquid, gas",
            "Big, small, tiny",
            "Fast, slow, still",
          ],
          "answer": "Solid, liquid, gas",
        },
        {
          "question":
              "When water vapor becomes water droplets, this is called?",
          "options": ["Evaporation", "Condensation", "Freezing", "Melting"],
          "answer": "Condensation",
        },
        {
          "question": "What happens to matter when it's heated?",
          "options": [
            "It shrinks",
            "Particles move faster",
            "It disappears",
            "Nothing happens",
          ],
          "answer": "Particles move faster",
        },
      ],
    },
    "Photosynthesis": {
      "icon": "🌱",
      "color": Color(0xFF4CAF50),
      "questions": [
        {
          "question": "What do plants need for photosynthesis?",
          "options": [
            "Sunlight, water, CO2",
            "Only water",
            "Only sunlight",
            "Soil and air",
          ],
          "answer": "Sunlight, water, CO2",
        },
        {
          "question": "What gas do plants release during photosynthesis?",
          "options": ["Carbon dioxide", "Nitrogen", "Oxygen", "Hydrogen"],
          "answer": "Oxygen",
        },
        {
          "question": "What gives plants their green color?",
          "options": ["Water", "Chlorophyll", "Sunlight", "Roots"],
          "answer": "Chlorophyll",
        },
        {
          "question": "Where does photosynthesis mainly occur in plants?",
          "options": ["Roots", "Stem", "Leaves", "Flowers"],
          "answer": "Leaves",
        },
        {
          "question":
              "What is the main product plants make during photosynthesis?",
          "options": ["Water", "Oxygen", "Glucose (sugar)", "Carbon dioxide"],
          "answer": "Glucose (sugar)",
        },
      ],
    },
    "Solar System": {
      "icon": "🌍",
      "color": Color(0xFF2196F3),
      "questions": [
        {
          "question": "Which planet is closest to the Sun?",
          "options": ["Venus", "Earth", "Mercury", "Mars"],
          "answer": "Mercury",
        },
        {
          "question": "Which planet is known as the Red Planet?",
          "options": ["Mars", "Venus", "Jupiter", "Saturn"],
          "answer": "Mars",
        },
        {
          "question": "What is the largest planet in our solar system?",
          "options": ["Saturn", "Neptune", "Jupiter", "Earth"],
          "answer": "Jupiter",
        },
        {
          "question": "How many planets are in our solar system?",
          "options": ["7", "8", "9", "10"],
          "answer": "8",
        },
        {
          "question": "What do we call a natural satellite orbiting Earth?",
          "options": ["The Sun", "The Moon", "A star", "An asteroid"],
          "answer": "The Moon",
        },
      ],
    },
    "Ecosystem & Food Web": {
      "icon": "🦁",
      "color": Color(0xFFFF9800),
      "questions": [
        {
          "question": "What are organisms that make their own food called?",
          "options": ["Consumers", "Producers", "Decomposers", "Predators"],
          "answer": "Producers",
        },
        {
          "question": "Which organism breaks down dead plants and animals?",
          "options": ["Producers", "Herbivores", "Decomposers", "Carnivores"],
          "answer": "Decomposers",
        },
        {
          "question": "A rabbit eating grass is an example of a?",
          "options": ["Carnivore", "Herbivore", "Omnivore", "Decomposer"],
          "answer": "Herbivore",
        },
        {
          "question": "What is a food chain?",
          "options": [
            "A restaurant menu",
            "Path of energy through organisms",
            "A type of plant",
            "A cooking method",
          ],
          "answer": "Path of energy through organisms",
        },
        {
          "question": "Where does all energy in a food web start?",
          "options": ["Animals", "The Sun", "Soil", "Water"],
          "answer": "The Sun",
        },
      ],
    },
    "Water Cycle": {
      "icon": "💧",
      "color": Color(0xFF00BCD4),
      "questions": [
        {
          "question": "What is it called when water turns into vapor?",
          "options": [
            "Condensation",
            "Precipitation",
            "Evaporation",
            "Collection",
          ],
          "answer": "Evaporation",
        },
        {
          "question": "What is rain, snow, sleet, and hail called?",
          "options": [
            "Evaporation",
            "Condensation",
            "Precipitation",
            "Collection",
          ],
          "answer": "Precipitation",
        },
        {
          "question": "Where does most evaporation occur?",
          "options": ["Mountains", "Oceans", "Forests", "Cities"],
          "answer": "Oceans",
        },
        {
          "question": "What are clouds made of?",
          "options": ["Cotton", "Water droplets", "Air", "Dust"],
          "answer": "Water droplets",
        },
        {
          "question": "What powers the water cycle?",
          "options": ["Wind", "The Sun", "Gravity", "Plants"],
          "answer": "The Sun",
        },
      ],
    },
  };

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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Header with Owl and Leaderboard Button
                Row(
                  children: [
                    Text("🦉", style: TextStyle(fontSize: 50)),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Grade 6 Science Quiz",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Choose your adventure!",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ✅ NEW - Leaderboard Button
                    IconButton(
                      icon: Icon(
                        Icons.emoji_events,
                        color: Colors.amber,
                        size: 32,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => UniversalGameLeaderboardScreen(
                                  username: widget.username,
                                  gameId: UniversalLeaderboardService.GAME_QUIZ,
                                  gameTitle: "Science Quiz",
                                  gameIcon: "🧪",
                                  categories: ["All", ...topics.keys.toList()],
                                  primaryColor: Colors.deepPurpleAccent,
                                  secondaryColor: Colors.purpleAccent,
                                ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),

                // Topic Cards
                Expanded(
                  child: ListView(
                    children:
                        topics.entries.map((entry) {
                          return TopicCard(
                            title: entry.key,
                            icon: entry.value["icon"],
                            color: entry.value["color"],
                            questionCount: entry.value["questions"].length,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => QuizPlayScreen(
                                        topic: entry.key,
                                        questions: entry.value["questions"],
                                        color: entry.value["color"],
                                        role: widget.role,
                                        username: widget.username, // ✅ ADD THIS
                                      ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Topic Card Widget (unchanged)
class TopicCard extends StatelessWidget {
  final String title;
  final String icon;
  final Color color;
  final int questionCount;
  final VoidCallback onTap;

  const TopicCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.questionCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
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
              border: Border.all(color: color.withOpacity(0.5), width: 2),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(icon, style: TextStyle(fontSize: 35)),
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
                        "$questionCount Questions",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.white70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Quiz Play Screen
class QuizPlayScreen extends StatefulWidget {
  final String topic;
  final List<Map<String, dynamic>> questions;
  final Color color;
  final String role;
  final String username; // ✅ ADD THIS

  const QuizPlayScreen({
    required this.topic,
    required this.questions,
    required this.color,
    required this.role,
    required this.username, // ✅ ADD THIS
  });

  @override
  State<QuizPlayScreen> createState() => _QuizPlayScreenState();
}

class _QuizPlayScreenState extends State<QuizPlayScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  String? selectedAnswer;
  bool answerChecked = false;
  List<String> userAnswers = [];

  void selectAnswer(String answer) {
    if (!answerChecked) {
      setState(() {
        selectedAnswer = answer;
      });
    }
  }

  void checkAnswer() {
    if (selectedAnswer == null) return;

    setState(() {
      answerChecked = true;
      userAnswers.add(selectedAnswer!);
      if (selectedAnswer == widget.questions[currentQuestionIndex]["answer"]) {
        score++;
      }
    });

    Future.delayed(Duration(seconds: 2), () {
      if (currentQuestionIndex < widget.questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          selectedAnswer = null;
          answerChecked = false;
        });
      } else {
        _showResultDialog();
      }
    });
  }

  void _showResultDialog() async {
    int percentage = ((score / widget.questions.length) * 100).round();
    String emoji =
        percentage >= 80
            ? "🌟"
            : percentage >= 60
            ? "🎉"
            : "💪";
    String message =
        percentage >= 80
            ? "Amazing work!"
            : percentage >= 60
            ? "Great job!"
            : "Keep practicing!";

    // ✅ SAVE SCORE TO LEADERBOARD
    await UniversalLeaderboardService.saveScore(
      username: widget.username,
      gameId: UniversalLeaderboardService.GAME_QUIZ,
      category: widget.topic,
      score: score,
      maxScore: widget.questions.length,
      metadata: {
        'percentage': percentage,
        'completedAt': DateTime.now().toIso8601String(),
      },
    );

    if (!mounted) return;

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
                Text(emoji, style: TextStyle(fontSize: 60)),
                SizedBox(height: 10),
                Text(
                  "Quiz Complete!",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "$score / ${widget.questions.length}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$percentage% Correct",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      // ✅ NEW - Score saved indicator
                      Text(
                        "✅ Score saved to leaderboard!",
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
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
                  "Back to Topics",
                  style: TextStyle(color: widget.color, fontSize: 16),
                ),
              ),
              // ✅ NEW - View Leaderboard Button
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => UniversalGameLeaderboardScreen(
                            username: widget.username,
                            gameId: UniversalLeaderboardService.GAME_QUIZ,
                            gameTitle: "Science Quiz",
                            gameIcon: "🧪",
                            categories: ["All", widget.topic],
                            primaryColor: Colors.deepPurpleAccent,
                            secondaryColor: Colors.purpleAccent,
                          ),
                    ),
                  );
                },
                child: Text(
                  "View Leaderboard",
                  style: TextStyle(color: Colors.amber, fontSize: 16),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    currentQuestionIndex = 0;
                    score = 0;
                    selectedAnswer = null;
                    answerChecked = false;
                    userAnswers.clear();
                  });
                },
                child: Text("Try Again", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var question = widget.questions[currentQuestionIndex];
    String correctAnswer = question["answer"];

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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Text(
                        widget.topic,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: widget.color.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Score: $score",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Progress
                Column(
                  children: [
                    LinearProgressIndicator(
                      value:
                          (currentQuestionIndex + 1) / widget.questions.length,
                      backgroundColor: Colors.white24,
                      color: widget.color,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Question ${currentQuestionIndex + 1} of ${widget.questions.length}",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                // Question Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Color(0xFF1C1F3E),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: widget.color.withOpacity(0.3),
                        blurRadius: 15,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Text(
                    question["question"],
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),

                // Options
                Expanded(
                  child: ListView(
                    children:
                        question["options"].map<Widget>((opt) {
                          bool isSelected = selectedAnswer == opt;
                          bool isCorrect = opt == correctAnswer;
                          bool showCorrect = answerChecked && isCorrect;
                          bool showWrong =
                              answerChecked && isSelected && !isCorrect;

                          return Container(
                            margin: EdgeInsets.only(bottom: 12),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => selectAnswer(opt),
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  padding: EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    color:
                                        showCorrect
                                            ? Colors.green.withOpacity(0.3)
                                            : showWrong
                                            ? Colors.red.withOpacity(0.3)
                                            : isSelected
                                            ? widget.color.withOpacity(0.3)
                                            : Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color:
                                          showCorrect
                                              ? Colors.green
                                              : showWrong
                                              ? Colors.red
                                              : isSelected
                                              ? widget.color
                                              : Colors.white24,
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          opt,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      if (showCorrect)
                                        Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        ),
                                      if (showWrong)
                                        Icon(Icons.cancel, color: Colors.red),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),

                // Submit Button
                if (!answerChecked)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.color,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                      ),
                      onPressed: selectedAnswer != null ? checkAnswer : null,
                      child: Text(
                        "Check Answer",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
