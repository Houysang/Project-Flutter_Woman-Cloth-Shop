import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'outfit_builder_screen.dart';
import '../components/navigation_bar_widget.dart';
import '../components/glass_bottom_nav_widget.dart';

class LookbookPage extends StatefulWidget {
  const LookbookPage({super.key});

  @override
  State<LookbookPage> createState() => _LookbookPageState();
}

class _LookbookPageState extends State<LookbookPage> {
  int selectedTab = 0; // 0 = Pre-Styled, 1 = Build Outfit

  final List<Map<String, String>> outfits = [
    {"title": "The Silk Edit", "image": "assets/silk_edit.png"},
    {"title": "Modern Tailoring", "image": "assets/modern_tailoring.png"},
    {"title": "Golden Hour Ease", "image": "assets/golden_hour.png"},
    {"title": "Ephemeral Lovers", "image": "assets/ephemeral_lovers.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: NavigationBarWidget(
                onMenuTap: () {},
              ),
            ),

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
                              style: GoogleFonts.comfortaa(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: selectedTab == 0
                                    ? Colors.white
                                    : const Color(0xFF2D2926),
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
                              style: GoogleFonts.comfortaa(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: selectedTab == 1
                                    ? Colors.white
                                    : const Color(0xFF2D2926),
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
                                        style: GoogleFonts.cormorantGaramond(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF2D2926),
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
                                          child: Text(
                                            "BUILD THIS LOOK",
                                            style: GoogleFonts.comfortaa(
                                              fontSize: 13,
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
                        child: Center(
                          child: Text(
                            "Build Outfit\n\nTap to start",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.comfortaa(
                              color: const Color(0xFF6E655B),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const GlassBottomNavWidget(),
    );
  }
}