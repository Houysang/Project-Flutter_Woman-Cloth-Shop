import 'package:flutter/material.dart';
import 'outfit_builder_screen.dart';

class LookbookPage extends StatefulWidget {
  const LookbookPage({super.key});

  @override
  State<LookbookPage> createState() => _LookbookPageState();
}

class _LookbookPageState extends State<LookbookPage> {
  int selectedTab = 0; // 0 = Pre-Styled, 1 = Build Outfit
  int bottomIndex = 0; // track bottom nav selection

  final List<Map<String, String>> outfits = [
    {"title": "The Silk Edit", "image": "assets/silk_edit.png"},
    {"title": "Modern Tailoring", "image": "assets/modern_tailoring.png"},
    {"title": "Golden Hour Ease", "image": "assets/golden_hour.png"},
    {"title": "Ephemeral Lovers", "image": "assets/ephemeral_lovers.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Header styled like OnlyWomen
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5DC),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color(0xFF5D4E37)),
          onPressed: () {},
        ),
        title: const Text(
          "OnlyWomen",
          style: TextStyle(
            color: Color(0xFF5D4E37),
            fontSize: 22,
            fontFamily: 'Times New Roman',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.shopping_bag_outlined, color: Color(0xFF5D4E37)),
          ),
        ],
      ),

      body: Column(
        children: [
          const SizedBox(height: 12),

          // Pill-shaped toggle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTab = 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedTab == 0
                              ? const Color(0xFF5D4E37)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            "Pre-Styled",
                            style: TextStyle(
                              color: selectedTab == 0
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedTab = 1);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OutfitBuilderPage(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedTab == 1
                              ? const Color(0xFF5D4E37)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            "Build Outfit",
                            style: TextStyle(
                              color: selectedTab == 1
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),

          // Content depending on tab
          Expanded(
            child: selectedTab == 0
                ? ListView.builder(
                    itemCount: outfits.length,
                    itemBuilder: (context, index) {
                      final outfit = outfits[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(14),
                                ),
                                child: Image.asset(
                                  outfit["image"]!,
                                  height: 280,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Text(
                                      outfit["title"]!,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OutfitBuilderPage(
                                                    presetTitle:
                                                        outfit["title"],
                                                    presetImage:
                                                        outfit["image"],
                                                  ),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF5D4E37),
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: const Text(
                                          "BUILD THIS LOOK",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
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
                    },
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OutfitBuilderPage(),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: const Center(
                        child: Text(
                          "Build Outfit\n\nTap to start",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),

      // 🔥 Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomIndex,
        onTap: (index) {
          setState(() => bottomIndex = index);
          // handle navigation logic here
        },
        selectedItemColor: const Color(0xFF5D4E37),
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Collections",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.brush),
            label: "Atelier",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
