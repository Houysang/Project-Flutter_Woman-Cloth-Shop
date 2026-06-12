import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturedCardWidget extends StatelessWidget {
  const FeaturedCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: const DecorationImage(
          image: AssetImage(
            'assets/images/f1.gif',
          ),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(20),
      child: Text(
        "Autumn Essentials\n2026",
        style: GoogleFonts.comfortaa(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}