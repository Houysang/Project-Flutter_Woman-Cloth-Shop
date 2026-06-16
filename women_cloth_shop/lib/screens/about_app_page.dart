import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  static const Color darkText = Color(0xFF2D2926);
  static const Color accent = Color(0xFFC5A081);
  static const Color bgLight = Color(0xFFF9F7F2);
  static const Color rose = Color(0xFFE8A87C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLight,
      appBar: AppBar(
        backgroundColor: bgLight,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: darkText),
        title: Text(
          "About Us",
          style: GoogleFonts.comfortaa(
            color: darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // ── BRAND HERO ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [accent.withOpacity(0.15), bgLight],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: accent.withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.favorite_rounded,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "NEARY FASHION",
                    style: GoogleFonts.comfortaa(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: darkText,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Version 1.0.0",
                    style: GoogleFonts.comfortaa(
                      fontSize: 12,
                      color: Colors.black45,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "Your cozy corner for women's fashion —\ncurated with love, designed for you.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.comfortaa(
                      fontSize: 13,
                      color: Colors.black54,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── OUR STORY ──
            _section(
              Icons.auto_stories_rounded,
              "Our Story",
              "NEARY FASHION was born from a simple belief — every woman deserves to feel beautiful, confident, and cozy in what she wears. "
                  "We started as a small dream, curating pieces that blend timeless elegance with modern comfort. "
                  "Today, we bring you handpicked collections of dresses, tops, skirts, pants, and accessories that celebrate your unique style. "
                  "From soft floral dresses to tailored blouses, every piece is chosen with care to make you feel right at home.",
            ),

            const SizedBox(height: 14),

            // ── WHAT WE OFFER ──
            _section(
              Icons.shopping_bag_rounded,
              "What We Offer",
              "🌸 Dresses — Flowy, elegant, and perfect for every occasion\n"
                  "👚 Tops — From cozy knits to chic silk blouses\n"
                  "👗 Skirts — Playful mini to sophisticated midi\n"
                  "👖 Pants — Comfort meets style in every silhouette\n"
                  "👜 Bags — The perfect companion for your everyday adventures\n\n"
                  "We also offer a seamless shopping experience with wishlist tracking, easy cart management, "
                  "and real-time order updates so you never miss a moment.",
            ),

            const SizedBox(height: 14),

            // ── OUR MISSION ──
            _section(
              Icons.flag_rounded,
              "Our Mission",
              "We believe fashion should feel like a warm hug. Our mission is to create a shopping experience "
                  "that is as delightful as unwrapping a gift. We carefully select each item to ensure quality, "
                  "comfort, and affordability — because looking good should never feel complicated. "
                  "Whether you're dressing up for a special day or keeping it casual, we're here to help "
                  "you find your perfect look with a smile.",
            ),

            const SizedBox(height: 14),

            // ── WHY CHOOSE US ──
            _section(
              Icons.verified_rounded,
              "Why Choose Us",
              "✨ Curated collections with cozy, feminine aesthetics\n"
                  "💖 Easy browsing with category filters\n"
                  "📦 Fast and reliable order processing\n"
                  "🔔 Real-time order tracking from confirmed to delivered\n"
                  "🛍️ Wishlist & cart synced across devices\n"
                  "💬 Friendly support team ready to help\n\n"
                  "We treat every order like it's going to a friend 💌",
            ),

            const SizedBox(height: 14),

            // ── OUR VALUES ──
            _section(
              Icons.favorite_rounded,
              "Our Values",
              "At NEARY FASHION, we value authenticity, warmth, and inclusivity. "
                  "We're committed to:\n\n"
                  "🌿 Quality over quantity — pieces that last\n"
                  "🎀 Affordability without compromising style\n"
                  "🌍 Sustainable choices when possible\n"
                  "🤝 Honest and transparent service\n\n"
                  "Because fashion should be kind — to you and to the world.",
            ),

            const SizedBox(height: 20),

            // ── FOLLOW US ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "Stay Connected 💕",
                    style: GoogleFonts.comfortaa(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: darkText,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialIcon(Icons.camera_alt_outlined, "Instagram", rose),
                      const SizedBox(width: 24),
                      _socialIcon(Icons.facebook_outlined, "Facebook", Colors.blue.shade400),
                      const SizedBox(width: 24),
                      _socialIcon(Icons.bookmark_rounded, "Pinterest", Colors.red.shade400),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "Tag us @nearyfashion — we'd love to see your style!",
                    style: GoogleFonts.comfortaa(
                      fontSize: 11,
                      color: Colors.black38,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ── BRAND SIGNATURE ──
            Center(
              child: Text(
                "Made with 💖 for every woman",
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  color: Colors.black38,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.comfortaa(
            fontSize: 9,
            color: Colors.black45,
          ),
        ),
      ],
    );
  }

  Widget _section(IconData icon, String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: accent),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.comfortaa(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: darkText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: GoogleFonts.comfortaa(
              color: Colors.black54,
              height: 1.7,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}