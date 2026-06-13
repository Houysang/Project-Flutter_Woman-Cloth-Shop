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

class DressPage extends StatefulWidget {
  const DressPage({super.key});

  @override
  State<DressPage> createState() => _DressPageState();
}

class _DressPageState extends State<DressPage> {
  PriceFilter _priceFilter = const PriceFilter();

  static const Color backgroundColor = Color(0xFFF9F7F2);
  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  List<Product> get allDresses => const [
    Product(
      id: "product_dress_001",
      name: "Summer Floral Dress",
      price: "\$79",
      image: "../../assets/images/dress1.jpg",
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
      name: "Elegant Blue Evening Dress",
      price: "\$59",
      image: "../../assets/images/dress4.jpg",
      rating: 4.4,
      reviewCount: 98,
    ),
    Product(
      id: "product_dress_005",
      name: "Casual Yellow Day Dress",
      price: "\$59",
      image: "../../assets/images/dress7.jpg",
      rating: 4.4,
      reviewCount: 98,
    ),
    Product(
      id: "product_dress_006",
      name: "Girly Pink Day Dress",
      price: "\$59",
      image: "../../assets/images/dress8.jpg",
      rating: 4.4,
      reviewCount: 98,
    ),
  ];

  List<Product> get filteredDresses {
    if (!_priceFilter.isActive) return allDresses;
    return allDresses.where((p) => _priceFilter.matches(p.priceValue)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final dresses = filteredDresses;

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
                    child: const DressIcon(
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
                child: dresses.isEmpty
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