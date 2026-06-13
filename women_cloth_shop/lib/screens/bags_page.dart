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

class BagsPage extends StatefulWidget {
  const BagsPage({super.key});

  @override
  State<BagsPage> createState() => _BagsPageState();
}

class _BagsPageState extends State<BagsPage> {
  PriceFilter _priceFilter = const PriceFilter();

  static const Color backgroundColor = Color(0xFFF9F7F2);
  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  List<Product> get allPants => const [
    Product(
      id: "product_pants_001",
      name: "White Short Pant",
      price: "\$89",
      image: "../../assets/images/pant1.jpg",
      rating: 4.7,
      reviewCount: 178,
    ),
    Product(
      id: "product_pants_002",
      name: "Pink Short Pant",
      price: "\$79",
      image: "../../assets/images/pant2.jpg",
      rating: 4.5,
      reviewCount: 143,
    ),
    Product(
      id: "product_pants_003",
      name: "Short Jean",
      price: "\$99",
      image: "../../assets/images/pant3.webp",
      rating: 4.8,
      reviewCount: 96,
    ),
    Product(
      id: "product_pants_004",
      name: "White Long Pant",
      price: "\$89",
      image: "../../assets/images/pant4.jpg",
      rating: 4.7,
      reviewCount: 178,
    ),
    Product(
      id: "product_pants_005",
      name: "Long Jean",
      price: "\$79",
      image: "../../assets/images/pant5.webp",
      rating: 4.5,
      reviewCount: 143,
    ),
    Product(
      id: "product_pants_006",
      name: "Long Pink Pilate Pant",
      price: "\$99",
      image: "../../assets/images/pant6.jpg",
      rating: 4.8,
      reviewCount: 96,
    ),
  ];

  List<Product> get filteredPants {
    if (!_priceFilter.isActive) return allPants;
    return allPants.where((p) => _priceFilter.matches(p.priceValue)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final pants = filteredPants;

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
              const CategoryListWidget(activeIndex: 4),
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
                    child: const PantIcon(
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pants",
                        style: GoogleFonts.comfortaa(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: darkText,
                        ),
                      ),
                      Text(
                        "${pants.length} items",
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
                child: pants.isEmpty
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
                        itemCount: pants.length,
                        itemBuilder: (_, index) {
                          return ProductCardWidget(product: pants[index]);
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