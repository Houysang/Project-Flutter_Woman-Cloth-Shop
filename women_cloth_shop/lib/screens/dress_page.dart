import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';
import '../components/product_card.dart';
import '../components/navigation_bar_widget.dart';
import '../components/search_bar_widget.dart';
import '../components/category_list_widget.dart';
import '../components/glass_bottom_nav_widget.dart';

class DressPage extends StatelessWidget {
  const DressPage({super.key});

  static const Color backgroundColor = Color(0xFFF9F7F2);
  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  @override
  Widget build(BuildContext context) {
    final dresses = [
      Product(
        id: "product_dress_001",
        name: "Summer Floral Dress",
        price: "\$79",
        image: "assets/images/dress1.png",
        rating: 4.7,
        reviewCount: 156,
      ),
      Product(
        id: "product_dress_002",
        name: "Elegant Evening Dress",
        price: "\$99",
        image: "assets/images/dress2.png",
        rating: 4.6,
        reviewCount: 134,
      ),
      Product(
        id: "product_dress_003",
        name: "Casual Day Dress",
        price: "\$59",
        image: "assets/images/dress3.png",
        rating: 4.4,
        reviewCount: 98,
      ),
        Product(
        id: "product_dress_004",
        name: "Casual Day Dress",
        price: "\$59",
        image: "../../assets/images/dress4.jpg",
        rating: 4.4,
        reviewCount: 98,
      ),
        Product(
        id: "product_dress_005",
        name: "Casual Day Dress",
        price: "\$59",
        image: "../../assets/images/dress5.jpg",
        rating: 4.4,
        reviewCount: 98,
      ),
      Product(
        id: "product_dress_006",
        name: "Casual Day Dress",
        price: "\$59",
        image: "../../assets/images/dress6.jpg",
        rating: 4.4,
        reviewCount: 98,
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
              const CategoryListWidget(activeIndex: 1),
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
                      Icons.woman_2_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dresses",
                        style: GoogleFonts.comfortaa(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: darkText,
                        ),
                      ),
                      Text(
                        "${dresses.length} items",
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
                  itemCount: dresses.length,
                  itemBuilder: (_, index) {
                    return ProductCardWidget(product: dresses[index]);
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