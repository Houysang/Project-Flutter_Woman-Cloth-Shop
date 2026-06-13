import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/related_item.dart';

class StyleItWithSection extends StatelessWidget {
  final List<RelatedItem> relatedItems;
  final Function(String itemId) onItemTap;

  const StyleItWithSection({
    super.key,
    required this.relatedItems,
    required this.onItemTap,
  });

  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  Widget _buildImage(String path) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 160,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[200],
            child: const Icon(Icons.image_not_supported),
          );
        },
      );
    } else {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 160,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (relatedItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TITLE
        Text(
          'Style It With',
          style: GoogleFonts.comfortaa(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: darkText,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          'Complete the look with curated pieces',
          style: GoogleFonts.comfortaa(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),

        const SizedBox(height: 12),

        // LIST
        SizedBox(
          height: 270,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: relatedItems.length,
            itemBuilder: (context, index) {
              final item = relatedItems[index];

              return GestureDetector(
                onTap: () => onItemTap(item.id),
                child: Container(
                  width: 155,
                  margin: EdgeInsets.only(
                    right: index == relatedItems.length - 1 ? 0 : 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // IMAGE CARD
                      Container(
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black12),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Stack(
                          children: [
                            _buildImage(item.image),

                            // OVERLAY
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.5),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                                child: Text(
                                  'Tap to view',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.comfortaa(
                                    color: Colors.white,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      // NAME
                      Text(
                        item.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.comfortaa(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: darkText,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // RATING
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 12,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${item.rating}',
                            style: GoogleFonts.comfortaa(
                              fontSize: 11,
                              color: darkText,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${item.reviewCount})',
                            style: GoogleFonts.comfortaa(
                              fontSize: 11,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      // PRICE
                      Text(
                        item.price,
                        style: GoogleFonts.comfortaa(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: accent,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
