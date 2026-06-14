import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/product_detail/image_gallery.dart';
import '../components/product_detail/add_to_cart_favorite.dart';
import '../components/product_detail/style_it_with.dart';
import '../components/product_detail/customer_reviews.dart';
import '../models/customer_review.dart';
import '../models/related_item.dart';
import '../components/glass_bottom_nav_widget.dart';

class LookCollectionData {
  final String title;
  final String image;
  final String subtitle;
  final String? tag;
  final int items;
  final List<LookPiece> pieces;
  final List<RelatedItem> relatedItems;

  const LookCollectionData({
    required this.title,
    required this.image,
    required this.subtitle,
    this.tag,
    required this.items,
    required this.pieces,
    required this.relatedItems,
  });
}

class LookPiece {
  final int number;
  final String imagePath;
  final String title;
  final String subtitle;

  const LookPiece({
    required this.number,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });
}

class LookbookDetailPage extends StatelessWidget {
  final String title;
  final String image;
  final String subtitle;
  final String? tag;
  final int items;
  final List<LookPiece> pieces;
  final List<RelatedItem> relatedItems;

  const LookbookDetailPage({
    super.key,
    required this.title,
    required this.image,
    required this.subtitle,
    this.tag,
    required this.items,
    required this.pieces,
    required this.relatedItems,
  });

  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);
  static const Color backgroundColor = Color(0xFFF9F7F2);

  static final List<LookPiece> _defaultPieces = [
    LookPiece(
      number: 1,
      imagePath: "assets/champagne_dress.png",
      title: "Champagne Muse",
      subtitle: "Satin Slip Dress",
    ),
    LookPiece(
      number: 2,
      imagePath: "assets/champagne_shoes.png",
      title: "Golden Stride",
      subtitle: "Quilted Handbag",
    ),
    LookPiece(
      number: 3,
      imagePath: "assets/champagne_bag.png",
      title: "Golden Charm",
      subtitle: "Champagne Handbag",
    ),
  ];

  static final List<RelatedItem> _defaultRelatedItems = [
    RelatedItem(
      id: 'look_1',
      image: 'assets/champagne_dress.png',
      name: 'Satin Slip Dress',
      price: '\$890',
      rating: 4.5,
      reviewCount: 28,
    ),
    RelatedItem(
      id: 'look_2',
      image: 'assets/champagne_shoes.png',
      name: 'Quilted Handbag',
      price: '\$520',
      rating: 4.0,
      reviewCount: 15,
    ),
  ];

  // ---- Collection-specific data ----

  static final List<LookPiece> _silkEditPieces = [
    LookPiece(
      number: 1,
      imagePath: "assets/champagne_dress.png",
      title: "Silk Blouse",
      subtitle: "Ivory Silk Top",
    ),
    LookPiece(
      number: 2,
      imagePath: "assets/champagne_shoes.png",
      title: "Ocean Satin",
      subtitle: "Blue Satin Skirt",
    ),
    LookPiece(
      number: 3,
      imagePath: "assets/champagne_bag.png",
      title: "Pearl Clutch",
      subtitle: "Evening Handbag",
    ),
  ];

  static final List<RelatedItem> _silkEditRelated = [
    RelatedItem(
      id: 'se_1',
      image: 'assets/silk_edit.png',
      name: 'Ivory Silk Top',
      price: '',
      rating: 4.7,
      reviewCount: 32,
    ),
    RelatedItem(
      id: 'se_2',
      image: 'assets/blue_dress.png',
      name: 'Blue Satin Skirt',
      price: '',
      rating: 4.3,
      reviewCount: 19,
    ),
  ];

  static final List<LookPiece> _modernTailoringPieces = [
    LookPiece(
      number: 1,
      imagePath: "assets/modern_tailoring.png",
      title: "Blazer Luxe",
      subtitle: "Tailored Wool Blazer",
    ),
    LookPiece(
      number: 2,
      imagePath: "assets/brown_dress.png",
      title: "Taupe Elegance",
      subtitle: "Straight-Leg Trousers",
    ),
  ];

  static final List<RelatedItem> _modernTailoringRelated = [
    RelatedItem(
      id: 'mt_1',
      image: 'assets/modern_tailoring.png',
      name: 'Tailored Wool Blazer',
      price: '\$650',
      rating: 4.8,
      reviewCount: 41,
    ),
    RelatedItem(
      id: 'mt_2',
      image: 'assets/brown_dress.png',
      name: 'Straight-Leg Trousers',
      price: '\$380',
      rating: 4.4,
      reviewCount: 23,
    ),
  ];

  static final List<LookPiece> _goldenHourPieces = [
    LookPiece(
      number: 1,
      imagePath: "assets/golden_hour.png",
      title: "Warm Glow",
      subtitle: "Champagne Top",
    ),
    LookPiece(
      number: 2,
      imagePath: "assets/champagne_dress.png",
      title: "Cocoon Coat",
      subtitle: "Wool Blend Coat",
    ),
    LookPiece(
      number: 3,
      imagePath: "assets/champagne_shoes.png",
      title: "Nude Pump",
      subtitle: "Leather Heels",
    ),
  ];

  static final List<RelatedItem> _goldenHourRelated = [
    RelatedItem(
      id: 'gh_1',
      image: 'assets/golden_hour.png',
      name: 'Champagne Top',
      price: '\$280',
      rating: 4.6,
      reviewCount: 37,
    ),
    RelatedItem(
      id: 'gh_2',
      image: 'assets/champagne_dress.png',
      name: 'Wool Blend Coat',
      price: '\$720',
      rating: 4.9,
      reviewCount: 52,
    ),
  ];

  static final List<LookPiece> _ephemeralLoversPieces = [
    LookPiece(
      number: 1,
      imagePath: "assets/ephemeral_lovers.png",
      title: "Lace Dream",
      subtitle: "Lace Bodysuit",
    ),
    LookPiece(
      number: 2,
      imagePath: "assets/blue_dress.png",
      title: "Tulle Skirt",
      subtitle: "Layered Tulle",
    ),
  ];

  static final List<RelatedItem> _ephemeralLoversRelated = [
    RelatedItem(
      id: 'el_1',
      image: 'assets/ephemeral_lovers.png',
      name: 'Lace Bodysuit',
      price: '\$260',
      rating: 4.5,
      reviewCount: 29,
    ),
    RelatedItem(
      id: 'el_2',
      image: 'assets/blue_dress.png',
      name: 'Layered Tulle Skirt',
      price: '\$490',
      rating: 4.2,
      reviewCount: 18,
    ),
  ];

  static LookCollectionData collectionFor(String title) {
    switch (title) {
      case 'The Silk Edit':
        return LookCollectionData(
          title: 'The Silk Edit',
          image: 'assets/silk_edit.png',
          subtitle: 'Luxurious silk essentials for the modern wardrobe',
          tag: 'New',
          items: 12,
          pieces: _silkEditPieces,
          relatedItems: _silkEditRelated,
        );
      case 'Modern Tailoring':
        return LookCollectionData(
          title: 'Modern Tailoring',
          image: 'assets/modern_tailoring.png',
          subtitle: 'Sharp silhouettes meet soft femininity',
          tag: null,
          items: 8,
          pieces: _modernTailoringPieces,
          relatedItems: _modernTailoringRelated,
        );
      case 'Golden Hour Ease':
        return LookCollectionData(
          title: 'Golden Hour Ease',
          image: 'assets/golden_hour.png',
          subtitle: 'Warm tones and effortless sophistication',
          tag: null,
          items: 10,
          pieces: _goldenHourPieces,
          relatedItems: _goldenHourRelated,
        );
      case 'Ephemeral Lovers':
        return LookCollectionData(
          title: 'Ephemeral Lovers',
          image: 'assets/ephemeral_lovers.png',
          subtitle: 'Romantic layers and delicate textures',
          tag: 'Trending',
          items: 6,
          pieces: _ephemeralLoversPieces,
          relatedItems: _ephemeralLoversRelated,
        );
      default:
        return LookCollectionData(
          title: title,
          image: 'assets/champagne_dress.png',
          subtitle: 'Curated collection',
          tag: null,
          items: 3,
          pieces: _defaultPieces,
          relatedItems: _defaultRelatedItems,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
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
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 18, color: darkText),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ImageGallery(
                images: [image],
              ),
            ),
            const SizedBox(height: 8),

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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.comfortaa(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: darkText,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                ...List.generate(5, (i) {
                                  return Icon(
                                    Icons.star,
                                    size: 16,
                                    color: const Color(0xFFFFB800),
                                  );
                                }),
                                const SizedBox(width: 6),
                                Text(
                                  '$items pieces',
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
                      if (tag != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: accent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            tag!,
                            style: GoogleFonts.comfortaa(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: accent,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Text(
                    subtitle,
                    style: GoogleFonts.comfortaa(
                      fontSize: 13,
                      color: const Color(0xFF6E655B),
                      height: 1.7,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Collection Details',
                          style: GoogleFonts.comfortaa(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: darkText,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _detailRow('Style', 'Curated modern elegance'),
                        const Divider(height: 20, color: Colors.black12),
                        _detailRow('Season', 'Spring / Summer 2025'),
                        const Divider(height: 20, color: Colors.black12),
                        _detailRow('Pieces', '$items items'),
                        const Divider(height: 20, color: Colors.black12),
                        _detailRow('Stylist', 'Evelyn Vane'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  ...pieces.map((piece) => Column(
                    children: [
                      _buildLookCard(
                        context,
                        number: piece.number,
                        imagePath: piece.imagePath,
                        title: piece.title,
                        items: piece.subtitle,
                      ),
                      const SizedBox(height: 16),
                    ],
                  )),

                  AddToCartFavorite(
                    isFavorited: false,
                    quantity: 1,
                    onQuantityChanged: (q) {},
                    onAddToCart: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("$title collection added to cart"),
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    onToggleFavorite: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("$title saved to favorites"),
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  CustomerReviews(
                    reviews: [
                      CustomerReview(
                        customerName: "Sophie Laurent",
                        profileImage: "",
                        feedback:
                            "Absolutely stunning collection! The quality of each piece is remarkable.",
                        rating: 5,
                      ),
                      CustomerReview(
                        customerName: "Emma Chen",
                        profileImage: "",
                        feedback:
                            "Beautifully curated. Perfect for the modern wardrobe.",
                        rating: 4,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  StyleItWithSection(
                    relatedItems: relatedItems,
                    onItemTap: (id) {
                      Navigator.pushNamed(context, '/outfit-builder');
                    },
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

  Widget _detailRow(String label, String value) {
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

  Widget _buildLookCard(
    BuildContext context, {
    required int number,
    required String imagePath,
    required String title,
    required String items,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF5D4E37),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                "$number",
                style: GoogleFonts.comfortaa(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: 72,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.comfortaa(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  items,
                  style: GoogleFonts.comfortaa(
                    fontSize: 12,
                    color: const Color(0xFF6E655B),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/outfit-builder');
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: accent),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      "View Outfit",
                      style: GoogleFonts.comfortaa(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: accent,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}