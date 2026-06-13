import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';
import '../components/product_card.dart';
import '../components/navigation_bar_widget.dart';
import '../components/search_bar_widget.dart';
import '../components/category_list_widget.dart';
import '../components/glass_bottom_nav_widget.dart';

class SkirtsPage extends StatelessWidget {
  const SkirtsPage({super.key});

  static const Color backgroundColor = Color(0xFFF9F7F2);
  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  @override
  Widget build(BuildContext context) {
    final skirts = [
      Product(
        id: "product_skirt_001",
        name: "Pleated Mini Skirt",
        price: "\$49",
        image: "assets/images/style1.png",
        rating: 4.5,
        reviewCount: 87,
      ),
      Product(
        id: "product_skirt_002",
        name: "A-Line Midi Skirt",
        price: "\$59",
        image: "assets/images/style2.png",
        rating: 4.3,
        reviewCount: 72,
      ),
      Product(
        id: "product_skirt_003",
        name: "Wrap Skirt",
        price: "\$44",
        image: "assets/images/style3.png",
        rating: 4.6,
        reviewCount: 115,
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBody: true,
      bottomNavigationBar: const GlassBottomNavWidget(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NavigationBarWidget(),
              const SizedBox(height: 15),
              const SearchBarWidget(),
              const SizedBox(height: 20),
              const CategoryListWidget(activeIndex: 3),
              const SizedBox(height: 22),

              // Section header with count
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.skateboarding_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Skirts",
                        style: GoogleFonts.comfortaa(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: darkText,
                        ),
                      ),
                      Text(
                        "${skirts.length} items",
                        style: GoogleFonts.comfortaa(
                          fontSize: 11,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Filter chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black.withOpacity(0.08)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.tune, size: 16, color: accent),
                        const SizedBox(width: 6),
                        Text(
                          "Filter",
                          style: GoogleFonts.comfortaa(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: darkText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Product grid
              Expanded(
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  physics: const BouncingScrollPhysics(),
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  itemCount: skirts.length,
                  itemBuilder: (_, index) {
                    return ProductCardWidget(product: skirts[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
