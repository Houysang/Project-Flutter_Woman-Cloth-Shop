import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/dress_page.dart';
import '../screens/tops_page.dart';
import '../screens/skirts_page.dart';
import '../screens/bags_page.dart';
import '../pages/home_page.dart';

class CategoryListWidget extends StatelessWidget {
  final int activeIndex;

  const CategoryListWidget({
    super.key,
    this.activeIndex = 0,
  });

  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  @override
  Widget build(BuildContext context) {
    final categories = [
      _CategoryItem(
        label: "All",
        icon: Icons.grid_view_rounded,
        page: () => const HomePage(),
      ),
      _CategoryItem(
        label: "Dresses",
        icon: Icons.woman_2_outlined,
        page: () => const DressPage(),
      ),
      _CategoryItem(
        label: "Tops",
        icon: Icons.checkroom_outlined,
        page: () => const TopsPage(),
      ),
      _CategoryItem(
        label: "Skirts",
        icon: Icons.skateboarding_outlined,
        page: () => const SkirtsPage(),
      ),
      _CategoryItem(
        label: "Bags",
        icon: Icons.shopping_bag_outlined,
        page: () => const BagsPage(),
      ),
    ];

    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = categories[index];
          final isActive = index == activeIndex;

          return GestureDetector(
            onTap: () {
              if (index != activeIndex) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => item.page()),
                );
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: isActive ? accent : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isActive ? accent : Colors.black.withOpacity(0.08),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isActive ? 0.1 : 0.03),
                    blurRadius: isActive ? 8 : 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item.icon,
                    size: 15,
                    color: isActive ? Colors.white : accent,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    item.label,
                    style: GoogleFonts.comfortaa(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isActive ? Colors.white : darkText,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryItem {
  final String label;
  final IconData icon;
  final Widget Function() page;

  const _CategoryItem({
    required this.label,
    required this.icon,
    required this.page,
  });
}