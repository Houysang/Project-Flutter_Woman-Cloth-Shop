import 'package:flutter/material.dart';

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
  void _handleFavorite() {
    final willBeFavorited = !widget.isFavorited;
    widget.onToggleFavorite();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          willBeFavorited ? 'Added to favorites ❤' : 'Removed from favorites',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleAddToCart() {
    widget.onAddToCart();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Added to cart ✓', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.brown,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Buttons
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _handleAddToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag_outlined, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _handleFavorite,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      widget.isFavorited
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: widget.isFavorited
                          ? Colors.red[400]
                          : Colors.grey[600],
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Shipping info
        Row(
          children: [
            Icon(
              Icons.local_shipping_outlined,
              size: 18,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 8),
            Text(
              'Free shipping on orders over \$100',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }
}
