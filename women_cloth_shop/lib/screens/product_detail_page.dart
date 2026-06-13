import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/product_detail/image_gallery.dart';
import '../components/product_detail/color_swatches.dart';
import '../components/product_detail/size_selector.dart';
import '../components/product_detail/model_info_note.dart';
import '../components/product_detail/add_to_cart_favorite.dart';
import '../components/product_detail/style_it_with.dart';
import '../components/product_detail/customer_reviews.dart';
import '../models/customer_review.dart';
import '../components/glass_bottom_nav_widget.dart';
import '../components/floating_cart_button.dart';
import '../models/wishlist_store.dart';
import '../models/cart_store.dart';
import '../models/related_item.dart';
import '../data/product_catalog.dart';

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
  int _quantity = 1;

  static const Color backgroundColor = Color(0xFFF9F7F2);
  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  Map<String, dynamic> get productData =>
      ProductCatalog.getById(widget.productId);

  @override
  void initState() {
    super.initState();
    final colors = List<Map<String, String>>.from(productData['colors']);
    final sizes = List<String>.from(productData['sizes']);
    _selectedSize = sizes.contains('M') ? 'M' : sizes.first;
    _selectedColor = colors.first['name']!;
    _isFavorited = wishlist.any((w) => w.id == widget.productId);
  }

  void _handleQuantityChanged(int newQuantity) {
    setState(() {
      _quantity = newQuantity;
    });
  }

  Future<void> _handleAddToCart() async {
    final item = CartItem(
      id: widget.productId,
      title: productData['name'],
      price: productData['price'],
      image: productData['images'][0],
      quantity: _quantity,
    );

    addToCart(item);
    _quantity = 1;
    setState(() {});
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

      addToWishlist(item);

      await Navigator.pushNamed(context, '/wishlist');

      setState(() {
        _isFavorited = wishlist.any((w) => w.id == widget.productId);
      });
    } else {
      removeFromWishlistById(widget.productId);
      setState(() {
        _isFavorited = false;
      });
    }
  }

  void _handleRelatedItemTap(String itemId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailPage(productId: itemId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = productData;

    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton:
          cart.isNotEmpty ? const FloatingCartButton() : null,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: darkText),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.share_outlined, size: 20, color: darkText),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image gallery
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ImageGallery(
                images: List<String>.from(product['images']),
              ),
            ),
            const SizedBox(height: 8),

            // Product info section
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Price row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
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
                            // Rating
                            Row(
                              children: [
                                ...List.generate(5, (i) {
                                  final rating = (product['rating'] as num).toDouble();
                                  return Icon(
                                    i + 1 <= rating.round()
                                        ? Icons.star
                                        : i + 0.5 <= rating
                                            ? Icons.star_half
                                            : Icons.star_border,
                                    size: 16,
                                    color: const Color(0xFFFFB800),
                                  );
                                }),
                                const SizedBox(width: 6),
                                Text(
                                  '${product['rating']} (${product['reviews']} reviews)',
                                  style: GoogleFonts.comfortaa(
                                    fontSize: 12,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            product['price'],
                            style: GoogleFonts.comfortaa(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: accent,
                            ),
                          ),
                          if (product['oldPrice'] != null)
                            Text(
                              product['oldPrice'],
                              style: GoogleFonts.comfortaa(
                                fontSize: 14,
                                color: Colors.grey[400],
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Color
                  ColorSwatches(
                    colors: List<Map<String, String>>.from(product['colors']),
                    selectedColor: _selectedColor,
                    onColorSelected: (color) {
                      setState(() {
                        _selectedColor = color;
                      });
                    },
                  ),

                  const SizedBox(height: 22),

                  // Size
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

                  // Model info
                  ModelInfoNote(
                    modelHeight: product['modelHeight'],
                    modelSize: product['modelSize'],
                  ),

                  const SizedBox(height: 24),


                  // Product details
                  _buildDetailsSection(),

                  const SizedBox(height: 28),

                  // Add to cart + Favorite
                  AddToCartFavorite(
                    isFavorited: _isFavorited,
                    quantity: _quantity,
                    onQuantityChanged: _handleQuantityChanged,
                    onAddToCart: _handleAddToCart,
                    onToggleFavorite: _handleToggleFavorite,
                  ),

                  const SizedBox(height: 24),

                                    // Customer Reviews
                  CustomerReviews(
                    reviews: List<CustomerReview>.from(
                        product['customerReviews']),
                  ),

                  const SizedBox(height: 20),

                  // Style it with
                  StyleItWithSection(
                    relatedItems:
                        List<RelatedItem>.from(product['relatedItems']),
                    onItemTap: _handleRelatedItemTap,
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const GlassBottomNavWidget(),
    );
  }

  Widget _buildDetailsSection() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Details',
            style: GoogleFonts.comfortaa(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: darkText,
            ),
          ),
          const SizedBox(height: 12),
          _buildDetailRow('Material', productData['material']),
          const Divider(height: 20, color: Colors.black12),
          _buildDetailRow('Care', productData['care']),
          const Divider(height: 20, color: Colors.black12),
          _buildDetailRow('Origin', productData['origin']),
          const Divider(height: 20, color: Colors.black12),
          _buildDetailRow('Lining', productData['lining']),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.comfortaa(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.comfortaa(
            fontSize: 12,
            color: darkText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}