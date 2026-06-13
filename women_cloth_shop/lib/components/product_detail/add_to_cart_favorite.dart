import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddToCartFavorite extends StatefulWidget {
  final VoidCallback onAddToCart;
  final VoidCallback onToggleFavorite;
  final bool isFavorited;

  const AddToCartFavorite({
    super.key,
    required this.onAddToCart,
    required this.onToggleFavorite,
    required this.isFavorited,
  });

  @override
  State<AddToCartFavorite> createState() => _AddToCartFavoriteState();
}

class _AddToCartFavoriteState extends State<AddToCartFavorite> {
  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  void _handleFavorite() {
    final willBeFavorited = !widget.isFavorited;
    widget.onToggleFavorite();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          willBeFavorited ? 'Added to favorites ❤' : 'Removed from favorites',
          style: GoogleFonts.comfortaa(
            color: Colors.white,
            fontSize: 13,
          ),
        ),
        backgroundColor: accent,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleAddToCart() {
    widget.onAddToCart();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Added to cart ✓',
          style: GoogleFonts.comfortaa(
            color: Colors.white,
            fontSize: 13,
          ),
        ),
        backgroundColor: accent,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // ADD TO CART BUTTON
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _handleAddToCart,
                icon: const Icon(Icons.shopping_bag_outlined, size: 20),
                label: Text(
                  'Add to Cart',
                  style: GoogleFonts.comfortaa(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // FAVORITE BUTTON
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _handleFavorite,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      widget.isFavorited
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.isFavorited ? Colors.red : darkText,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // SHIPPING INFO
        Row(
          children: [
            const Icon(
              Icons.local_shipping_outlined,
              size: 18,
              color: Colors.black54,
            ),
            const SizedBox(width: 8),
            Text(
              'Free shipping on orders over \$100',
              style: GoogleFonts.comfortaa(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
