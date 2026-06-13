import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';
import '../components/product_card.dart';
import '../components/navigation_bar_widget.dart';
import '../components/search_bar_widget.dart';
import '../components/category_list_widget.dart';
import '../components/glass_bottom_nav_widget.dart';
import '../components/category_icons.dart';
import '../components/filter_bottom_sheet.dart';

class TopsPage extends StatefulWidget {
  const TopsPage({super.key});

  @override
  State<TopsPage> createState() => _TopsPageState();
}

class _TopsPageState extends State<TopsPage> {
  PriceFilter _priceFilter = const PriceFilter();

  static const Color backgroundColor = Color(0xFFF9F7F2);
  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  List<Product> get allTops => const [
    Product(
      id: "product_top_001",
      name: "Oversized Shirt",
      price: "\$59",
      image: "../../assets/images/top1.webp",
      rating: 4.5,
      reviewCount: 87,
    ),
    Product(
      id: "product_top_002",
      name: "Crop Top",
      price: "\$39",
      image: "../../assets/images/top2.jpg",
      rating: 4.2,
      reviewCount: 64,
    ),
    Product(
      id: "product_top_003",
      name: "Silk Blouse",
      price: "\$69",
      image: "../../assets/images/top3.webp",
      rating: 4.8,
      reviewCount: 203,
    ),
    Product(
      id: "product_top_004",
      name: "Oversized Shirt",
      price: "\$59",
      image: "../../assets/images/top6.jpg",
      rating: 4.5,
      reviewCount: 87,
    ),
    Product(
      id: "product_top_005",
      name: "Crop Top",
      price: "\$39",
      image: "../../assets/images/top4.webp",
      rating: 4.2,
      reviewCount: 64,
    ),
    Product(
      id: "product_top_006",
      name: "Silk Blouse",
      price: "\$69",
      image: "../../assets/images/top7.jpg",
      rating: 4.8,
      reviewCount: 203,
    ),
  ];

  List<Product> get filteredTops {
    if (!_priceFilter.isActive) return allTops;
    return allTops.where((p) => _priceFilter.matches(p.priceValue)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final tops = filteredTops;

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
                    child: const TopIcon(
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
                  GestureDetector(
                    onTap: () => FilterBottomSheet.show(
                      context,
                      currentFilter: _priceFilter,
                      onApply: (filter) => setState(() => _priceFilter = filter),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _priceFilter.isActive ? accent : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _priceFilter.isActive
                              ? accent
                              : Colors.black.withOpacity(0.08),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.tune,
                            size: 16,
                            color: _priceFilter.isActive ? Colors.white : accent,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _priceFilter.isActive ? "Filtered" : "Filter",
                            style: GoogleFonts.comfortaa(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _priceFilter.isActive ? Colors.white : darkText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Product grid
              Expanded(
                child: tops.isEmpty
                    ? Center(
                        child: Text(
                          "No products in this price range",
                          style: GoogleFonts.comfortaa(
                            fontSize: 14,
                            color: Colors.black45,
                          ),
                        ),
                      )
                    : MasonryGridView.count(
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