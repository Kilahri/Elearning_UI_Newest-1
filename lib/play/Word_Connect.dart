import 'package:flutter/material.dart';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


// --- Data Models (UNCHANGED) ---
class Word {
  final String text;
  final String hint;
  bool isFound;

  Word({required this.text, required this.hint, this.isFound = false});
}

class GameLevel {
  final String category;
  final List<String> letters; // Unique letters for this specific level
  final List<Word> words;

  GameLevel({required this.category, required List<String> letters, required this.words})
      // Ensure letters are shuffled for the game board
      : letters = letters.toList()..shuffle(Random());
}

// --- Game Data (20 Levels: MATATAG Curriculum Science Grade 4-6) (REVISED DIFFICULTY) ---
class GameData {
  static final List<GameLevel> allLevels = [
    // Level 1: (EASIEST START: 4 LETTERS) - Body Systems (G4)
    GameLevel(
      category: "Human Body: Sight",
      letters: ["E", "Y", "E", "S"],
      words: [
        Word(text: "EYES", hint: "The organs used for seeing. 👀"),
        Word(text: "YES", hint: "An affirmative answer."),
        Word(text: "SE", hint: "Short for Southeast (puzzle filler)."),
      ],
    ),
    // Level 2: (EASY: 5 LETTERS) - Matter/States (G4)
    GameLevel(
      category: "States of Matter",
      letters: ["G", "A", "S", "E", "S"],
      words: [
        Word(text: "GAS", hint: "A state of matter (like air). 💨"),
        Word(text: "SEAS", hint: "Large bodies of saltwater."),
        Word(text: "AGE", hint: "The length of time a person has lived."),
      
      ],
    ),
    // Level 3: (EASY: 5-6 LETTERS) - Earth/Resources (G5)
    GameLevel(
      category: "Earth: Layers",
      letters: ["C", "R", "U", "S", "T"],
      words: [
        Word(text: "CRUST", hint: "The outermost solid layer of the Earth. 🌍"),
        Word(text: "RUT", hint: "A long deep track made by a wheel."),
        Word(text: "CUT", hint: "To divide or penetrate with a sharp instrument."),
        Word(text: "TUR", hint: "A wild goat (puzzle filler)."),
      ],
    ),
    // Level 4: Force and Motion (G4/5)
    GameLevel(
      category: "Force and Motion",
      letters: ["P", "U", "S", "H", "L", "L"],
      words: [
        Word(text: "PULL", hint: "To exert force on an object to move it toward oneself. ➡️"),
        Word(text: "PUSH", hint: "To exert force on an object to move it away."),
        Word(text: "LUSH", hint: "Growing thickly and healthily."),
        
      ],
    ),
    // Level 5: Light/Energy (G4)
    GameLevel(
      category: "Forms of Energy",
      letters: ["L", "I", "G", "H", "T", "E", "R"],
      words: [
        Word(text: "LIGHT", hint: "The form of energy that makes things visible. 💡"),
        Word(text: "RITE", hint: "A religious or solemn ceremony."),
        Word(text: "HER", hint: "A female pronoun."),
        Word(text: "LET", hint: "To allow."),
      ],
    ),
    // Level 6: Mixtures/Solute (G5/6 - original Level 1 concept)
    GameLevel(
      category: "Matter: Solution",
      letters: ["S", "O", "L", "U", "T", "E"],
      words: [
        Word(text: "SOLUTE", hint: "The substance that dissolves in a solvent to form a solution. 🧪"),
        Word(text: "SOUL", hint: "The spiritual or immaterial part of a human being."),
        Word(text: "LOT", hint: "A large number or amount."),
        Word(text: "SET", hint: "To put or place."),
      ],
    ),
    // Level 7: Changes in Materials (G5)
    GameLevel(
      category: "Change: Chemical",
      letters: ["R", "U", "S", "T", "I", "N", "G"],
      words: [
        Word(text: "RUST", hint: "The reddish-brown flaky coating that forms on iron when exposed to oxygen. 🔴"),
        Word(text: "TIN", hint: "A silvery-white metal element."),
        Word(text: "GUN", hint: "A weapon (puzzle filler)."),
        Word(text: "SING", hint: "To make musical sounds with the voice."),
      ],
    ),
    // Level 8: Ecosystems (G6)
    GameLevel(
      category: "Food Chain",
      letters: ["P", "R", "O", "D", "U", "C", "E", "R"],
      words: [
        Word(text: "PRODUCER", hint: "Organisms, mostly plants, that make their own food. 🌾"),
        Word(text: "CROP", hint: "A cultivated plant, especially a grain, fruit, or vegetable."),
        Word(text: "PURE", hint: "Not mixed with anything else."),
        Word(text: "RED", hint: "A primary color."),
      ],
    ),
    // Level 9: Simple Machines (G6)
    GameLevel(
      category: "Simple Machines: Wheel",
      letters: ["W", "H", "E", "E", "L", "A", "X", "E"],
      words: [
        
        Word(text: "WHEEL", hint: "A circular frame or disk designed to turn on an axle."),
        Word(text: "HEAL", hint: "To become sound or healthy again."),
        Word(text: "LAW", hint: "Rules established by authority."),
      ],
    ),
    // Level 10: Earth and Space (G5/6) - Harder
    GameLevel(
      category: "Solar System",
      letters: ["P", "L", "A", "N", "E", "T", "S"],
      words: [
        Word(text: "PLANETS", hint: "Large, spherical celestial bodies orbiting a star. 🪐"),
        Word(text: "EAST", hint: "One of the four main directions."),
        Word(text: "NEST", hint: "A bird's home."),
        Word(text: "LANE", hint: "A narrow road or track."),
      ],
    ),
    // Level 11: Simple Machines (G5)
    GameLevel(
      category: "Simple Machines: Ramp",
      letters: ["I", "N", "C", "L", "I", "N", "E", "D"],
      words: [
        Word(text: "INCLINE", hint: "To slope or lean. Describes a simple machine like a ramp. 📐"),
        Word(text: "LEND", hint: "To give something to someone temporarily."),
        Word(text: "LINE", hint: "A long, narrow mark."),
        Word(text: "NICE", hint: "Pleasant; agreeable."),
      ],
    ),
    // Level 12: Weather/Climate (G4/5)
    GameLevel(
      category: "Weather: Water Cycle",
      letters: ["E", "V", "A", "P", "O", "R", "A", "T", "E"],
      words: [
        Word(text: "EVAPORATE", hint: "The process of liquid turning into gas or vapor. 💧"),
        Word(text: "RATE", hint: "A measure, quantity, or frequency."),
        Word(text: "TAP", hint: "A device for controlling the flow of a liquid."),
        Word(text: "AREA", hint: "A region or part of a town, a country, or the world."),
      ],
    ),
    // Level 13: Magnetism (G6)
    GameLevel(
      category: "Magnetism",
      letters: ["M", "A", "G", "N", "E", "T", "I", "C"],
      words: [
        Word(text: "MAGNETIC", hint: "Having the properties of a magnet; attracting iron. 🧲"),
        Word(text: "GATE", hint: "A barrier that swings or slides open and shut."),
        Word(text: "ACE", hint: "A playing card with a single spot."),
        Word(text: "TIN", hint: "A silvery-white metal element."),
      ],
    ),
    // Level 14: Plant Parts (G4)
    GameLevel(
      category: "Plant Food-Making",
      letters: ["P", "H", "O", "T", "O", "S", "Y", "N", "T"],
      words: [
        Word(text: "PHOTO", hint: "Short for photosynthesis, the process plants use to make food. ☀️"),
        Word(text: "HOST", hint: "A person who receives or entertains guests."),
        Word(text: "SON", hint: "A male child."),
        Word(text: "TOY", hint: "An object for a child to play with."),
      ],
    ),
    // Level 15: Earth's Resources (G6)
    GameLevel(
      category: "Natural Resources",
      letters: ["R", "E", "N", "E", "W", "A", "B", "L", "E"],
      words: [
        Word(text: "RENEWABLE", hint: "A resource that can be replaced naturally and quickly (like solar power). ♻️"),
        Word(text: "ABLE", hint: "Having the power or skill to do something."),
        Word(text: "BLUE", hint: "A primary color."),
        Word(text: "EEL", hint: "A snake-like fish."),
      ],
    ),
    // Level 16: Human Senses (G4)
    GameLevel(
      category: "The Senses",
      letters: ["S", "K", "I", "N", "T", "O", "U", "C", "H"],
      words: [
        Word(text: "TOUCH", hint: "One of the five senses, felt by the largest organ of the body. 👋"),
        Word(text: "KIN", hint: "One's family and relations."),
        Word(text: "HUT", hint: "A small, simple house or shelter."),
        Word(text: "CUT", hint: "To divide or penetrate with a sharp instrument."),
      ],
    ),
    // Level 17: Sound (G4/5)
    GameLevel(
      category: "Sound Waves",
      letters: ["F", "R", "E", "Q", "U", "E", "N", "C", "Y"],
      words: [
        Word(text: "QUE", hint: "Short for frequency, how often a sound wave vibrates (puzzle filler). 🔊"),
        Word(text: "RUN", hint: "Move at a speed faster than a walk."),
        Word(text: "FENCE", hint: "A barrier, railing, or other upright structure."),
        Word(text: "NUN", hint: "A member of a religious community of women."),
      ],
    ),
    // Level 18: Adaptation (G6)
    GameLevel(
      category: "Animal Traits",
      letters: ["A", "D", "A", "P", "T", "I", "O", "N"],
      words: [
        Word(text: "ADAPT", hint: "To change or adjust to a new condition or environment. 🦎"),
        Word(text: "PAT", hint: "To touch gently and quickly."),
        Word(text: "NOON", hint: "Twelve o'clock in the day."),
        Word(text: "TIN", hint: "A silvery-white metal element."),
      ],
    ),
    // Level 19: Heat Transfer (G6)
    GameLevel(
      category: "Heat Transfer",
      letters: ["C", "O", "N", "D", "U", "C", "T", "I", "O", "N"],
      words: [
        Word(text: "HEAT", hint: "A form of energy transferred between systems or objects with different temperatures. 🔥"),
        Word(text: "ICON", hint: "A religious painting or picture."),
        Word(text: "COIN", hint: "A small, flat, round piece of metal used as money."),
        Word(text: "UNIT", hint: "An individual thing or person regarded as single and complete."),
      ],
    ),
    // Level 20: Simple Machine (G5/6)
    GameLevel(
      category: "Simple Machines: Screw",
      letters: ["S", "C", "R", "E", "W", "N", "U", "T"],
      words: [
        Word(text: "SCREW", hint: "An inclined plane wrapped around a cylinder; used to fasten things. 🔩"),
        Word(text: "TURN", hint: "Move in a circular direction."),
        Word(text: "CUT", hint: "To divide or penetrate with a sharp instrument."),
        Word(text: "REST", hint: "To take a break."),
      ],
    ),
  ];
}


