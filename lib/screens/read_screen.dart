import 'package:flutter/material.dart';

// --- Book Data Model (Placeholder Content) ---
final List<Map<String, String>> scienceBooks = [
  {
    "title": "The Periodic Table of Elements",
    "image": "lib/assets/periodicTable.jpg",
    "content": "The Periodic Table is a tabular arrangement of the chemical elements, organized by atomic number, electron configuration, and recurring chemical properties. It is crucial for understanding chemistry. Focus on the main groups: Alkali Metals, Halogens, and Noble Gases.",
    "theme": "Chemistry"
  },
  {
    "title": "Earth Day Every Day - Earth Science",
    "image": "lib/assets/lifeBook.jpg",
    "content": "Earth Science covers the physical constitution of Earth and its atmosphere. Key topics include plate tectonics, volcanoes, earthquakes, and the water cycle. Conservation and sustainability are vital concepts.",
    "theme": "Earth Science"
  },
  {
    "title": "Chemistry Science",
    "image": "lib/assets/chemistry.jpg",
    "content": "Chemistry is the scientific study of the properties and behavior of matter. This chapter introduces atoms, molecules, and chemical bonds. Practice balancing simple equations and identifying reactants and products.",
    "theme": "Chemistry"
  },
  {
    "title": "Interactive Science - Human Body",
    "image": "lib/assets/humanBodySystems.jpg",
    "content": "Explore the major systems of the human body: the skeletal, muscular, nervous, and circulatory systems. Focus on how these systems work together to maintain life and health (homeostasis).",
    "theme": "Biology"
  },
];

final List<Map<String, String>> spaceBooks = [
  {
    "title": "What's out there? - All about space",
    "image": "lib/assets/spaceBook.jpg",
    "content": "Discover the solar system, galaxies, and the universe. Learn about the stars, planets, and moons. Special attention is given to the phases of the moon and the difference between rotation and revolution.",
    "theme": "Astronomy"
  },
  {
    "title": "Earth and Space Science - Planets",
    "image": "lib/assets/earthAndSpace.jpg",
    "content": "This book details the unique features of the eight planets in our solar system. Key areas: the formation of the Earth and the distinction between terrestrial and gas giant planets.",
    "theme": "Astronomy"
  },
];

// --- EXTRACT A FEATURED BOOK FOR THE BANNER ---
final Map<String, String> featuredBook = scienceBooks[0];

// ------------------------------------------------------------------

class ReadScreen extends StatelessWidget {
  const ReadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D102C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D102C),
        automaticallyImplyLeading: false,
        title: const Text(
          "📚 READ",
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          // --- 1. Enhanced Search Bar ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: "Search titles, themes, or topics...",
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                suffixIcon: const Icon(Icons.filter_list, color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16), // More rounded corners
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFF1C1F3E), // Darker input field
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
          
          // --- 2. Featured Book Banner ---
          _featuredBookBanner(context, featuredBook),
          
          const SizedBox(height: 15),

          // --- 3. Science Category ---
          _sectionTitle("🧪 Core Science", "Explore essential topics in chemistry and biology."),
          _bookGrid(context, scienceBooks),

          // --- 4. Space Category ---
          _sectionTitle("🌌 Space & Astronomy", "Discover the cosmos, planets, and physics."),
          _bookGrid(context, spaceBooks),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // --------------------------------------------------------------------------
  // --- WIDGET HELPER FUNCTIONS FOR ReadScreen ---
  // --------------------------------------------------------------------------
  
  /// 📢 Enhanced Section Title with Subtitle
  Widget _sectionTitle(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
  
  /// ✨ Featured Book Banner
  Widget _featuredBookBanner(BuildContext context, Map<String, String> book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => BookContentScreen(
              title: book["title"]!,
              content: book["content"]!,
              theme: book["theme"]!,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.all(16),
        height: 150,
        decoration: BoxDecoration(
          // Use an accent color for the featured card
          color: const Color(0xFF7B4DFF), 
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 5)),
          ],
        ),
        child: Row(
          children: [
            // Book Image/Icon
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                book["image"]!,
                height: 120,
                width: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 120,
                  width: 80,
                  color: const Color(0xFF9E7CFF),
                  child: const Icon(Icons.star, color: Colors.white, size: 40),
                ),
              ),
            ),
            const SizedBox(width: 15),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Featured Read:",
                    style: TextStyle(color: Color(0xFFFFC107), fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book["title"]!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    book["theme"]!,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }


  /// 📖 Book Item - Enhanced Card Design
  Widget _bookItem(String image, String title, VoidCallback onTap, String theme) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1C1F3E), // Card background
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Colors.black38, blurRadius: 6, offset: Offset(0, 3)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                image,
                height: 160, // Consistent image height
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 160,
                  color: Colors.grey.shade700,
                  child: const Center(child: Icon(Icons.menu_book, color: Colors.white, size: 40)),
                ),
              ),
            ),
            
            // Text Content Section
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Theme Tag
                  Text(
                    theme,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      // Use a color based on the theme (e.g., green for biology)
                      color: theme == "Biology" ? Colors.lightGreenAccent : Colors.amber, 
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Title
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 📚 Book Grid - Updated to pass theme to _bookItem
  Widget _bookGrid(BuildContext context, List<Map<String, String>> books) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16, // Increased spacing
        mainAxisSpacing: 16, // Increased spacing
        childAspectRatio: 0.70, // Slightly taller cards
        children: books.map((book) {
          return _bookItem(
            book["image"]!,
            book["title"]!,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => BookContentScreen(
                    title: book["title"]!,
                    content: book["content"]!,
                    theme: book["theme"]!,
                  ),
                ),
              );
            },
            book["theme"]!, // Pass the theme to the card item
          );
        }).toList(),
      ),
    );
  }
}

// ------------------------------------------------------------------
// --- ENHANCED BookContentScreen ---
// ------------------------------------------------------------------

class BookContentScreen extends StatelessWidget {
  final String title;
  final String content;
  final String theme;

  const BookContentScreen({
    super.key,
    required this.title,
    required this.content,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D102C),
      appBar: AppBar(
        // Use the primary background color for a seamless look
        backgroundColor: const Color(0xFF0D102C), 
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        // Title is often better displayed in the body for long titles
        title: const Text("Book Preview", style: TextStyle(color: Colors.white70, fontSize: 16)),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header: Title and Theme ---
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Theme Badge with rounded edges
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7B4DFF), 
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '#$theme',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            
            // --- Divider/Separator ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: Color(0xFF1C1F3E), thickness: 2),
            ),

            // --- Content Area ---
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Subtitle for Content
                  const Text(
                    "Chapter Summary:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // Main Content Text
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // --- Floating Action Button/Call to Action ---
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Opening full interactive book...')),
                        );
                      },
                      icon: const Icon(Icons.auto_stories, color: Colors.black),
                      label: const Text('Open Full Interactive Book', 
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC107), // Bright yellow accent
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), // Pill shape
                        elevation: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}