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

class _WishlistPageState extends State<WishlistPage> {
  late List<WishlistItem> _items;

  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);
  static const Color bgLight = Color(0xFFF9F7F2);
  static const Color softPink = Color(0xFFFFE8E0);
  static const Color mutedPink = Color(0xFFFFD6CC);

  @override
  void initState() {
    super.initState();
    _items =
        widget.items.isNotEmpty ? List.of(widget.items) : List.of(wishlist);
  }

  void _removeItem(String id) {
    setState(() {
      _items.removeWhere((w) => w.id == id);
    });
    removeFromWishlistById(id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Removed from wishlist 💔'),
        backgroundColor: accent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        duration: const Duration(seconds: 2),
      ),
    );

    if (id == widget.currentProductId) {
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
        content: Text('${item.title} added to bag 🛍'),
        backgroundColor: accent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLight,
      appBar: AppBar(
        backgroundColor: bgLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.favorite, color: accent, size: 20),
            const SizedBox(width: 8),
            Text(
              'My Favorites',
              style: GoogleFonts.comfortaa(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: darkText,
              ),
            ),
          ],
        ),
      ),
      body: _items.isEmpty ? _buildEmptyState() : _buildContent(),
      floatingActionButton: cart.isNotEmpty ? const FloatingCartButton() : null,
      bottomNavigationBar: const GlassBottomNavWidget(selectedIndex: 1),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  softPink,
                  mutedPink.withOpacity(0.5),
                ],
              ),
            ),
            child: Center(
              child: Icon(
                Icons.favorite_border,
                size: 40,
                color: accent.withOpacity(0.6),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Your wishlist is empty',
            style: GoogleFonts.comfortaa(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: darkText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the heart icon to save your\nfavorite items ✨',
            textAlign: TextAlign.center,
            style: GoogleFonts.comfortaa(
              fontSize: 13,
              color: Colors.black45,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        // Count header
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_items.length} saved',
                  style: GoogleFonts.comfortaa(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: accent,
                  ),
                ),
              ),
              const Spacer(),
              // Add all button as a small rounded button
              GestureDetector(
                onTap: () {
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
                        'Added ${_items.length} item${_items.length == 1 ? '' : 's'} to bag 🛍',
                      ),
                      backgroundColor: accent,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.shopping_bag_outlined,
                          size: 14, color: Colors.white),
                      const SizedBox(width: 6),
                      Text(
                        'Add All',
                        style: GoogleFonts.comfortaa(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Grid of items
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.65,
              ),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return _CompactWishlistCard(
                  title: item.title,
                  price: item.price,
                  image: item.image,
                  onRemove: () => _removeItem(item.id),
                  onQuickAdd: () => _handleQuickAdd(item),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// ── Compact Card Widget ──

class _CompactWishlistCard extends StatelessWidget {
  final String title;
  final String price;
  final String image;
  final VoidCallback onRemove;
  final VoidCallback onQuickAdd;

  const _CompactWishlistCard({
    required this.title,
    required this.price,
    required this.image,
    required this.onRemove,
    required this.onQuickAdd,
  });

  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image area
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.asset(
                    image,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // Heart remove button
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onRemove,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.92),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Color(0xFFE07A7A),
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Info section
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.comfortaa(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: darkText,
                  ),
                ),
                const SizedBox(height: 6),

                // Price + Add row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: GoogleFonts.comfortaa(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    GestureDetector(
                      onTap: onQuickAdd,
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: accent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          size: 16,
                          color: accent,
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
    );
  }
}