import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';
import '../components/product_card.dart';
import '../components/navigation_bar_widget.dart';
import '../components/search_bar_widget.dart';
import '../components/category_list_widget.dart';
import '../components/glass_bottom_nav_widget.dart';

class TopsPage extends StatelessWidget {
  const TopsPage({super.key});

  static const Color backgroundColor = Color(0xFFF9F7F2);
  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  @override
  Widget build(BuildContext context) {
    final tops = [
      Product(
        id: "product_top_001",
        name: "Oversized Shirt",
        price: "\$59",
        image: "assets/images/top1.png",
        rating: 4.5,
        reviewCount: 87,
      ),
      Product(
        id: "product_top_002",
        name: "Crop Top",
        price: "\$39",
        image: "assets/images/top2.png",
        rating: 4.2,
        reviewCount: 64,
      ),
      Product(
        id: "product_top_003",
        name: "Silk Blouse",
        price: "\$69",
        image: "assets/images/top3.png",
        rating: 4.8,
        reviewCount: 203,
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
              const CategoryListWidget(activeIndex: 2),
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
                      Icons.checkroom_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tops",
                        style: GoogleFonts.comfortaa(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: darkText,
                        ),
                      ),
                      Text(
                        "${tops.length} items",
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
                  itemCount: tops.length,
                  itemBuilder: (_, index) {
                    return ProductCardWidget(product: tops[index]);
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
