import 'package:flutter/material.dart';

class AddToCartFavorite extends StatefulWidget {
  final VoidCallback onAddToCart;
  final VoidCallback onToggleFavorite;
  final bool isFavorited;
  final String price;

  const AddToCartFavorite({
    super.key,
    required this.onAddToCart,
    required this.onToggleFavorite,
    required this.isFavorited,
    required this.price,
  });

  @override
  State<AddToCartFavorite> createState() => _AddToCartFavoriteState();
}

class _AddToCartFavoriteState extends State<AddToCartFavorite> {
  late bool _isFavorited;

  @override
  void initState() {
    super.initState();
    _isFavorited = widget.isFavorited;
  }

  void _handleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
    widget.onToggleFavorite();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorited ? 'Added to favorites ❤' : 'Removed from favorites',
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
      SnackBar(
        content: const Text(
          'Added to cart ✓',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Price
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              widget.price,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '\$895',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey[500],
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Buttons
        Row(
          children: [
            // Add to Cart Button
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
            // Favorite Button
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
                      _isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorited ? Colors.red[400] : Colors.grey[600],
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Additional info
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
