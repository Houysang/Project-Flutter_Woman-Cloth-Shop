import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModelInfoNote extends StatelessWidget {
  final String modelHeight;
  final String modelSize;

  const ModelInfoNote({
    super.key,
    required this.modelHeight,
    required this.modelSize,
  });

  static const Color accent = Color(0xFFC5A081);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.info_outline, color: accent, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Model Info',
                  style: GoogleFonts.comfortaa(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2D2926),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Height: $modelHeight  •  Wearing Size: $modelSize',
                  style: GoogleFonts.comfortaa(
                    fontSize: 11,
                    color: Colors.black54,
                    height: 1.3,
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