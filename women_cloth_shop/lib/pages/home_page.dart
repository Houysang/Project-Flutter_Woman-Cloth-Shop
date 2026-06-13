import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/navigation_bar_widget.dart';
import '../components/search_bar_widget.dart';
import '../components/category_list_widget.dart';
import '../components/section_title_widget.dart';
import '../components/featured_card_widget.dart';
import '../components/trending_section.dart';
import '../components/product_grid.dart';
import '../components/footer_widget.dart';
import '../components/glass_bottom_nav_widget.dart';
import '../components/season_edit_section.dart';
import '../components/footer_icon.dart';

import '../data/products.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const Color backgroundColor = Color(0xFFF9F7F2);
  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      extendBody: true,
      bottomNavigationBar: const GlassBottomNavWidget(),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NavigationBarWidget(),
              const SizedBox(height: 20),

              const SearchBarWidget(),
              const SizedBox(height: 25),

              // ---- DAILY STYLE VIBE ----
              _dailyVibeCard(),
              const SizedBox(height: 25),

              const CategoryListWidget(),
              const SizedBox(height: 25),

              const SectionTitleWidget(title: 'Promotion'),
              const SizedBox(height: 15),

              const FeaturedCardWidget(),
              const SizedBox(height: 30),

              const SectionTitleWidget(title: 'Trending Now'),
              const SizedBox(height: 4),
              // Editorial subtitle
              Text(
                "Most loved pieces this week",
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  color: Colors.black45,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 15),

              TrendingSection(
                products: ProductData.products,
              ),

              const SizedBox(height: 35),

              // ---- STORY BETWEEN SECTIONS ----
              _styleStoryCard(),
              const SizedBox(height: 35),

              const SeasonEditSection(),
              const SizedBox(height: 35),

              // ---- STYLE TAGS ----
              _styleTagsRow(),
              const SizedBox(height: 30),

              const SectionTitleWidget(title: 'Products'),
              const SizedBox(height: 4),
              Text(
                "Complete your wardrobe essentials",
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  color: Colors.black45,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 15),

              const ProductGridWidget(),

              const SizedBox(height: 30),
              const FooterWidget(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ---- DAILY VIBE CARD ----
  Widget _dailyVibeCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF6F0EA),
            Color(0xFFF3E8DF),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          // Sun icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.wb_sunny_outlined,
              color: Color(0xFFE8A87C),
              size: 22,
            ),
          ),

          const SizedBox(width: 14),

          // Text
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Vibe",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black45,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Soft neutrals & cozy elegance",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),

          // Mood dots
          Row(
            children: [
              _moodDot(const Color(0xFFD4B8A0)),
              const SizedBox(width: 4),
              _moodDot(const Color(0xFFE8C9B0)),
              const SizedBox(width: 4),
              _moodDot(const Color(0xFFF2DCC8)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _moodDot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1),
      ),
    );
  }

  // ---- STYLE STORY CARD ----
  Widget _styleStoryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, size: 16, color: accent),
              const SizedBox(width: 8),
              Text(
                "EDITOR'S NOTE",
                style: GoogleFonts.comfortaa(
                  fontSize: 10,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                  color: accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Fashion is the armor to survive the reality of everyday life. "
            "This season, we celebrate quiet confidence — pieces that speak "
            "without shouting, and elegance that feels effortless.",
            style: GoogleFonts.comfortaa(
              fontSize: 13,
              color: darkText.withOpacity(0.8),
              height: 1.7,
            ),
          ),
          const SizedBox(height: 14),
          // Signature
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Center(
                  child: Text(
                    "N",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "NEARY Editorial",
                style: GoogleFonts.comfortaa(
                  fontSize: 11,
                  color: Colors.black45,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---- STYLE TAGS ----
  Widget _styleTagsRow() {
    final tags = [
      "Soft Neutral",
      "Cozy Chic",
      "Minimal Elegance",
      "Everyday Luxe",
      "Warm Tones",
    ];

    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black.withOpacity(0.08)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
                child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FooterIcon(index: i, color: accent),
                        const SizedBox(width: 6),
                Text(
                  tags[i],
                  style: GoogleFonts.comfortaa(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: darkText,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}