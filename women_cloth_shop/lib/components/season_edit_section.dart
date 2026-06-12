import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeasonEditSection extends StatelessWidget {
  const SeasonEditSection({super.key});

  static const Color darkText = Color(0xFF2D2926);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "The Seasons Edit",
          style: GoogleFonts.comfortaa(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: darkText,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          "Curated essentials that define the modern wardrobe, selected by our editorial team.",
          style: TextStyle(color: Colors.black54),
        ),

        const SizedBox(height: 20),

        // MAIN IMAGE
        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: const DecorationImage(
              image: AssetImage('assets/images/summercollection1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(height: 15),

        Row(
          children: [
            Expanded(child: _miniCard('assets/images/collection2.jpg')),
            const SizedBox(width: 12),
            Expanded(child: _miniCard('assets/images/collection3.jpg')),
          ],
        ),
      ],
    );
  }

  Widget _miniCard(String img) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}