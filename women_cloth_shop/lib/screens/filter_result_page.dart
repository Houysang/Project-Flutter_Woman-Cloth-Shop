import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterResultPage extends StatelessWidget {
  final String category;
  final String size;
  final String color;
  final double minPrice;
  final double maxPrice;

  const FilterResultPage({
    super.key,
    required this.category,
    required this.size,
    required this.color,
    required this.minPrice,
    required this.maxPrice,
  });

  static const Color background = Color(0xFFF9F7F2);
  static const Color darkText = Color(0xFF2D2926);
  static const Color accent = Color(0xFFC5A081);

  @override
  Widget build(BuildContext context) {
    final products = [
      {"name": "Nike Shoes", "price": 120.0, "category": "Shoes"},
      {"name": "Zara Dress", "price": 80.0, "category": "Dresses"},
      {"name": "Gucci Bag", "price": 900.0, "category": "Accessories"},
      {"name": "H&M Knitwear", "price": 60.0, "category": "Knitwear"},
    ];

    final filtered = products.where((p) {
      final price = p["price"] as double;
      final cat = p["category"] as String;

      return cat == category && price >= minPrice && price <= maxPrice;
    }).toList();

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        iconTheme: const IconThemeData(color: darkText),
        title: Text(
          "Filter Results",
          style: GoogleFonts.comfortaa(
            color: darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "Category: $category | Size: $size | Color: $color",
              style: GoogleFonts.comfortaa(
                fontWeight: FontWeight.w600,
                color: darkText,
              ),
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text(
                      "No products found",
                      style: GoogleFonts.comfortaa(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final item = filtered[index];

                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.shopping_bag),
                          title: Text(
                            item["name"].toString(),
                            style: GoogleFonts.comfortaa(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            item["category"].toString(),
                            style: GoogleFonts.comfortaa(),
                          ),
                          trailing: Text(
                            "\$${item["price"]}",
                            style: GoogleFonts.comfortaa(
                              fontWeight: FontWeight.bold,
                              color: accent,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
