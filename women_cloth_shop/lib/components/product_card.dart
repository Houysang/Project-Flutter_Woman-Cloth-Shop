import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';
import '../screens/product_detail_page.dart';

class ProductCardWidget extends StatefulWidget {
  final Product product;

  const ProductCardWidget({
    super.key,
    required this.product,
  });

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  bool isFav = false;
  bool inCart = false;

  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(productId: p.id),
          ),
        );
      },
      child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE + FAVORITE
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.asset(
                  p.coverImage,
                ),
              ),

              // Favorite button
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => setState(() => isFav = !isFav),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color: isFav ? Colors.red : Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // INFO SECTION
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product name
                Text(
                  p.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.comfortaa(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: darkText,
                  ),
                ),

                const SizedBox(height: 4),

                // Star rating
                Row(
                  children: [
                    ...List.generate(5, (i) {
                      final starVal = i + 1;
                      return Icon(
                        starVal <= p.rating.round()
                            ? Icons.star
                            : starVal - 0.5 <= p.rating
                                ? Icons.star_half
                                : Icons.star_border,
                        size: 14,
                        color: const Color(0xFFFFB800),
                      );
                    }),
                    const SizedBox(width: 4),
                    Text(
                      '(${p.reviewCount})',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Price + Add to cart
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      p.price,
                      style: GoogleFonts.comfortaa(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => inCart = !inCart),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: inCart ? Colors.green : accent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          inCart ? Icons.check : Icons.shopping_bag_outlined,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}