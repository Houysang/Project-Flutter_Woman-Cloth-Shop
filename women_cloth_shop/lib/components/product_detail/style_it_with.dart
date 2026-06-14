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
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  const Icon(Icons.diamond_outlined, size: 16, color: accent),
            ),
            const SizedBox(width: 10),
            Text(
              'Style It With',
              style: GoogleFonts.comfortaa(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: darkText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Text(
            'Complete the look with these items',
            style: GoogleFonts.comfortaa(
              fontSize: 11,
              color: Colors.black45,
            ),
          ),
        ),
        const SizedBox(height: 14),
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
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Stack(
                          children: [
                            _buildImage(item.image),
                            // Gradient overlay
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.4),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Tap hint
                            Positioned(
                              bottom: 8,
                              left: 0,
                              right: 0,
                              child: Text(
                                'Tap to view',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.comfortaa(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

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

                      // Rating
                      Row(
                        children: [
                          const Icon(Icons.star,
                              size: 12, color: Color(0xFFFFB800)),
                          const SizedBox(width: 4),
                          Text(
                            '${item.rating}',
                            style: GoogleFonts.comfortaa(
                              fontSize: 11,
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '(${item.reviewCount})',
                            style: GoogleFonts.comfortaa(
                              fontSize: 10,
                              color: Colors.black38,
                            ),
                          ),
                        ],
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
