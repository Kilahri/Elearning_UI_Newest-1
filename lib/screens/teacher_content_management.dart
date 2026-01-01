import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:elearningapp_flutter/screens/read_screen.dart' as read_screen;
import 'package:elearningapp_flutter/data/video_data.dart';
import 'package:elearningapp_flutter/screens/book_content_editor_screen.dart';

/// Comprehensive Teacher Content Management Screen
/// Allows teachers to Create, Read, Update, and Delete content for:
/// - Read (Books)
/// - Watch (Videos/Lessons)
/// - Play (Games)
class TeacherContentManagementScreen extends StatefulWidget {
  const TeacherContentManagementScreen({super.key});

  @override
  State<TeacherContentManagementScreen> createState() =>
      _TeacherContentManagementScreenState();
}

class _TeacherContentManagementScreenState
    extends State<TeacherContentManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D102C),
      appBar: AppBar(
        title: const Text(
          "Content Management",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF0D102C),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF7B4DFF),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          tabs: const [
            Tab(icon: Icon(Icons.menu_book), text: "Read"),
            Tab(icon: Icon(Icons.play_circle), text: "Watch"),
            Tab(icon: Icon(Icons.sports_esports), text: "Play"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ReadContentManagement(),
          WatchContentManagement(),
          PlayContentManagement(),
        ],
      ),
    );
  }
}

// ============================================================================
// READ CONTENT MANAGEMENT
// ============================================================================

class ReadContentManagement extends StatefulWidget {
  const ReadContentManagement({super.key});

  @override
  State<ReadContentManagement> createState() => _ReadContentManagementState();
}

class _ReadContentManagementState extends State<ReadContentManagement> {
  List<Map<String, dynamic>> allBooks = [];
  List<Map<String, dynamic>> teacherCreatedBooks = [];
  Map<String, Map<String, dynamic>> modifiedOriginalBooks = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  // Convert Book object to Map
  Map<String, dynamic> _bookToMap(read_screen.Book book) {
    return {
      'title': book.title,
      'image': book.image,
      'summary': book.summary,
      'theme': book.theme,
      'author': book.author,
      'readTime': book.readTime,
      'funFact': book.funFact,
      'chapters':
          book.chapters
              .map(
                (chapter) => {
                  'title': chapter.title,
                  'content': chapter.content,
                  'keyPoints': chapter.keyPoints,
                  'didYouKnow': chapter.didYouKnow,
                  'quizQuestions':
                      chapter.quizQuestions
                          .map(
                            (q) => {
                              'question': q.question,
                              'options': q.options,
                              'correctAnswer': q.correctAnswer,
                              'explanation': q.explanation,
                            },
                          )
                          .toList(),
                },
              )
              .toList(),
      'isOriginal': true,
      'id': book.title, // Use title as unique ID
    };
  }

  Future<void> _loadBooks() async {
    setState(() => _isLoading = true);
    final prefs = await SharedPreferences.getInstance();

    // Load teacher-created books
    String? booksJson = prefs.getString('teacher_books');
    if (booksJson != null) {
      try {
        teacherCreatedBooks = List<Map<String, dynamic>>.from(
          jsonDecode(booksJson),
        );
        teacherCreatedBooks.forEach((book) {
          book['isOriginal'] = false;
          book['id'] =
              book['title'] ?? DateTime.now().millisecondsSinceEpoch.toString();
        });
      } catch (e) {
        teacherCreatedBooks = [];
      }
    }

    // Load modified original books
    String? modifiedJson = prefs.getString('modified_original_books');
    if (modifiedJson != null) {
      try {
        final decoded = jsonDecode(modifiedJson) as Map<String, dynamic>;
        modifiedOriginalBooks = Map<String, Map<String, dynamic>>.from(
          decoded.map(
            (key, value) => MapEntry(key, Map<String, dynamic>.from(value)),
          ),
        );
      } catch (e) {
        modifiedOriginalBooks = {};
      }
    }

    // Load hardcoded books and convert to Map
    List<Map<String, dynamic>> originalBooks = [];

    // Add scienceBooks
    for (var book in read_screen.scienceBooks) {
      final bookId = book.title;
      // Check if this original book has been modified
      if (modifiedOriginalBooks.containsKey(bookId)) {
        originalBooks.add(modifiedOriginalBooks[bookId]!);
      } else {
        originalBooks.add(_bookToMap(book));
      }
    }

    // Add spaceBooks
    for (var book in read_screen.spaceBooks) {
      final bookId = book.title;
      // Check if this original book has been modified
      if (modifiedOriginalBooks.containsKey(bookId)) {
        originalBooks.add(modifiedOriginalBooks[bookId]!);
      } else {
        originalBooks.add(_bookToMap(book));
      }
    }

    // Merge all books: original first, then teacher-created
    setState(() {
      allBooks = [...originalBooks, ...teacherCreatedBooks];
      _isLoading = false;
    });
  }

