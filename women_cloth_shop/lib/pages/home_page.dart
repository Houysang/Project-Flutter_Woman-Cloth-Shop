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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const Color backgroundColor = Color(0xFFF9F7F2);
  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isMenuOpen = false;

  void _closeMenu() {
    setState(() => _isMenuOpen = false);
  }

  void _onMenuItemTap(MenuItemData item) {
    if (item.route == '/logout') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Logging out..."),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }
    try {
      Navigator.pushReplacementNamed(context, item.route);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${item.label} page coming soon"),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomePage.backgroundColor,
      extendBody: true,
      bottomNavigationBar: const GlassBottomNavWidget(),
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NavigationBarWidget(
                    onMenuTap: () => setState(() => _isMenuOpen = true),
                  ),
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

          // === MENU OVERLAY ===
          if (_isMenuOpen) const _MenuOverlay(),
        ],
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
              const Icon(Icons.auto_awesome, size: 16, color: HomePage.accent),
              const SizedBox(width: 8),
              Text(
                "EDITOR'S NOTE",
                style: GoogleFonts.comfortaa(
                  fontSize: 10,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w700,
                  color: HomePage.accent,
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
              color: HomePage.darkText.withOpacity(0.8),
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
                  color: HomePage.accent,
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
                FooterIcon(index: i, color: HomePage.accent),
                const SizedBox(width: 6),
                Text(
                  tags[i],
                  style: GoogleFonts.comfortaa(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: HomePage.darkText,
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

/// Menu overlay that slides in from the left, showing the menu panel
/// with a close button at the top.
class _MenuOverlay extends StatelessWidget {
  const _MenuOverlay();

  @override
  Widget build(BuildContext context) {
    final homeState = context.findAncestorStateOfType<_HomePageState>();

    return GestureDetector(
      onTap: () => homeState?._closeMenu(),
      child: Row(
        children: [
          // Menu panel (tapping here doesn't dismiss)
          GestureDetector(
            onTap: () {}, // prevent dismiss when tapping menu
            child: Container(
              width: MediaQuery.of(context).size.width * 0.65,
              height: double.infinity,
              color: const Color(0xFFF9F7F2),
              child: Column(
                children: [
                  // Close button at the top
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => homeState?._closeMenu(),
                      child: Container(
                        margin: const EdgeInsets.only(top: 12, right: 12),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Color(0xFF2D2926),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  // Menu content
                  Expanded(
                    child: _MenuContent(
                      onItemTap: (item) {
                        if (homeState != null) {
                          homeState._closeMenu();
                          homeState._onMenuItemTap(item);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Remaining space is the dismiss area - shows you're "in" the menu overlay
          Expanded(
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItemData {
  final IconData icon;
  final String label;
  final String route;
  final bool isDestructive;

  const MenuItemData({
    required this.icon,
    required this.label,
    required this.route,
    this.isDestructive = false,
  });
}

class _MenuContent extends StatelessWidget {
  final void Function(MenuItemData) onItemTap;

  const _MenuContent({required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    final items = [
      MenuItemData(icon: Icons.home_outlined, label: "Home", route: '/shop'),
      MenuItemData(
          icon: Icons.person_outline,
          label: "Profile Setting",
          route: '/profile'),
      MenuItemData(
          icon: Icons.calendar_today_outlined,
          label: "Booking",
          route: '/booking'),
      MenuItemData(
          icon: Icons.info_outlined, label: "About Us", route: '/about'),
      MenuItemData(
          icon: Icons.mail_outline, label: "Contact", route: '/contact'),
      MenuItemData(
          icon: Icons.logout,
          label: "Logout",
          route: '/logout',
          isDestructive: true),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Center(
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC5A081).withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person,
                      size: 24, color: Color(0xFFC5A081)),
                ),
                const SizedBox(height: 8),
                Text(
                  "Hello!",
                  style: GoogleFonts.comfortaa(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2D2926),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: const Color(0xFFC5A081).withOpacity(0.1)),
          const SizedBox(height: 8),

          // Menu items
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: items.length,
              itemBuilder: (context, i) {
                final item = items[i];
                return GestureDetector(
                  onTap: () => onItemTap(item),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    margin: const EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.icon,
                          size: 18,
                          color: item.isDestructive
                              ? Colors.red
                              : const Color(0xFFC5A081),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          item.label,
                          style: GoogleFonts.comfortaa(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: item.isDestructive
                                ? Colors.red
                                : const Color(0xFF2D2926),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Brand signature
          Center(
            child: Text(
              "NEARY FASHION",
              style: GoogleFonts.comfortaa(
                fontSize: 10,
                letterSpacing: 3,
                color: Colors.black26,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
