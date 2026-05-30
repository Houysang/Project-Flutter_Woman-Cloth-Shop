import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/wishlist_store.dart';
import '../models/cart_store.dart';
import '../components/floating_cart_button.dart';
import '../components/app_footer.dart';

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
  int _selectedFooterIndex = 2;

  @override
  void initState() {
    super.initState();
    _items = widget.items.isNotEmpty
        ? List.of(widget.items)
        : List.of(wishlist);
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

  Future<void> _handleFooterTap(int index) async {
    setState(() {
      _selectedFooterIndex = index;
    });

    if (index == 0) {
      await Navigator.pushNamed(context, '/shop');
    } else if (index == 1) {
      await Navigator.pushNamed(context, '/bag');
    } else if (index == 2) {
      await Navigator.pushNamed(context, '/wishlist');
      setState(() {
        _items = List.of(wishlist);
      });
    } else if (index == 3) {
      await Navigator.pushNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          'Wishlist',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_items.length} item${_items.length == 1 ? '' : 's'} curated for your timeless wardrobe.',
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            if (_items.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    'Your wishlist is empty.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
              )
            else
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
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('ADD ALL TO BAG'),
                ),
              ),
            const SizedBox(height: 24),
            Expanded(
              child: _items.isEmpty
                  ? const SizedBox.shrink()
                  : ListView.separated(
                      itemCount: _items.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
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
            ),
          ],
        ),
      ),
      floatingActionButton: cart.isNotEmpty ? const FloatingCartButton() : null,
      bottomNavigationBar: AppFooter(
        currentIndex: _selectedFooterIndex,
        onTap: _handleFooterTap,
      ),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(158, 158, 158, 0.12),
            blurRadius: 18,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image area with title/tag overlay and heart
            Stack(
              children: [
                Image.asset(
                  image,
                  width: double.infinity,
                  height: 280,
                  fit: BoxFit.cover,
                ),

                Positioned(
                  left: 20,
                  bottom: 20,
                  right: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        color: Colors.black.withOpacity(0.3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tag.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Heart icon overlay (pale circular background, mauve heart)
                Positioned(
                  top: 16,
                  right: 16,
                  child: GestureDetector(
                    onTap: onRemove,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6EEF3),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  GestureDetector(
                    onTap: onQuickAdd,
                    child: Text(
                      'QUICK ADD +',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
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
