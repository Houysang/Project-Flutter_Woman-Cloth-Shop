import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  static const Color darkText = Color(0xFF2D2926);
  static const Color accent = Color(0xFFC5A081);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F7F2),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: darkText),
        title: Text(
          "About App",
          style: GoogleFonts.comfortaa(
            color: darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // APP INFO CARD
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.phone_android, size: 60, color: accent),
                  const SizedBox(height: 10),
                  Text(
                    "My Shopping App",
                    style: GoogleFonts.comfortaa(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkText,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Version 1.0.0",
                    style: GoogleFonts.comfortaa(color: Colors.black54),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _section(
              "About This App",
              "This application is designed to provide a smooth and modern shopping experience. "
                  "Users can browse products, manage wishlist, add items to cart, and track orders easily.",
            ),

            const SizedBox(height: 20),

            _section(
              "Our Mission",
              "We aim to create a simple, fast, and user-friendly shopping platform that improves daily online shopping experience.",
            ),

            const SizedBox(height: 20),

            _section(
              "Developer Info",
              "Built using Flutter with a focus on clean UI, performance, and scalability.",
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    "Follow Us",
                    style: GoogleFonts.comfortaa(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: darkText,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.facebook, color: Colors.blue),
                      SizedBox(width: 20),
                      Icon(Icons.camera_alt, color: Colors.pink),
                      SizedBox(width: 20),
                      Icon(Icons.public, color: Colors.green),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // SECTION WIDGET
  Widget _section(String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.comfortaa(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.comfortaa(
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
