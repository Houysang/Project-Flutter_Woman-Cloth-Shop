import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrendingSection extends StatefulWidget {
  final List<String> trendingImages;
  final List<String> productNames;
  final List<String> prices;

  const TrendingSection({
    super.key,
    required this.trendingImages,
    required this.productNames,
    required this.prices,
  });

  @override
  State<TrendingSection> createState() => _TrendingSectionState();
}

class _TrendingSectionState extends State<TrendingSection> {
  // track favorites + cart
  late List<bool> isFavorite;
  late List<bool> inCart;

  static const Color darkText = Colors.black87;
  static const Color accent = Colors.orange;

  @override
  void initState() {
    super.initState();
    isFavorite = List.generate(widget.trendingImages.length, (_) => false);
    inCart = List.generate(widget.trendingImages.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.trendingImages.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (_, i) {
          return Container(
            width: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IMAGE SECTION
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(22),
                        ),
                        child: Image.asset(
                          widget.trendingImages[i],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),

                      // gradient overlay
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(22),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.35),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),

                      // FAVORITE BUTTON ❤️
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isFavorite[i] = !isFavorite[i];
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(6),
                            child: Icon(
                              isFavorite[i]
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite[i] ? Colors.red : Colors.black87,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // TEXT SECTION
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productNames[i],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.comfortaa(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: darkText,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        widget.prices[i],
                        style: GoogleFonts.comfortaa(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: accent,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // ADD TO CART BUTTON 🛒
                      SizedBox(
                        width: double.infinity,
                        height: 32,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              inCart[i] = !inCart[i];
                            });
                          },
                          icon: Icon(
                            inCart[i]
                                ? Icons.check
                                : Icons.shopping_bag_outlined,
                            size: 16,
                          ),
                          label: Text(
                            inCart[i] ? "Added" : "Add",
                            style: const TextStyle(fontSize: 12),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                inCart[i] ? Colors.green : accent,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}