  Future<void> _saveBooks() async {
    final prefs = await SharedPreferences.getInstance();

    // Save teacher-created books (filter out original books)
    final booksToSave =
        teacherCreatedBooks.map((book) {
          final bookCopy = Map<String, dynamic>.from(book);
          bookCopy.remove('isOriginal');
          bookCopy.remove('id');
          return bookCopy;
        }).toList();
    await prefs.setString('teacher_books', jsonEncode(booksToSave));

    // Save modified original books
    await prefs.setString(
      'modified_original_books',
      jsonEncode(modifiedOriginalBooks),
    );
  }

  void _showCreateBookDialog({Map<String, dynamic>? existingBook, int? index}) {
    final isEdit = existingBook != null;
    final isOriginal = existingBook?['isOriginal'] == true;
    final bookId = existingBook?['id'] ?? existingBook?['title'];
    final titleController = TextEditingController(
      text: existingBook?['title'] ?? '',
    );
    final summaryController = TextEditingController(
      text: existingBook?['summary'] ?? '',
    );
    final themeController = TextEditingController(
      text: existingBook?['theme'] ?? '',
    );
    final authorController = TextEditingController(
      text: existingBook?['author'] ?? '',
    );
    final readTimeController = TextEditingController(
      text: existingBook?['readTime']?.toString() ?? '15',
    );
    final funFactController = TextEditingController(
      text: existingBook?['funFact'] ?? '',
    );
    final imageController = TextEditingController(
      text: existingBook?['image'] ?? 'lib/assets/book_default.png',
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF1C1F3E),
            title: Text(
              isEdit ? 'Edit Book' : 'Create New Book',
              style: const TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: summaryController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Summary',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: themeController,
                    decoration: const InputDecoration(
                      labelText: 'Theme (e.g., Biology, Chemistry)',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: authorController,
                    decoration: const InputDecoration(
                      labelText: 'Author',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: readTimeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Read Time (minutes)',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: funFactController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Fun Fact',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: imageController,
                    decoration: const InputDecoration(
                      labelText: 'Image Path',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Ensure book has at least one default chapter if chapters list is empty
                  List<dynamic> chapters = existingBook?['chapters'] ?? [];
                  if (chapters.isEmpty && !isEdit) {
                    // Add a default chapter for new books
                    chapters = [
                      {
                        'title': 'Introduction',
                        'content':
                            'Welcome to ${titleController.text}! This is the first chapter. You can edit this book to add more content.',
                        'keyPoints': [
                          'This is a placeholder chapter',
                          'Edit the book to add more content',
                        ],
                        'didYouKnow':
                            'You can add more chapters by editing this book!',
                        'quizQuestions': [],
                      },
                    ];
                  }

                  final book = {
                    'title': titleController.text,
                    'summary': summaryController.text,
                    'theme': themeController.text,
                    'author': authorController.text,
                    'readTime': int.tryParse(readTimeController.text) ?? 15,
                    'funFact': funFactController.text,
                    'image': imageController.text,
                    'chapters': chapters,
                    'id': bookId ?? titleController.text,
                    'isOriginal': isOriginal,
                  };

                  if (isEdit && index != null) {
                    if (isOriginal) {
                      // Update modified original book
                      modifiedOriginalBooks[bookId] = book;
                    } else {
                      // Update teacher-created book
                      final teacherIndex = teacherCreatedBooks.indexWhere(
                        (b) => b['id'] == bookId,
                      );
                      if (teacherIndex != -1) {
                        teacherCreatedBooks[teacherIndex] = book;
                      }
                    }
                    // Update in allBooks list
                    allBooks[index] = book;
                  } else {
                    // New book - add to teacher-created
                    book['isOriginal'] = false;
                    teacherCreatedBooks.add(book);
                  }

                  _saveBooks();
                  Navigator.pop(context);
                  _loadBooks();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isEdit ? 'Book updated!' : 'Book created!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7B4DFF),
                ),
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  void _editBookContent(Map<String, dynamic> book, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => BookContentEditorScreen(
              book: book,
              onSave: (updatedBook) {
                final bookId = book['id'] ?? book['title'];
                final isOriginal = book['isOriginal'] == true;

                if (isOriginal) {
                  modifiedOriginalBooks[bookId] = updatedBook;
                } else {
                  final teacherIndex = teacherCreatedBooks.indexWhere(
                    (b) => b['id'] == bookId,
                  );
                  if (teacherIndex != -1) {
                    teacherCreatedBooks[teacherIndex] = updatedBook;
                  }
                }
                allBooks[index] = updatedBook;
                _saveBooks();
                _loadBooks();
              },
            ),
      ),
    );
  }

  void _deleteBook(int index) {
    final book = allBooks[index];
    final isOriginal = book['isOriginal'] == true;
    final bookId = book['id'] ?? book['title'];

    // Don't allow deletion of original books, only modifications can be reverted
    if (isOriginal && !modifiedOriginalBooks.containsKey(bookId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Original books cannot be deleted. You can modify them instead.',
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF1C1F3E),
            title: const Text(
              'Delete Book?',
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              'Are you sure you want to delete "${allBooks[index]['title']}"?',
              style: const TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (isOriginal && modifiedOriginalBooks.containsKey(bookId)) {
                    // Remove modification to restore original
                    modifiedOriginalBooks.remove(bookId);
                  } else {
                    // Remove from teacher-created books
                    teacherCreatedBooks.removeWhere((b) => b['id'] == bookId);
                  }
                  _saveBooks();
                  Navigator.pop(context);
                  _loadBooks();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Book deleted!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF7B4DFF)),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Books (${allBooks.length})',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showCreateBookDialog(),
                icon: const Icon(Icons.add),
                label: const Text('Create Book'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7B4DFF),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child:
              allBooks.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.menu_book,
                          size: 64,
                          color: Colors.white54,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No books available',
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => _showCreateBookDialog(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7B4DFF),
                          ),
                          child: const Text('Create Your First Book'),
                        ),
                      ],
                    ),
                  )
                  : ListView.builder(
                    itemCount: allBooks.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final book = allBooks[index];
                      final isOriginal = book['isOriginal'] == true;
                      return Card(
                        color: const Color(0xFF1C1F3E),
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: const Icon(
                            Icons.menu_book,
                            color: Color(0xFF7B4DFF),
                          ),
                          title: Text(
                            book['title'] ?? 'Untitled',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    book['theme'] ?? 'No theme',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  if (isOriginal) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: Colors.blue,
                                          width: 1,
                                        ),
                                      ),
                                      child: const Text(
                                        'Original',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              Text(
                                'By ${book['author'] ?? 'Unknown'}',
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.article,
                                  color: Colors.green,
                                ),
                                tooltip: 'Edit Content',
                                onPressed: () => _editBookContent(book, index),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                tooltip: 'Edit Details',
                                onPressed:
                                    () => _showCreateBookDialog(
                                      existingBook: book,
                                      index: index,
                                    ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                tooltip: 'Delete',
                                onPressed: () => _deleteBook(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}

// ============================================================================
// WATCH CONTENT MANAGEMENT
// ============================================================================

class WatchContentManagement extends StatefulWidget {
  const WatchContentManagement({super.key});

  @override
  State<WatchContentManagement> createState() => _WatchContentManagementState();
}

class _WatchContentManagementState extends State<WatchContentManagement> {
  List<Map<String, dynamic>> allVideos = [];
  List<Map<String, dynamic>> teacherCreatedVideos = [];
  Map<String, Map<String, dynamic>> modifiedOriginalVideos = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  // Convert ScienceLesson object to Map
  Map<String, dynamic> _videoToMap(ScienceLesson lesson) {
    return {
      'title': lesson.title,
      'emoji': lesson.emoji,
      'description': lesson.description,
      'videoUrl': lesson.videoUrl,
      'duration': lesson.duration,
      'funFact': lesson.funFact,
      'keyTopics': lesson.keyTopics,
      'moreFacts': lesson.moreFacts,
      'quizQuestions':
          lesson.quizQuestions
              .map(
                (q) => {
                  'question': q.question,
                  'options': q.options,
                  'correctAnswer': q.correctAnswer,
                  'explanation': q.explanation,
                  'emoji': q.emoji,
                },
              )
              .toList(),
      'isOriginal': true,
      'id': lesson.title, // Use title as unique ID
    };
  }

  Future<void> _loadVideos() async {
    setState(() => _isLoading = true);
    final prefs = await SharedPreferences.getInstance();

    // Load teacher-created videos
    String? videosJson = prefs.getString('teacher_videos');
    if (videosJson != null) {
      try {
        teacherCreatedVideos = List<Map<String, dynamic>>.from(
          jsonDecode(videosJson),
        );
        teacherCreatedVideos.forEach((video) {
          video['isOriginal'] = false;
          video['id'] =
              video['title'] ??
              DateTime.now().millisecondsSinceEpoch.toString();
        });
      } catch (e) {
        teacherCreatedVideos = [];
      }
    }

    // Load modified original videos
    String? modifiedJson = prefs.getString('modified_original_videos');
    if (modifiedJson != null) {
      try {
        final decoded = jsonDecode(modifiedJson) as Map<String, dynamic>;
        modifiedOriginalVideos = Map<String, Map<String, dynamic>>.from(
          decoded.map(
            (key, value) => MapEntry(key, Map<String, dynamic>.from(value)),
          ),
        );
      } catch (e) {
        modifiedOriginalVideos = {};
      }
    }

    // Load hardcoded videos and convert to Map
    List<Map<String, dynamic>> originalVideos = [];
    for (var lesson in scienceLessons) {
      final videoId = lesson.title;
      // Check if this original video has been modified
      if (modifiedOriginalVideos.containsKey(videoId)) {
        originalVideos.add(modifiedOriginalVideos[videoId]!);
      } else {
        originalVideos.add(_videoToMap(lesson));
      }
    }

    // Merge all videos: original first, then teacher-created
    setState(() {
      allVideos = [...originalVideos, ...teacherCreatedVideos];
      _isLoading = false;
    });
  }

  Future<void> _saveVideos() async {
    final prefs = await SharedPreferences.getInstance();

    // Save teacher-created videos
    final videosToSave =
        teacherCreatedVideos.map((video) {
          final videoCopy = Map<String, dynamic>.from(video);
          videoCopy.remove('isOriginal');
          videoCopy.remove('id');
          return videoCopy;
        }).toList();
    await prefs.setString('teacher_videos', jsonEncode(videosToSave));

    // Save modified original videos
    await prefs.setString(
      'modified_original_videos',
      jsonEncode(modifiedOriginalVideos),
    );
  }

  void _showCreateVideoDialog({
    Map<String, dynamic>? existingVideo,
    int? index,
  }) {
    final isEdit = existingVideo != null;
    final isOriginal = existingVideo?['isOriginal'] == true;
    final videoId = existingVideo?['id'] ?? existingVideo?['title'];
    final titleController = TextEditingController(
      text: existingVideo?['title'] ?? '',
    );
    final emojiController = TextEditingController(
      text: existingVideo?['emoji'] ?? '🎥',
    );
    final descriptionController = TextEditingController(
      text: existingVideo?['description'] ?? '',
    );
    final videoUrlController = TextEditingController(
      text: existingVideo?['videoUrl'] ?? '',
    );
    final durationController = TextEditingController(
      text: existingVideo?['duration'] ?? '5 min',
    );
    final funFactController = TextEditingController(
      text: existingVideo?['funFact'] ?? '',
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF1C1F3E),
            title: Text(
              isEdit ? 'Edit Video Lesson' : 'Create New Video Lesson',
              style: const TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: emojiController,
                    decoration: const InputDecoration(
                      labelText: 'Emoji',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: videoUrlController,
                    decoration: const InputDecoration(
                      labelText: 'Video URL (asset path or network URL)',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: durationController,
                    decoration: const InputDecoration(
                      labelText: 'Duration (e.g., 5 min)',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: funFactController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Fun Fact',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final video = {
                    'title': titleController.text,
                    'emoji': emojiController.text,
                    'description': descriptionController.text,
                    'videoUrl': videoUrlController.text,
                    'duration': durationController.text,
                    'funFact': funFactController.text,
                    'keyTopics': existingVideo?['keyTopics'] ?? [],
                    'moreFacts': existingVideo?['moreFacts'] ?? [],
                    'quizQuestions': existingVideo?['quizQuestions'] ?? [],
                    'id': videoId ?? titleController.text,
                    'isOriginal': isOriginal,
                  };

                  if (isEdit && index != null) {
                    if (isOriginal) {
                      // Update modified original video
                      modifiedOriginalVideos[videoId] = video;
                    } else {
                      // Update teacher-created video
                      final teacherIndex = teacherCreatedVideos.indexWhere(
                        (v) => v['id'] == videoId,
                      );
                      if (teacherIndex != -1) {
                        teacherCreatedVideos[teacherIndex] = video;
                      }
                    }
                    // Update in allVideos list
                    allVideos[index] = video;
                  } else {
                    // New video - add to teacher-created
                    video['isOriginal'] = false;
                    teacherCreatedVideos.add(video);
                  }

                  _saveVideos();
                  Navigator.pop(context);
                  _loadVideos();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isEdit ? 'Video updated!' : 'Video created!',
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7B4DFF),
                ),
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  void _deleteVideo(int index) {
    final video = allVideos[index];
    final isOriginal = video['isOriginal'] == true;
    final videoId = video['id'] ?? video['title'];

    // Don't allow deletion of original videos, only modifications can be reverted
    if (isOriginal && !modifiedOriginalVideos.containsKey(videoId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Original videos cannot be deleted. You can modify them instead.',
          ),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF1C1F3E),
            title: const Text(
              'Delete Video?',
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              'Are you sure you want to delete "${allVideos[index]['title']}"?',
              style: const TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (isOriginal &&
                      modifiedOriginalVideos.containsKey(videoId)) {
                    // Remove modification to restore original
                    modifiedOriginalVideos.remove(videoId);
                  } else {
                    // Remove from teacher-created videos
                    teacherCreatedVideos.removeWhere((v) => v['id'] == videoId);
                  }
                  _saveVideos();
                  Navigator.pop(context);
                  _loadVideos();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Video deleted!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF7B4DFF)),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Video Lessons (${allVideos.length})',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showCreateVideoDialog(),
                icon: const Icon(Icons.add),
                label: const Text('Create Video'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7B4DFF),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child:
              allVideos.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.play_circle_outline,
                          size: 64,
                          color: Colors.white54,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No video lessons available',
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => _showCreateVideoDialog(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7B4DFF),
                          ),
                          child: const Text('Create Your First Video'),
                        ),
                      ],
                    ),
                  )
                  : ListView.builder(
                    itemCount: allVideos.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final video = allVideos[index];
                      final isOriginal = video['isOriginal'] == true;
                      return Card(
                        color: const Color(0xFF1C1F3E),
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Text(
                            video['emoji'] ?? '🎥',
                            style: const TextStyle(fontSize: 32),
                          ),
                          title: Text(
                            video['title'] ?? 'Untitled',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      video['description'] ?? 'No description',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                  if (isOriginal) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          color: Colors.blue,
                                          width: 1,
                                        ),
                                      ),
                                      child: const Text(
                                        'Original',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              Text(
                                'Duration: ${video['duration'] ?? 'N/A'}',
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed:
                                    () => _showCreateVideoDialog(
                                      existingVideo: video,
                                      index: index,
                                    ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _deleteVideo(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}

// ============================================================================
// PLAY CONTENT MANAGEMENT
// ============================================================================

class PlayContentManagement extends StatefulWidget {
  const PlayContentManagement({super.key});

  @override
  State<PlayContentManagement> createState() => _PlayContentManagementState();
}

class _PlayContentManagementState extends State<PlayContentManagement> {
  List<Map<String, dynamic>> teacherGames = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  Future<void> _loadGames() async {
    setState(() => _isLoading = true);
    final prefs = await SharedPreferences.getInstance();
    String? gamesJson = prefs.getString('teacher_games');
    if (gamesJson != null) {
      try {
        setState(() {
          teacherGames = List<Map<String, dynamic>>.from(jsonDecode(gamesJson));
          _isLoading = false;
        });
      } catch (e) {
        setState(() => _isLoading = false);
      }
    } else {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveGames() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('teacher_games', jsonEncode(teacherGames));
  }

  void _showCreateGameDialog({Map<String, dynamic>? existingGame, int? index}) {
    final isEdit = existingGame != null;
    final titleController = TextEditingController(
      text: existingGame?['title'] ?? '',
    );
    final descriptionController = TextEditingController(
      text: existingGame?['description'] ?? '',
    );
    final categoryController = TextEditingController(
      text: existingGame?['category'] ?? '',
    );
    final imageController = TextEditingController(
      text: existingGame?['image'] ?? 'lib/assets/play.png',
    );
    final gameTypeController = TextEditingController(
      text: existingGame?['gameType'] ?? 'quiz',
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF1C1F3E),
            title: Text(
              isEdit ? 'Edit Game' : 'Create New Game',
              style: const TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Game Title',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: categoryController,
                    decoration: const InputDecoration(
                      labelText: 'Category (e.g., Science, Math)',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: gameTypeController,
                    decoration: const InputDecoration(
                      labelText: 'Game Type (quiz, puzzle, adventure, etc.)',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: imageController,
                    decoration: const InputDecoration(
                      labelText: 'Image Path',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final game = {
                    'title': titleController.text,
                    'description': descriptionController.text,
                    'category': categoryController.text,
                    'gameType': gameTypeController.text,
                    'image': imageController.text,
                    'createdAt': DateTime.now().toIso8601String(),
                  };
                  if (isEdit && index != null) {
                    teacherGames[index] = game;
                  } else {
                    teacherGames.add(game);
                  }
                  _saveGames();
                  Navigator.pop(context);
                  _loadGames();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isEdit ? 'Game updated!' : 'Game created!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7B4DFF),
                ),
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  void _deleteGame(int index) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: const Color(0xFF1C1F3E),
            title: const Text(
              'Delete Game?',
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              'Are you sure you want to delete "${teacherGames[index]['title']}"?',
              style: const TextStyle(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white54),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  teacherGames.removeAt(index);
                  _saveGames();
                  Navigator.pop(context);
                  _loadGames();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Game deleted!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF7B4DFF)),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Games (${teacherGames.length})',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showCreateGameDialog(),
                icon: const Icon(Icons.add),
                label: const Text('Create Game'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7B4DFF),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child:
              teacherGames.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.sports_esports,
                          size: 64,
                          color: Colors.white54,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No games created yet',
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => _showCreateGameDialog(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7B4DFF),
                          ),
                          child: const Text('Create Your First Game'),
                        ),
                      ],
                    ),
                  )
                  : ListView.builder(
                    itemCount: teacherGames.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final game = teacherGames[index];
                      return Card(
                        color: const Color(0xFF1C1F3E),
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: const Icon(
                            Icons.sports_esports,
                            color: Color(0xFF7B4DFF),
                          ),
                          title: Text(
                            game['title'] ?? 'Untitled',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                game['category'] ?? 'No category',
                                style: const TextStyle(color: Colors.white70),
                              ),
                              Text(
                                'Type: ${game['gameType'] ?? 'Unknown'}',
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed:
                                    () => _showCreateGameDialog(
                                      existingGame: game,
                                      index: index,
                                    ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _deleteGame(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
        ),
      ],
    );
  }
}
