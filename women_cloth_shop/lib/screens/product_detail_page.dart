import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/navigation_bar_widget.dart';

import '../components/product_detail/image_gallery.dart';
import '../components/product_detail/color_swatches.dart';
import '../components/product_detail/size_selector.dart';
import '../components/product_detail/model_info_note.dart';
import '../components/product_detail/add_to_cart_favorite.dart';
import '../components/product_detail/style_it_with.dart';

import '../components/app_footer.dart';
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

  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  @override
  void initState() {
    super.initState();
    _selectedSize = 'M';
    _selectedColor = 'Beige';
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

  @override
  Widget build(BuildContext context) {
    final product = productData;

    return Scaffold(
      floatingActionButton: cart.isNotEmpty ? const FloatingCartButton() : null,
      backgroundColor: const Color.fromARGB(255, 215, 203, 191),

      // ❌ NO AppBar (we replace it with your custom header)

      body: SafeArea(
        child: Column(
          children: [
            // ✅ YOUR HEADER (HOME PAGE STYLE)
            const NavigationBarWidget(),

            // CONTENT
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      // IMAGE GALLERY
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: ImageGallery(
                          images: List<String>.from(product['images']),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // PRODUCT HEADER
                      _buildProductHeader(product),

                      const SizedBox(height: 16),

                      // COLORS
                      ColorSwatches(
                        colors:
                            List<Map<String, String>>.from(product['colors']),
                        selectedColor: _selectedColor,
                        onColorSelected: (color) {
                          setState(() => _selectedColor = color);
                        },
                      ),

                      const SizedBox(height: 20),

                      // SIZES
                      SizeSelector(
                        sizes: List<String>.from(product['sizes']),
                        selectedSize: _selectedSize,
                        onSizeSelected: (size) {
                          setState(() => _selectedSize = size);
                        },
                      ),

                      const SizedBox(height: 16),

                      // MODEL INFO
                      ModelInfoNote(
                        modelHeight: product['modelHeight'],
                        modelSize: product['modelSize'],
                      ),

                      const SizedBox(height: 20),

                      // ACTIONS
                      AddToCartFavorite(
                        isFavorited: _isFavorited,
                        onAddToCart: _handleAddToCart,
                        onToggleFavorite: _handleToggleFavorite,
                      ),

                      const SizedBox(height: 20),

                      // RELATED ITEMS
                      StyleItWithSection(
                        relatedItems:
                            List<RelatedItem>.from(product['relatedItems']),
                        onItemTap: _handleRelatedItemTap,
                      ),

                      const SizedBox(height: 12),

                      // DETAILS
                      _buildAdditionalSection(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: AppFooter(
        currentIndex: _selectedFooterIndex,
        onTap: _handleFooterTap,
      ),
    );
  }

  // ---------------- PRODUCT HEADER ----------------
  Widget _buildProductHeader(Map product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product['name'],
          style: GoogleFonts.comfortaa(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: darkText,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          product['price'],
          style: GoogleFonts.comfortaa(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
      ],
    );
  }

  // ---------------- DETAILS ----------------
  Widget _buildAdditionalSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 215, 203, 191),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Details',
            style: GoogleFonts.comfortaa(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),
          const SizedBox(height: 10),
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
          Text(
            label,
            style: GoogleFonts.comfortaa(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.comfortaa(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: darkText,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- ACTIONS ----------------
  Future<void> _handleAddToCart() async {
    final item = CartItem(
      id: widget.productId,
      title: productData['name'],
      price: productData['price'],
      image: productData['images'][0],
      color: _selectedColor,
      size: _selectedSize,
    );

    addToCart(item);

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${productData['name']} ($_selectedColor, $_selectedSize) added to cart',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _handleToggleFavorite() async {
    setState(() {
      _isFavorited = !_isFavorited;
    });

    if (_isFavorited) {
      addToWishlist(WishlistItem(
        id: widget.productId,
        title: productData['name'],
        price: productData['price'],
        image: productData['images'][0],
        tag: 'Favorite',
      ));
    } else {
      removeFromWishlistById(widget.productId);
    }
  }

  void _handleRelatedItemTap(String itemId) {
    Navigator.pushNamed(context, '/profileuser');
  }

  Future<void> _handleFooterTap(int index) async {
    setState(() => _selectedFooterIndex = index);
    await AppFooter.navigateTo(context, index);
  }
}