// ----------------------------------------------------------------------
// --- WIDGETS AND LOGIC (UNCHANGED from previous complete response) ---
// ----------------------------------------------------------------------

class WordConnectScreen extends StatefulWidget {
  final String role; 

  const WordConnectScreen({super.key, required this.role});

  @override
  State<WordConnectScreen> createState() => _WordConnectScreenState();
}

// NOTE: The rest of the game implementation (State class, build method, 
//       UI components, and game logic) is assumed to follow the structure 
//       provided in a complete Flutter word game example, using the 
//       GameData class defined above.

class _WordConnectScreenState extends State<WordConnectScreen> {
  // Tracks current level index across all GameData levels
  int _currentLevelIndex = 0; 

  late GameLevel _currentLevel;
  String _currentDraggedWord = "";
  List<int> _selectedLetterIndices = []; 
  late ConfettiController _confettiController;
  
  // State for current word progression within the current level
  int _currentWordIndex = 0; 
  
  // Drag detection and line drawing states
  GlobalKey _letterWheelKey = GlobalKey(); 
  Size? _letterButtonSize;
  List<Offset> _dragLineOffsets = []; 

  // --- Initialization and Cleanup ---

  @override
  void initState() {
    super.initState();
    // Confetti duration increased slightly to allow time for the dialog/auto-advance
    _confettiController = ConfettiController(duration: const Duration(seconds: 4)); 
    _loadLevel(_currentLevelIndex);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  // UPDATED: Only loads the current level data. Total level count is not referenced in UI.
  void _loadLevel(int index) {
    if (index >= GameData.allLevels.length) {
      _showOverallCompletionDialog();
      return;
    }

    final newLevelData = GameData.allLevels[index];
    
    // Deep copy the words so the found status is mutable
    final List<Word> wordsCopy = newLevelData.words.map((w) => Word(text: w.text, hint: w.hint)).toList();

    _currentLevel = GameLevel(
      category: newLevelData.category,
      letters: newLevelData.letters, // Letters are already shuffled in GameData
      words: wordsCopy,
    );

    setState(() {
      _currentLevelIndex = index;
      _currentWordIndex = 0; // Always start at the first word of the new level
      _currentDraggedWord = "";
      _selectedLetterIndices = [];
      _dragLineOffsets = [];
      // Reset button size calculation for the new number of letters
      _letterButtonSize = null; 
    });
  }

  // --- Utility Methods for Dragging (UNCHANGED) ---

  // NOTE: This method ensures letters are dynamically spaced based on the letter count.
  Offset _getLetterCenterOffset(int index, Size wheelSize) {
    if (wheelSize.isEmpty) return Offset.zero;

    final double wheelRadius = wheelSize.width / 2;
    final double angleStep = 2 * pi / _currentLevel.letters.length;
    
    double angle = index * angleStep - pi / 2; 
    final buttonRadiusOffset = wheelRadius * 0.7; 
    
    return Offset(
      wheelRadius + buttonRadiusOffset * cos(angle),
      wheelRadius + buttonRadiusOffset * sin(angle),
    );
  }

  void _onPanStart(DragStartDetails details) {
    _resetSelection();
    _detectAndSelectLetter(details.globalPosition);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _detectAndSelectLetter(details.globalPosition);
  }

  void _onPanEnd(DragEndDetails details) {
    _checkWord();
    _resetSelection();
  }

  void _resetSelection() {
    setState(() {
      _currentDraggedWord = "";
      _selectedLetterIndices = [];
      _dragLineOffsets = [];
    });
  }

  void _detectAndSelectLetter(Offset globalPosition) {
    if (_letterButtonSize == null || _letterWheelKey.currentContext == null) return;

    final RenderBox renderBox = _letterWheelKey.currentContext!.findRenderObject() as RenderBox;
    final Offset wheelLocalOrigin = renderBox.localToGlobal(Offset.zero);
    final Offset localPosition = globalPosition - wheelLocalOrigin;
    final Size wheelSize = renderBox.size;
    
    int? detectedIndex;

    for (int i = 0; i < _currentLevel.letters.length; i++) {
      final buttonCenter = _getLetterCenterOffset(i, wheelSize);
      
      final dx = localPosition.dx - buttonCenter.dx;
      final dy = localPosition.dy - buttonCenter.dy;
      if (dx * dx + dy * dy < (_letterButtonSize!.width / 2) * (_letterButtonSize!.width / 2)) {
        detectedIndex = i;
        break;
      }
    }

    if (detectedIndex != null) {
      setState(() {
        if (!_selectedLetterIndices.contains(detectedIndex)) {
          _selectedLetterIndices.add(detectedIndex!);
        } 

        _currentDraggedWord = _selectedLetterIndices.map((idx) => _currentLevel.letters[idx]).join();
        _dragLineOffsets = _selectedLetterIndices.map((idx) => _getLetterCenterOffset(idx, wheelSize)).toList();
        _dragLineOffsets.add(localPosition);
      });
    } else {
      setState(() {
        if (_selectedLetterIndices.isNotEmpty) {
          _dragLineOffsets = _selectedLetterIndices.map((idx) => _getLetterCenterOffset(idx, wheelSize)).toList();
          _dragLineOffsets.add(localPosition);
        }
      });
    }
  }

  // --- Game Logic and Progression ---

  void _checkWord() {
    if (_currentDraggedWord.isEmpty) return;

    // Find the target word for the current index.
    final targetWord = _currentLevel.words[_currentWordIndex].text;

    if (targetWord == _currentDraggedWord) {
      setState(() {
        _currentLevel.words[_currentWordIndex].isFound = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Success! You found \"$_currentDraggedWord\"! 🔬"),
          backgroundColor: Colors.green.shade600,
          duration: const Duration(seconds: 1),
        ),
      );

      // Advance to the next word within the current level
      if (_currentWordIndex < _currentLevel.words.length - 1) {
        setState(() {
          _currentWordIndex++;
        });
      } else {
        // Current Level Completed!
        _confettiController.play();
        _showLevelCompletionDialog(); // Show the celebration dialog immediately

        // AUTO-ADVANCE: Wait for the celebration, then load the next level.
        Future.delayed(const Duration(seconds: 3), () {
          _loadLevel(_currentLevelIndex + 1);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("\"$_currentDraggedWord\" is incorrect. Try again! 🧪"),
          backgroundColor: Colors.red.shade600,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }
  
  // ----------------------------------------------------------------------
  // --- Dialogs (UPDATED WITH NEW WIDGET) ---
  // ----------------------------------------------------------------------

  void _showLevelCompletionDialog() {
    final nextLevelIndex = _currentLevelIndex + 1;
    String nextLevelCategory = "Restart Challenge!";
    
    // Check if there is a next level to get its category
    if (nextLevelIndex < GameData.allLevels.length) {
      nextLevelCategory = GameData.allLevels[nextLevelIndex].category;
    }

    showDialog(
      context: context,
      barrierDismissible: false, // Prevents user from dismissing it immediately
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false, // Disable back button
          child: LevelCompleteDialog(
            currentLevelIndex: _currentLevelIndex,
            nextLevelCategory: nextLevelCategory,
          ),
        );
      },
    );
    
    // Dismiss the dialog automatically after a delay (matching the confetti/auto-advance delay)
    Future.delayed(const Duration(seconds: 3), () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }

  void _showOverallCompletionDialog() {
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("CONGRATULATIONS! 🥳"),
          content: const Text(
            "You have completed the entire science vocabulary challenge! You are a Science Star!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _loadLevel(0); // Restart Game
              },
              child: const Text("Restart Game"),
            ),
          ],
        );
      },
    );
  }


  // --- UI Build Method (UPDATED to remove total level count) ---

  @override
  Widget build(BuildContext context) {
    final currentWord = _currentLevel.words[_currentWordIndex];
    final foundWordsCountInLevel = _currentWordIndex;
    final totalWordsInLevel = _currentLevel.words.length;
    // final totalLevels = GameData.allLevels.length; // REMOVED for hidden progression

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade900,
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple.shade900, Colors.blue.shade900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned.fill(child: CustomPaint(painter: StarPainter())),
          
          SafeArea(
            child: Column(
              children: [
                // --- Header, Category, and Progress ---
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // UPDATED: Removed /TotalLevels count
                          Text(
                            "Level ${_currentLevelIndex + 1}: ${_currentLevel.category}", 
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyan.shade200), 
                          ),
                          Text(
                            "Word ${foundWordsCountInLevel + 1}/$totalWordsInLevel",
                            style: const TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Level Progress Bar
                      LinearProgressIndicator(
                        value: foundWordsCountInLevel / totalWordsInLevel,
                        backgroundColor: Colors.blue.shade800,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                ),

                // --- Target Word Display (Clue + Slots) ---
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.blue.shade300, width: 1),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "SCIENCE CLUE:",
                            style: TextStyle(fontSize: 14, color: Colors.cyan, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          // Hint
                          Text(
                            currentWord.hint,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.blue.shade100, fontStyle: FontStyle.italic),
                          ),
                          const SizedBox(height: 20),
                          // Word Slots
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: currentWord.text.split('').map((letter) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Container(
                                  width: 25,
                                  height: 35,
                                  decoration: const BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.white, width: 3)),
                                  ),
                                  alignment: Alignment.center,
                                  child: currentWord.isFound
                                      ? Text(
                                          letter,
                                          style: const TextStyle(fontSize: 24, color: Colors.greenAccent, fontWeight: FontWeight.w900),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // --- Current Dragged Word Display ---
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
                  ),
                  child: Text(
                    _currentDraggedWord.isEmpty ? "Connect letters!" : _currentDraggedWord,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade700,
                      letterSpacing: 2,
                    ),
                  ),
                ),

                // --- Letter Wheel & Drag Line Overlay ---
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onPanStart: _onPanStart,
                      onPanUpdate: _onPanUpdate,
                      onPanEnd: _onPanEnd,
                      child: Container(
                        key: _letterWheelKey,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.shade800.withOpacity(0.4),
                          border: Border.all(color: Colors.blue.shade600, width: 3),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final double wheelRadius = constraints.maxWidth / 2;
                            // Dynamically adjust button size for the current number of letters (4-8)
                            final letterCount = _currentLevel.letters.length;
                            double sizeFactor = 0.7;
                            if (letterCount > 7) {
                              sizeFactor = 0.6; // Smaller for 8 letters
                            } else if (letterCount < 6) {
                              sizeFactor = 0.8; // Larger for 4 or 5 letters
                            }
                            // This calculation dynamically adjusts the button size relative to the wheel size and letter count.
                            final double letterButtonSize = wheelRadius * sizeFactor / (1.5); 
                            
                            // Set button size for drag detection
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (_letterButtonSize == null || _letterButtonSize!.width != letterButtonSize) {
                                setState(() {
                                  _letterButtonSize = Size(letterButtonSize, letterButtonSize);
                                });
                              }
                            });

                            return Stack(
                              children: [
                                // Drag Line
                                Positioned.fill(
                                  child: CustomPaint(
                                    painter: DragLinePainter(
                                      _dragLineOffsets,
                                      Colors.yellowAccent.withOpacity(0.8),
                                      letterButtonSize / 3,
                                    ),
                                  ),
                                ),
                                
                                // Letter Buttons
                                ...List.generate(_currentLevel.letters.length, (index) {
                                  final center = _getLetterCenterOffset(index, constraints.biggest);
                                  final x = center.dx - (letterButtonSize / 2);
                                  final y = center.dy - (letterButtonSize / 2);

                                  final bool isSelected = _selectedLetterIndices.contains(index);

                                  return Positioned(
                                    left: x,
                                    top: y,
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 100),
                                      curve: Curves.easeOut,
                                      width: letterButtonSize,
                                      height: letterButtonSize,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected ? Colors.amberAccent : Colors.white,
                                        border: Border.all(
                                          color: isSelected ? Colors.deepOrange : Colors.grey.shade400,
                                          width: isSelected ? 3 : 1,
                                        ),
                                        boxShadow: isSelected
                                            ? [BoxShadow(color: Colors.amber.withOpacity(0.8), blurRadius: 10)]
                                            : [BoxShadow(color: Colors.black12, blurRadius: 4)],
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        _currentLevel.letters[index],
                                        style: TextStyle(
                                          fontSize: letterButtonSize * 0.5,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected ? Colors.deepPurple : Colors.black87,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Confetti overlay
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: -pi / 2,
              maxBlastForce: 20,
              minBlastForce: 8,
              emissionFrequency: 0.03,
              numberOfParticles: 50,
              gravity: 0.2,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
                Colors.yellow
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------
// --- NEW LEVEL COMPLETION DIALOG WIDGET ---
// ----------------------------------------------------------------------

class LevelCompleteDialog extends StatelessWidget {
  final int currentLevelIndex;
  final String nextLevelCategory;

  const LevelCompleteDialog({
    super.key,
    required this.currentLevelIndex,
    required this.nextLevelCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 20,
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.cyan.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.deepPurple.shade900.withOpacity(0.5),
                blurRadius: 15,
                offset: const Offset(0, 8)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Level ${currentLevelIndex + 1} Conquered! 🏆",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Colors.deepPurple.shade700,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Science Mastery Achieved!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.deepPurple.shade200),
              ),
              child: Text(
                "Up Next: Level ${currentLevelIndex + 2}\nCategory: '$nextLevelCategory'",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.deepPurple.shade700,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 25),
            Column(
              children: [
                const Text(
                  "Auto-advancing in 3 seconds...",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: const LinearProgressIndicator(
                      value: null, 
                      backgroundColor: Colors.deepPurple,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                      minHeight: 8,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------
// --- CUSTOM PAINTERS (UNCHANGED) ---
// ----------------------------------------------------------------------

class DragLinePainter extends CustomPainter {
  final List<Offset> offsets;
  final Color color;
  final double strokeWidth;

  DragLinePainter(this.offsets, this.color, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    if (offsets.length < 2) return;

    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path();
    path.moveTo(offsets.first.dx, offsets.first.dy);

    for (int i = 1; i < offsets.length; i++) {
      path.lineTo(offsets[i].dx, offsets[i].dy);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant DragLinePainter oldDelegate) {
    return oldDelegate.offsets != offsets || oldDelegate.color != color;
  }
}

class StarPainter extends CustomPainter {
  final Random _random = Random();

  @override
  void paint(Canvas canvas, Size size) {
    final starPaint = Paint()..color = Colors.white54;
    const int numberOfStars = 100;

    for (int i = 0; i < numberOfStars; i++) {
      final double x = _random.nextDouble() * size.width;
      final double y = _random.nextDouble() * size.height;
      final double radius = 0.5 + _random.nextDouble() * 1.5;
      canvas.drawCircle(Offset(x, y), radius, starPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}