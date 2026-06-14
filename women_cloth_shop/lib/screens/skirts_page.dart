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
import '../components/menu_overlay_widget.dart';

class SkirtsPage extends StatefulWidget {
  const SkirtsPage({super.key});

  @override
  State<SkirtsPage> createState() => _SkirtsPageState();
}

class _SkirtsPageState extends State<SkirtsPage> {
  PriceFilter _priceFilter = const PriceFilter();
  bool _isMenuOpen = false;

  void _closeMenu() {
    setState(() => _isMenuOpen = false);
  }

  static const Color backgroundColor = Color(0xFFF9F7F2);
  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  List<Product> get allSkirts => const [
    Product(
      id: "product_skirt_001",
      name: "Short Skirt",
      price: "\$49",
      image: "../../assets/images/skirt1.webp",
      rating: 4.5,
      reviewCount: 87,
    ),
    Product(
      id: "product_skirt_002",
      name: "Short Skirt",
      price: "\$59",
      image: "../../assets/images/skirt2.jpg",
      rating: 4.3,
      reviewCount: 72,
    ),
    Product(
      id: "product_skirt_003",
      name: "Short Skirt",
      price: "\$44",
      image: "../../assets/images/skirt3.jpg",
      rating: 4.6,
      reviewCount: 115,
    ),
    Product(
      id: "product_skirt_004",
      name: "long Skirt",
      price: "\$49",
      image: "../../assets/images/skirt4.jpg",
      rating: 4.5,
      reviewCount: 87,
    ),
    Product(
      id: "product_skirt_005",
      name: "long Skirt",
      price: "\$59",
      image: "../../assets/images/skirt5.jpg",
      rating: 4.3,
      reviewCount: 72,
    ),
    Product(
      id: "product_skirt_006",
      name: "long Skirt",
      price: "\$44",
      image: "../../assets/images/skirt6.webp",
      rating: 4.6,
      reviewCount: 115,
    ),
  ];

  List<Product> get filteredSkirts {
    if (!_priceFilter.isActive) return allSkirts;
    return allSkirts.where((p) => _priceFilter.matches(p.priceValue)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final skirts = filteredSkirts;

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBody: true,
      bottomNavigationBar: const GlassBottomNavWidget(),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NavigationBarWidget(
                    onMenuTap: () => setState(() => _isMenuOpen = true),
                  ),
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
                        child: const SkirtIcon(
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
                    child: skirts.isEmpty
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
          // === MENU OVERLAY ===
          if (_isMenuOpen)
            MenuOverlayWidget(
              onClose: _closeMenu,
            ),
        ],
      ),
    );
  }
}