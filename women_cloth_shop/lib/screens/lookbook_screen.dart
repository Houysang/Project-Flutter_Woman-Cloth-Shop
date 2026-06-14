import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'lookbook_detail_page.dart';
import 'outfit_builder_page.dart';
import '../components/glass_bottom_nav_widget.dart';
import '../models/related_item.dart';

class LookbookPage extends StatefulWidget {
  const LookbookPage({super.key});

  @override
  State<LookbookPage> createState() => _LookbookPageState();
}

class _LookbookPageState extends State<LookbookPage> {
  int selectedTab = 0;

  final List<Map<String, dynamic>> outfits = [
    {
      "title": "The Silk Edit",
      "subtitle": "Luxurious silk essentials for the modern wardrobe",
      "image": "assets/silk_edit.png",
      "tag": "New",
      "items": 12,
    },
    {
      "title": "Modern Tailoring",
      "subtitle": "Sharp silhouettes meet soft femininity",
      "image": "assets/modern_tailoring.png",
      "tag": null,
      "items": 8,
    },
    {
      "title": "Golden Hour Ease",
      "subtitle": "Warm tones and effortless sophistication",
      "image": "assets/golden_hour.png",
      "tag": null,
      "items": 10,
    },
    {
      "title": "Ephemeral Lovers",
      "subtitle": "Romantic layers and delicate textures",
      "image": "assets/ephemeral_lovers.png",
      "tag": "Trending",
      "items": 6,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2D2926)),
        title: Text(
          'Lookbook',
          style: GoogleFonts.comfortaa(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2D2926),
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            // Elegant pill-shaped toggle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EBE4),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedTab = 0),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
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
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
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

            const SizedBox(height: 20),

            // Sub-header: collection count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Container(
                    width: 3,
                    height: 16,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC5A081),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${outfits.length} curated collections",
                    style: GoogleFonts.comfortaa(
                      fontSize: 12,
                      color: const Color(0xFF6E655B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Content depending on tab
            Expanded(
              child: selectedTab == 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.62,
                        ),
                        itemCount: outfits.length,
                        itemBuilder: (context, index) {
                          final outfit = outfits[index];
                          return GestureDetector(
                            onTap: () {
                              final data = LookbookDetailPage.collectionFor(outfit["title"] as String);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LookbookDetailPage(
                                    title: data.title,
                                    image: data.image,
                                    subtitle: data.subtitle,
                                    tag: data.tag,
                                    items: data.items,
                                    pieces: data.pieces,
                                    relatedItems: data.relatedItems,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Image.asset(
                                            outfit["image"]!,
                                            fit: BoxFit.cover,
                                          ),
                                          // Gradient overlay
                                          Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.transparent,
                                                  Colors.black.withOpacity(0.5),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Tag badge (if any)
                                          if (outfit["tag"] != null)
                                            Positioned(
                                              top: 10,
                                              left: 10,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: outfit["tag"] == "New"
                                                      ? const Color(0xFF5D4E37)
                                                      : const Color(0xFFC5A081),
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  outfit["tag"]!,
                                                  style: GoogleFonts.comfortaa(
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          // Collection number
                                          Positioned(
                                            top: 10,
                                            right: 10,
                                            child: Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.2),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "${index + 1}",
                                                  style: GoogleFonts.comfortaa(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Title overlay at bottom
                                          Positioned(
                                            left: 12,
                                            right: 12,
                                            bottom: 12,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  outfit["title"]!,
                                                  style: GoogleFonts.cormorantGaramond(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                    height: 1.1,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  "${outfit["items"]} pieces",
                                                  style: GoogleFonts.comfortaa(
                                                    fontSize: 10,
                                                    color: Colors.white.withOpacity(0.7),
                                                    letterSpacing: 0.3,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Bottom section
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          size: 6,
                                          color: const Color(0xFFC5A081),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "Explore",
                                          style: GoogleFonts.comfortaa(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFFC5A081),
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        const Spacer(),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 10,
                                          color: const Color(0xFFC5A081),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF5D4E37).withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.dashboard_customize_outlined,
                                  size: 32,
                                  color: const Color(0xFF5D4E37),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Build Your Own Outfit",
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF2D2926),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Mix and match pieces to create\nyour signature look",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.comfortaa(
                                  fontSize: 13,
                                  color: const Color(0xFF6E655B),
                                  height: 1.7,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF5D4E37),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Text(
                                  "Tap to Start",
                                  style: GoogleFonts.comfortaa(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
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