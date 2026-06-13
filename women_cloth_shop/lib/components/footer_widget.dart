import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  static const Color darkText = Color(0xFF2D2926);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      child: Column(
        children: [
          Text(
            "NEARY",
            style: GoogleFonts.cormorantGaramond(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "© 2026 NEARY. All rights reserved.",
          ),
        ],
      ),
    );
  }
}