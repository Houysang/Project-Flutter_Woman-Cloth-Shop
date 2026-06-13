import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/wishlist_store.dart';
import '../models/cart_store.dart';
import '../components/floating_cart_button.dart';
import '../components/glass_bottom_nav_widget.dart';

class WishlistPage extends StatefulWidget {
  final List<WishlistItem> items;
  final String currentProductId;

  const WishlistPage({
    super.key,
    required this.items,
    required this.currentProductId,
  });

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage>
    with SingleTickerProviderStateMixin {
  late List<WishlistItem> _items;
  int _selectedFooterIndex = 2;
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);
  static const Color bgLight = Color(0xFFF9F7F2);

  @override
  void initState() {
    super.initState();
    _items =
        widget.items.isNotEmpty ? List.of(widget.items) : List.of(wishlist);

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  void _removeItem(int index) {
    final removedItem = _items.removeAt(index);
    wishlist.removeWhere((w) => w.id == removedItem.id);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removedItem.title} removed from wishlist'),
        duration: const Duration(seconds: 2),
      ),
    );
    if (removedItem.id == widget.currentProductId) {
      Navigator.pop(context, false);
    }
  }

  void _handleQuickAdd(WishlistItem item) {
    final cartItem = CartItem(
      id: item.id,
      title: item.title,
      price: item.price,
      image: item.image,
      color: 'Default',
      size: 'M',
    );

    addToCart(cartItem);
    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.title} added to bag'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildAmbientCircle(
      double size, Color color, double? left, double? top) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.12),
        ),
      ),
    );
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
          'Wishlist',
          style: GoogleFonts.comfortaa(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: darkText,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Ambient abstract circles
          _buildAmbientCircle(220, accent, -80, -40),
          _buildAmbientCircle(160, const Color(0xFFE8D5C4), null, 360),
          _buildAmbientCircle(100, const Color(0xFFD4B8A0), 280, 700),

          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Item count with decorative bar
                Row(
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
                      '${_items.length} item${_items.length == 1 ? '' : 's'} curated',
                      style: GoogleFonts.comfortaa(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                if (_items.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 80),
                    child: Center(
                      child: Column(
                        children: [
                          AnimatedBuilder(
                            animation: _floatAnimation,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, _floatAnimation.value),
                                child: child,
                              );
                            },
                            child: Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: accent.withValues(alpha: 0.08),
                                border: Border.all(
                                  color: accent.withValues(alpha: 0.15),
                                  width: 1.5,
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 32,
                                  color: accent,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Your wishlist is empty',
                            style: GoogleFonts.comfortaa(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: darkText,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Save your favorite pieces here',
                            style: GoogleFonts.comfortaa(
                              fontSize: 13,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Column(
                    children: [
                      // ADD ALL TO BAG
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            for (final item in _items) {
                              final cartItem = CartItem(
                                id: item.id,
                                title: item.title,
                                price: item.price,
                                image: item.image,
                                color: 'Default',
                                size: 'M',
                              );
                              addToCart(cartItem);
                            }

                            setState(() {});

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Added ${_items.length} item${_items.length == 1 ? '' : 's'} to bag',
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accent,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shadowColor: accent.withValues(alpha: 0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            'ADD ALL TO BAG',
                            style: GoogleFonts.comfortaa(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Wishlist items
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _items.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemBuilder: (context, index) {
                          final item = _items[index];
                          return WishlistCard(
                            title: item.title,
                            price: item.price,
                            tag: item.tag,
                            image: item.image,
                            onRemove: () => _removeItem(index),
                            onQuickAdd: () => _handleQuickAdd(item),
                          );
                        },
                      ),
                    ],
                  ),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: cart.isNotEmpty ? const FloatingCartButton() : null,
      bottomNavigationBar: const GlassBottomNavWidget(),
    );
  }
}

// ----------------
// Card widget
// ----------------

class WishlistCard extends StatelessWidget {
  final String title;
  final String price;
  final String tag;
  final String image;
  final VoidCallback onRemove;
  final VoidCallback onQuickAdd;

  const WishlistCard({
    super.key,
    required this.title,
    required this.price,
    required this.tag,
    required this.image,
    required this.onRemove,
    required this.onQuickAdd,
  });

  static const Color accent = Color(0xFFC5A081);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image area with title/tag overlay and heart
            Stack(
              children: [
                Image.asset(
                  image,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),

                // Subtle gradient overlay at bottom
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.5),
                          Colors.transparent,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 16,
                  bottom: 16,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tag.toUpperCase(),
                        style: GoogleFonts.comfortaa(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.white60,
                          letterSpacing: 1.8,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        style: GoogleFonts.comfortaa(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),

                // Heart icon overlay
                Positioned(
                  top: 16,
                  right: 16,
                  child: GestureDetector(
                    onTap: onRemove,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Color(0xFF6D4960),
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Bottom bar with price and quick add
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price',
                        style: GoogleFonts.comfortaa(
                          fontSize: 10,
                          color: Colors.black38,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        price,
                        style: GoogleFonts.comfortaa(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: accent,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: onQuickAdd,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.shopping_bag_outlined,
                            size: 14,
                            color: accent,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'ADD',
                            style: GoogleFonts.comfortaa(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: accent,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
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
