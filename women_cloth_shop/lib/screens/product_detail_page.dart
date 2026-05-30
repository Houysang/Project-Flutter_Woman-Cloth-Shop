import 'package:flutter/material.dart';
import '../components/image_gallery.dart';
import '../components/color_swatches.dart';
import '../components/size_selector.dart';
import '../components/model_info_note.dart';
import '../components/add_to_cart_favorite.dart';
import '../components/style_it_with.dart';

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

  @override
  void initState() {
    super.initState();
    _selectedSize = 'M';
    _selectedColor = 'Beige';
    _isFavorited = false;
  }

  // Sample product data - replace with real data from API
  Map<String, dynamic> get productData => {
    'id': widget.productId,
    'name': 'Minimalist Beige Wool Coat',
    'price': '\$895',
    'rating': 4.8,
    'reviews': 124,
    'description':
        'A masterpiece of understated luxury. This minimalist beige wool coat '
        'is crafted from premium Italian wool, offering exceptional warmth and '
        'timeless elegance. Perfect for layering or wearing alone.',
    'images': [
      'https://images.unsplash.com/photo-1539533057687-c8a0dbd94f11?w=500&h=600&fit=crop',
      'https://images.unsplash.com/photo-1539533057687-c8a0dbd94f11?w=500&h=600&fit=crop',
      'https://images.unsplash.com/photo-1539533057687-c8a0dbd94f11?w=500&h=600&fit=crop',
      'https://images.unsplash.com/photo-1539533057687-c8a0dbd94f11?w=500&h=600&fit=crop',
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
        name: 'Petite Leather Chain',
        price: '\$125',
        image:
            'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?w=200&h=200&fit=crop',
        rating: 4.9,
        reviewCount: 89,
      ),
      RelatedItem(
        id: '2',
        name: 'Tailored Trousers',
        price: '\$245',
        image:
            'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=200&h=200&fit=crop',
        rating: 4.7,
        reviewCount: 156,
      ),
      RelatedItem(
        id: '3',
        name: 'Premium Leather Gloves',
        price: '\$85',
        image:
            'https://images.unsplash.com/photo-1584917865735-c3185c4d3198?w=200&h=200&fit=crop',
        rating: 4.8,
        reviewCount: 203,
      ),
      RelatedItem(
        id: '4',
        name: 'Silk Scarves Assortment',
        price: '\$155',
        image:
            'https://images.unsplash.com/photo-1562861209-4d5d40e8d923?w=200&h=200&fit=crop',
        rating: 4.6,
        reviewCount: 94,
      ),
    ],
  };

  void _handleAddToCart() {
    // Implement cart logic
    print('Added to cart: Size=$_selectedSize, Color=$_selectedColor');
  }

  void _handleToggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
    // Implement favorite logic
    print('Favorite toggled: $_isFavorited');
  }

  void _handleRelatedItemTap(String itemId) {
    print('Related item tapped: $itemId');
    // Navigate to related product detail page
  }

  @override
  Widget build(BuildContext context) {
    final product = productData;

    return Scaffold(
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
            onPressed: () {
              // Share functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // More options menu
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Gallery
            Padding(
              padding: const EdgeInsets.all(16),
              child: ImageGallery(images: List<String>.from(product['images'])),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Header (Name, Rating, Price)
                  _buildProductHeader(product),
                  const SizedBox(height: 20),

                  // Description
                  Text(
                    product['description'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),

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
                  const SizedBox(height: 24),

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
                  const SizedBox(height: 20),

                  // Model Info Note
                  ModelInfoNote(
                    modelHeight: product['modelHeight'],
                    modelSize: product['modelSize'],
                  ),
                  const SizedBox(height: 24),

                  // Add to Cart & Favorite
                  AddToCartFavorite(
                    price: product['price'],
                    isFavorited: _isFavorited,
                    onAddToCart: _handleAddToCart,
                    onToggleFavorite: _handleToggleFavorite,
                  ),
                  const SizedBox(height: 32),

                  // Style It With Section
                  StyleItWithSection(
                    relatedItems: List<RelatedItem>.from(
                      product['relatedItems'],
                    ),
                    onItemTap: _handleRelatedItemTap,
                  ),
                  const SizedBox(height: 32),

                  // Additional Details / Reviews Section Placeholder
                  _buildAdditionalSection(),
                ],
              ),
            ),
          ],
        ),
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
        const SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.star_rate_rounded, size: 18, color: Colors.amber[600]),
            const SizedBox(width: 4),
            Text(
              '${product['rating']}',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 4),
            Text(
              '(${product['reviews']} reviews)',
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAdditionalSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Product Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
