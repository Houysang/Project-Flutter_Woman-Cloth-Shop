import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title;

  const SectionTitleWidget({
    super.key,
    required this.title,
  });

  static const Color darkText = Color(0xFF2D2926);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.comfortaa(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: darkText,
      ),
    );
  }
}