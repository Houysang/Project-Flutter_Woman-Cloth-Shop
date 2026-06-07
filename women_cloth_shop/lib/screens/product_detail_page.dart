import 'package:flutter/material.dart';
import '../components/product_detail/image_gallery.dart';
import '../components/product_detail/color_swatches.dart';
import '../components/product_detail/size_selector.dart';
import '../components/product_detail/model_info_note.dart';
import '../components/product_detail/add_to_cart_favorite.dart';
import '../components/product_detail/style_it_with.dart';
import '../components/app_footer.dart'; // <-- import your shared footer
import '../components/floating_cart_button.dart';
import '../models/wishlist_store.dart';
import '../models/cart_store.dart';
import '../models/related_item.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late String _selectedSize;
  late String _selectedColor;
  late bool _isFavorited;
  int _selectedFooterIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedSize = 'M';
    _selectedColor = 'Beige';
    // Initialize from shared wishlist so state matches other screens.
    _isFavorited = wishlist.any((w) => w.id == widget.productId);
  }

  Map<String, dynamic> get productData => {
        'id': widget.productId,
        'name': 'Beige Wool Coat',
        'price': '\$895',
        'oldPrice': '\$995',
        'rating': 4.8,
        'reviews': 124,
        'images': [
          'assets/images/coat.png',
          'assets/images/coat1.png',
          'assets/images/coat2.png',
        ],
        'colors': [
          {'name': 'Beige', 'hex': '#D4C5B9'},
          {'name': 'Black', 'hex': '#1A1A1A'},
          {'name': 'Brown', 'hex': '#6F4E3E'},
          {'name': 'Cream', 'hex': '#F5F1ED'},
        ],
        'sizes': ['XS', 'S', 'M', 'L', 'XL'],
        'modelHeight': "5'8\"",
        'modelSize': 'M',
        'relatedItems': [
          RelatedItem(
            id: '1',
            name: 'Petite Gold Link Chain',
            price: '\$125',
            image: 'assets/images/style1.png',
            rating: 4.9,
            reviewCount: 89,
          ),
          RelatedItem(
            id: '2',
            name: 'Minimalist Leather Clutch',
            price: '\$245',
            image: 'assets/images/style2.png',
            rating: 4.7,
            reviewCount: 156,
          ),
          RelatedItem(
            id: '3',
            name: 'Minimalist Strapped Sandal',
            price: '\$200',
            image: 'assets/images/style3.png',
            rating: 4.7,
            reviewCount: 156,
          ),
        ],
      };

  Future<void> _handleAddToCart() async {
    final item = CartItem(
      id: widget.productId,
      title: productData['name'],
      price: productData['price'],
      image: productData['images'][0],
    );

    addToCart(item);
    setState(() {});
    print('Added to cart: Size=$_selectedSize, Color=$_selectedColor');
  }

  Future<void> _handleToggleFavorite() async {
    setState(() {
      _isFavorited = !_isFavorited;
    });

    if (_isFavorited) {
      final item = WishlistItem(
        id: widget.productId,
        title: productData['name'],
        price: productData['price'],
        image: productData['images'][0],
        tag: 'Favorite',
      );

      // Persist to the shared in-memory wishlist so the footer route shows it.
      addToWishlist(item);

      // Navigate to wishlist and wait so we can refresh local state on return.
      await Navigator.pushNamed(context, '/wishlist');

      setState(() {
        _isFavorited = wishlist.any((w) => w.id == widget.productId);
      });
    } else {
      // If user unfavorited the product, remove it from shared wishlist.
      removeFromWishlistById(widget.productId);
      setState(() {
        _isFavorited = false;
      });
    }
  }

  void _handleRelatedItemTap(String itemId) {
    Navigator.pushNamed(context, '/category');
  }

  Future<void> _handleFooterTap(int index) async {
    setState(() {
      _selectedFooterIndex = index;
    });

    await AppFooter.navigateTo(context, index);

    if (index == 2) {
      setState(() {
        _isFavorited = wishlist.any((w) => w.id == widget.productId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = productData;

    return Scaffold(
      floatingActionButton: cart.isNotEmpty ? const FloatingCartButton() : null,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Gallery
              Padding(
                padding: const EdgeInsets.all(12),
                child: ImageGallery(
                  images: List<String>.from(product['images']),
                ),
              ),

              // Name, Price, Rating
              _buildProductHeader(product),
              const SizedBox(height: 16),

              // Color Swatches
              ColorSwatches(
                colors: List<Map<String, String>>.from(product['colors']),
                selectedColor: _selectedColor,
                onColorSelected: (color) {
                  setState(() {
                    _selectedColor = color;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Size Selector
              SizeSelector(
                sizes: List<String>.from(product['sizes']),
                selectedSize: _selectedSize,
                onSizeSelected: (size) {
                  setState(() {
                    _selectedSize = size;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Model Info
              ModelInfoNote(
                modelHeight: product['modelHeight'],
                modelSize: product['modelSize'],
              ),
              const SizedBox(height: 20),

              // Add to Cart + Favorite
              AddToCartFavorite(
                isFavorited: _isFavorited,
                onAddToCart: _handleAddToCart,
                onToggleFavorite: _handleToggleFavorite,
              ),
              const SizedBox(height: 20),

              // Style It With
              StyleItWithSection(
                relatedItems: List<RelatedItem>.from(product['relatedItems']),
                onItemTap: _handleRelatedItemTap,
              ),
              const SizedBox(height: 12),

              // Product Details
              _buildAdditionalSection(),
            ],
          ),
        ),
      ),

      // ✅ Shared footer
      bottomNavigationBar: AppFooter(
        currentIndex: _selectedFooterIndex,
        onTap: _handleFooterTap,
      ),
    );
  }

  Widget _buildProductHeader(Map<String, dynamic> product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product['name'],
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  product['price'],
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 100, 49, 2),
                  ),
                ),
                if (product['oldPrice'] != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    product['oldPrice'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[500],
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.star_rate_rounded,
                  size: 18,
                  color: Colors.amber[600],
                ),
                const SizedBox(width: 4),
                Text(
                  '${product['rating']}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '(${product['reviews']} reviews)',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAdditionalSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Product Details',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          _buildDetailRow('Material', 'Premium Italian Wool'),
          _buildDetailRow('Care', 'Dry clean recommended'),
          _buildDetailRow('Origin', 'Made in Italy'),
          _buildDetailRow('Lining', 'Silk'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
