import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/map_page.dart';

/// A compact Boutique Map preview section for the home page.
/// Shows a small map with markers and a "View Full Map" button.
class BoutiqueMapSection extends StatelessWidget {
  const BoutiqueMapSection({super.key});

  static const Color primaryBrown = Color(0xFF5D4E37);
  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);
  static const Color mutedText = Color(0xFF7C7569);

  // Phnom Penh center
  static const LatLng _center = LatLng(11.5564, 104.9282);

  // A subset of boutiques from MapPage for the preview
  static const List<_BoutiquePreview> _boutiques = [
    _BoutiquePreview(
      name: 'Neary Woman Fashion - 5th Avenue',
      position: LatLng(11.5830, 104.8850),
      accentColor: Color(0xFFB67D40),
    ),
    _BoutiquePreview(
      name: 'Neary Woman Fashion - Toul Kork',
      position: LatLng(11.5680, 104.9050),
      accentColor: Color(0xFF8B7560),
    ),
    _BoutiquePreview(
      name: 'Neary Woman Fashion River',
      position: LatLng(11.5620, 104.9280),
      accentColor: Color(0xFF9B8B7A),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2926),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- Section Header ----
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Boutique Map',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Find your nearest Neary Woman Fashion store',
                    style: GoogleFonts.comfortaa(
                      fontSize: 12,
                      color: Colors.white70,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MapPage(),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.4)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View All',
                        style: GoogleFonts.comfortaa(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios,
                          size: 10, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ---- Map Preview ----
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MapPage(),
                ),
              );
            },
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    // The mini map
                    FlutterMap(
                      options: MapOptions(
                        initialCenter: _center,
                        initialZoom: 12.0,
                        minZoom: 11,
                        maxZoom: 13,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://cartodb-basemaps-a.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.nearywoman.fashion',
                        ),
                        MarkerLayer(
                          markers: _boutiques.map((b) {
                            return Marker(
                              point: b.position,
                              width: 36,
                              height: 36,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: b.accentColor,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: b.accentColor.withOpacity(0.4),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.5,
                                  ),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.store_rounded,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    // Gradient overlay at bottom for text readability
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 60,
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
                      ),
                    ),

                    // Bottom text overlay
                    const Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      child: Row(
                        children: [
                          Icon(
                            Icons.store_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '4 boutiques in Phnom Penh',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white70,
                            size: 14,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ---- Book Fitting Button ----
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC5A081),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MapPage(),
                  ),
                );
              },
              icon: const Icon(Icons.calendar_today, size: 18),
              label: Text(
                'Book Fitting',
                style: GoogleFonts.comfortaa(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Simple data class for boutique preview on the home page map section.
class _BoutiquePreview {
  final String name;
  final LatLng position;
  final Color accentColor;

  const _BoutiquePreview({
    required this.name,
    required this.position,
    required this.accentColor,
  });
}