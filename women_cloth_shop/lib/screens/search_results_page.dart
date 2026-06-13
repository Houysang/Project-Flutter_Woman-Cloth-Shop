import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/product_catalog.dart';
import '../models/product.dart';
import '../screens/product_detail_page.dart';
import '../components/glass_bottom_nav_widget.dart';

class SearchResultsPage extends StatefulWidget {
  final String query;

  const SearchResultsPage({super.key, required this.query});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  late List<MapEntry<String, Map<String, dynamic>>> _results;

  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);
  static const Color bgLight = Color(0xFFF9F7F2);

  @override
  void initState() {
    super.initState();
    _search(widget.query);
  }

  void _search(String query) {
    final lowerQuery = query.toLowerCase();
    final allProducts = ProductCatalog.getAllProducts().entries.toList();
    setState(() {
      _results = allProducts.where((entry) {
        final name = (entry.value['name'] as String).toLowerCase();
        final material =
            (entry.value['material'] as String?)?.toLowerCase() ?? '';
        final origin = (entry.value['origin'] as String?)?.toLowerCase() ?? '';
        return name.contains(lowerQuery) ||
            material.contains(lowerQuery) ||
            origin.contains(lowerQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: darkText),
        title: Text(
          'Search Results',
          style: GoogleFonts.comfortaa(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: darkText,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search info bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 3,
                  height: 16,
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${_results.length} result${_results.length == 1 ? '' : 's'} for "${widget.query}"',
                  style: GoogleFonts.comfortaa(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Results
          Expanded(
            child: _results.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 48,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No results found',
                          style: GoogleFonts.comfortaa(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: darkText,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try a different search term',
                          style: GoogleFonts.comfortaa(
                            fontSize: 13,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      final entry = _results[index];
                      final product = entry.value;
                      final images = List<String>.from(product['images'] ?? []);
                      final image = images.isNotEmpty ? images.first : '';
                      final name = product['name'] ?? '';
                      final price = product['price'] ?? '';
                      final rating = (product['rating'] ?? 0).toDouble();
                      final reviews = product['reviews'] ?? 0;
                      final material = product['material'] ?? '';

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductDetailPage(productId: entry.key),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Image
                                ClipRRect(
                                  borderRadius: const BorderRadius.horizontal(
                                      left: Radius.circular(18)),
                                  child: Image.asset(
                                    image,
                                    width: 100,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Info
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: GoogleFonts.comfortaa(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: darkText,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        if (material.isNotEmpty)
                                          Text(
                                            material,
                                            style: GoogleFonts.comfortaa(
                                              fontSize: 11,
                                              color: Colors.black45,
                                            ),
                                          ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Icon(Icons.star,
                                                size: 14,
                                                color: const Color(0xFFFFB800)),
                                            const SizedBox(width: 4),
                                            Text(
                                              '$rating ($reviews)',
                                              style: GoogleFonts.comfortaa(
                                                fontSize: 11,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          price,
                                          style: GoogleFonts.comfortaa(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: accent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: Colors.grey.shade300,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const GlassBottomNavWidget(),
    );
  }
}
