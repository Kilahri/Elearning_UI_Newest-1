import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WatchScreen extends StatefulWidget {
  final String role; // Student, Teacher, or Admin

  const WatchScreen({super.key, this.role = "Student"});

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> with TickerProviderStateMixin {
  late VideoPlayerController _videoController;
  late TabController _tabController;
  
  int currentLessonIndex = 0; // Use index starting from 0
  
  // Example lesson list
  final List<Map<String, String>> lessons = [
    {
      "title": "Solar System for Kids",
      "desc": "Explore planets, moons, and stars in space! This introductory module covers basic celestial bodies and how they interact.",
      "url": "https://samplelib.com/lib/preview/mp4/sample-5s.mp4"
    },
    {
      "title": "Animal Habitats",
      "desc": "Learn about different animal homes, biomes, and how environmental factors influence wildlife adaptation and survival.",
      "url": "https://samplelib.com/lib/preview/mp4/sample-10s.mp4"
    },
    {
      "title": "The Water Cycle",
      "desc": "Discover evaporation, condensation, and rain. Understand the essential process that moves water around Earth.",
      "url": "https://samplelib.com/lib/preview/mp4/sample-15s.mp4"
    },
  ];

  final TextEditingController _notesController = TextEditingController();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // Details, Notes, Discussion
    _loadVideo(lessons[currentLessonIndex]["url"]!);
  }

  void _loadVideo(String url) {
    _videoController = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          // Start playing automatically once loaded (optional)
          // _videoController.play(); 
        });
      })
      ..addListener(() {
        // Force rebuild during video playback for progress indicator updates
        if (mounted) setState(() {}); 
      });
  }

  void _changeLesson(int newIndex) {
    if (newIndex >= 0 && newIndex < lessons.length) {
      setState(() {
        currentLessonIndex = newIndex;
        _isInitialized = false;
        _videoController.dispose();
        _loadVideo(lessons[currentLessonIndex]["url"]!);
      });
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    _tabController.dispose();
    _notesController.dispose();
    super.dispose();
  }
  
  // --------------------------------------------------------------------------
  // --- WIDGET HELPER FUNCTIONS ---
  // --------------------------------------------------------------------------

  /// Enhanced Video Controls Overlay
  Widget _buildVideoControls() {
    return Container(
      color: Colors.black38,
      child: Center(
        child: IconButton(
          icon: Icon(
            _videoController.value.isPlaying
                ? Icons.pause_circle_filled
                : Icons.play_circle_fill,
            size: 80,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _videoController.value.isPlaying
                  ? _videoController.pause()
                  : _videoController.play();
            });
          },
        ),
      ),
    );
  }

  /// Teacher/Admin Feature Section
  Widget _buildRoleFeatures() {
    List<Widget> buttons = [];
    String title = "";
    Color color = Colors.blueGrey;

    if (widget.role == "Teacher") {
      title = "👨‍🏫 Teacher Tools";
      color = const Color(0xFFFFC107); // Yellow accent
      buttons = [
        _featureButton("Upload/Replace Video", Icons.upload_file, () {}),
        _featureButton("Attach Resources", Icons.picture_as_pdf, () {}),
      ];
    } else if (widget.role == "Admin") {
      title = "🛡️ Admin Tools";
      color = Colors.redAccent;
      buttons = [
        _featureButton("Approve Content", Icons.check_circle, () {}),
        _featureButton("View Analytics", Icons.bar_chart, () {}),
      ];
    } else {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: Colors.white30, height: 30),
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: buttons,
          ),
        ],
      ),
    );
  }

  Widget _featureButton(String label, IconData icon, VoidCallback onPressed) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white38),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
  
  // --------------------------------------------------------------------------
  // --- MAIN BUILD METHOD ---
  // --------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final lesson = lessons[currentLessonIndex];
    final totalLessons = lessons.length;
    final progress = (currentLessonIndex + 1) / totalLessons;

    return Scaffold(
      backgroundColor: const Color(0xFF0D102C),
      
      // We'll use the AppBar only for navigation elements if needed
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D102C),
        automaticallyImplyLeading: true, 
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      
      body: Column(
        children: [
          // 📺 Fixed Video Player Section
          Container(
            color: Colors.black,
            child: AspectRatio(
              aspectRatio: _isInitialized ? _videoController.value.aspectRatio : 16 / 9,
              child: Stack(
                children: [
                  Center(
                    child: _isInitialized
                        ? VideoPlayer(_videoController)
                        : const CircularProgressIndicator(color: Colors.white),
                  ),
                  // Custom Controls and Progress
                  if (_isInitialized) ...[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _videoController.value.isPlaying
                              ? _videoController.pause()
                              : _videoController.play();
                        });
                      },
                      child: _buildVideoControls(),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: VideoProgressIndicator(
                        _videoController,
                        allowScrubbing: true,
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                        colors: const VideoProgressColors(
                          playedColor: Color(0xFF7B4DFF), // Purple accent
                          backgroundColor: Colors.white38,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          
          // --- Main Content Tabs ---
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),

                  // Lesson Title
                  Text(
                    lesson["title"]!,
                    style: const TextStyle(
                      fontSize: 22, 
                      fontWeight: FontWeight.w900, 
                      color: Colors.white
                    ),
                  ),
                  const SizedBox(height: 5),

                  // Progress Tracker
                  LinearProgressIndicator(
                    value: progress,
                    color: const Color(0xFF7B4DFF),
                    backgroundColor: Colors.white24,
                    minHeight: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      "Lesson ${currentLessonIndex + 1} of $totalLessons - ${(progress * 100).toStringAsFixed(0)}% Complete",
                      style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  // Tab Bar for Navigation
                  TabBar(
                    controller: _tabController,
                    indicatorColor: const Color(0xFFFFC107), // Yellow accent for indicator
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white54,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    tabs: const [
                      Tab(text: "Details"),
                      Tab(text: "Notes"),
                      Tab(text: "Lessons"),
                    ],
                  ),

                  // Tab Views
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // --- 1. Details Tab ---
                        SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lesson["desc"]!,
                                style: const TextStyle(fontSize: 15, color: Colors.white70, height: 1.5),
                              ),
                              const SizedBox(height: 20),
                              
                              // Quiz CTA
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.quiz, color: Colors.black),
                                label: const Text("Take Quiz", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFC107), // Yellow accent
                                  minimumSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                              ),

                              _buildRoleFeatures(), // Teacher/Admin tools here
                            ],
                          ),
                        ),

                        // --- 2. Notes Tab ---
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            controller: _notesController,
                            maxLines: null, // Allow unlimited lines for notes
                            keyboardType: TextInputType.multiline,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                            decoration: InputDecoration(
                              hintText: "Start writing your key takeaways and thoughts here...",
                              hintStyle: const TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: const Color(0xFF1C1F3E),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.all(15),
                            ),
                          ),
                        ),

                        // --- 3. Lessons Tab (Playlist) ---
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemCount: lessons.length,
                          itemBuilder: (context, index) {
                            final lessonData = lessons[index];
                            final isCurrent = index == currentLessonIndex;
                            
                            return Card(
                              color: isCurrent ? const Color(0xFF1C1F3E) : const Color(0xFF0D102C),
                              elevation: 0,
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                onTap: () => _changeLesson(index),
                                leading: Icon(
                                  isCurrent ? Icons.play_arrow : Icons.check_circle_outline,
                                  color: isCurrent ? const Color(0xFF7B4DFF) : Colors.white70,
                                ),
                                title: Text(
                                  lessonData["title"]!,
                                  style: TextStyle(
                                    color: isCurrent ? Colors.white : Colors.white70,
                                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                                subtitle: Text(
                                  "Lesson ${index + 1}",
                                  style: TextStyle(
                                    color: isCurrent ? Colors.white70 : Colors.white54,
                                  ),
                                ),
                                trailing: isCurrent 
                                    ? const Icon(Icons.visibility, color: Color(0xFF7B4DFF)) 
                                    : null,
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
        ],
      ),
      
      // Bottom Navigation for Next/Previous (if not using a playlist tab)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFF1C1F3E),
          border: Border(top: BorderSide(color: Colors.white12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Previous Button
            OutlinedButton.icon(
              onPressed: currentLessonIndex > 0 ? () => _changeLesson(currentLessonIndex - 1) : null,
              icon: const Icon(Icons.arrow_back),
              label: const Text("Previous"),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white54),
              ),
            ),
            // Next Button
            ElevatedButton.icon(
              onPressed: currentLessonIndex < totalLessons - 1 ? () => _changeLesson(currentLessonIndex + 1) : null,
              icon: const Icon(Icons.arrow_forward),
              label: const Text("Next Lesson"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7B4DFF), // Primary accent color
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}