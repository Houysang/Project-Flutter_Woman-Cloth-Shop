import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddToCartFavorite extends StatefulWidget {
  final VoidCallback onAddToCart;
  final VoidCallback onToggleFavorite;
  final bool isFavorited;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  const AddToCartFavorite({
    super.key,
    required this.onAddToCart,
    required this.onToggleFavorite,
    required this.isFavorited,
    this.quantity = 1,
    required this.onQuantityChanged,
  });

  @override
  State<AddToCartFavorite> createState() => _AddToCartFavoriteState();
}

class _AddToCartFavoriteState extends State<AddToCartFavorite> {
  static const Color accent = Color(0xFFC5A081);

  void _handleFavorite() {
    final willBeFavorited = !widget.isFavorited;
    widget.onToggleFavorite();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          willBeFavorited ? 'Added to favorites ❤' : 'Removed from favorites',
        ),
        backgroundColor: accent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleAddToCart() {
    widget.onAddToCart();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.quantity > 1
              ? 'Added ${widget.quantity} items to cart ✓'
              : 'Added to cart ✓',
        ),
        backgroundColor: accent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Quantity selector
        Row(
          children: [
            Text(
              'Quantity',
              style: GoogleFonts.comfortaa(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: accent.withOpacity(0.06),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (widget.quantity > 1) {
                        widget.onQuantityChanged(widget.quantity - 1);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: widget.quantity > 1
                            ? accent.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(14),
                          bottomLeft: Radius.circular(14),
                        ),
                      ),
                      child: Icon(
                        Icons.remove,
                        size: 18,
                        color: widget.quantity > 1
                            ? accent
                            : Colors.grey[300],
                      ),
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(minWidth: 40),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '${widget.quantity}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.comfortaa(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: accent,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.quantity < 99) {
                        widget.onQuantityChanged(widget.quantity + 1);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: accent.withOpacity(0.1),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(14),
                          bottomRight: Radius.circular(14),
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 18,
                        color: accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),

        // Add to cart + Favorite
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _handleAddToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  shadowColor: accent.withOpacity(0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_bag_outlined, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      widget.quantity > 1
                          ? 'Add ${widget.quantity} to Cart'
                          : 'Add to Cart',
                      style: GoogleFonts.comfortaa(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Favorite
            GestureDetector(
              onTap: _handleFavorite,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: widget.isFavorited
                      ? Colors.red.withOpacity(0.08)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: widget.isFavorited
                        ? Colors.red.withOpacity(0.2)
                        : Colors.grey[300]!,
                  ),
                ),
                child: Icon(
                  widget.isFavorited
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: widget.isFavorited
                      ? Colors.red
                      : Colors.grey[500],
                  size: 24,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Shipping info
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: accent.withOpacity(0.06),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.local_shipping_outlined,
                size: 18,
                color: accent,
              ),
              const SizedBox(width: 8),
              Text(
                'Free shipping on orders over \$100',
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}