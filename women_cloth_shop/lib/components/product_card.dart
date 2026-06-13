import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';
import '../models/wishlist_store.dart';
import '../models/cart_store.dart';
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
  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  bool get isFav => wishlist.any((w) => w.id == widget.product.id);

  bool get inCart => cart.any((c) => c.id == widget.product.id);

  void _toggleFavorite() {
    final willBeFav = !isFav;
    if (willBeFav) {
      final item = WishlistItem(
        id: widget.product.id,
        title: widget.product.name,
        price: widget.product.price,
        image: widget.product.coverImage,
        tag: 'Favorite',
      );
      addToWishlist(item);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Added to wishlist ❤'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      removeFromWishlistById(widget.product.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Removed from wishlist'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
        ),
      );
    }
    setState(() {});
  }

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
              color: Colors.black.withValues(alpha: 0.06),
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
                    onTap: _toggleFavorite,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isFav
                            ? Colors.red.withValues(alpha: 0.1)
                            : Colors.white,
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
                        onTap: () {
                          if (!inCart) {
                            final item = CartItem(
                              id: widget.product.id,
                              title: widget.product.name,
                              price: widget.product.price,
                              image: widget.product.coverImage,
                              color: 'Default',
                              size: 'M',
                            );
                            addToCart(item);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Added to cart ✓'),
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                          setState(() {});
                        },
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
