import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';
import '../models/wishlist_store.dart';
import '../models/cart_store.dart';
import '../screens/product_detail_page.dart';

class TrendingSection extends StatelessWidget {
  final List<Product> products;

  const TrendingSection({
    super.key,
    required this.products,
  });

  static const Color darkText = Colors.black87;
  static const Color accent = Color(0xFFC5A081);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (_, i) {
          final p = products[i];
          return _TrendingCard(product: p);
        },
      ),
    );
  }
}

class _TrendingCard extends StatefulWidget {
  final Product product;

  const _TrendingCard({required this.product});

  @override
  State<_TrendingCard> createState() => _TrendingCardState();
}

class _TrendingCardState extends State<_TrendingCard> {
  static const Color darkText = Colors.black87;
  static const Color accent = Color(0xFFC5A081);

  bool get isFavorite => wishlist.any((w) => w.id == widget.product.id);
  bool get inCart => cart.any((c) => c.id == widget.product.id);

  void _toggleFavorite() {
    final willBeFav = !isFavorite;
    if (willBeFav) {
      final item = WishlistItem(
        id: widget.product.id,
        title: widget.product.name,
        price: widget.product.price,
        image: widget.product.image,
        tag: 'Favorite',
      );
      addToWishlist(item);
    } else {
      removeFromWishlistById(widget.product.id);
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
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(22),
                    ),
                    child: Image.asset(
                      p.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),

                  // gradient overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(22),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.35),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // FAVORITE
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: _toggleFavorite,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.black54,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // INFO
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    p.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.comfortaa(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: darkText,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Stars
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
                          size: 12,
                          color: const Color(0xFFFFB800),
                        );
                      }),
                      const SizedBox(width: 4),
                      Text(
                        '(${p.reviewCount})',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Price + Cart icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        p.price,
                        style: GoogleFonts.comfortaa(
                          fontSize: 14,
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
                              image: widget.product.image,
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
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: inCart ? Colors.green : accent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            inCart ? Icons.check : Icons.shopping_bag_outlined,
                            size: 16,
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
