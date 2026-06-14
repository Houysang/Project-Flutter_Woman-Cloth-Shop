import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  static const Color darkText = Color(0xFF2D2926);
  static const Color accent = Color(0xFFC5A081);
  static const Color bgLight = Color(0xFFF9F7F2);

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
          "Contact Us",
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

            // ── HERO ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [accent.withOpacity(0.12), bgLight],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: accent.withOpacity(0.25),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.favorite_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "We'd Love to Hear From You 💬",
                    style: GoogleFonts.comfortaa(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Got a question, suggestion, or just want to say hi?\nDrop us a message — we're here for you!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.comfortaa(
                      fontSize: 12.5,
                      color: Colors.black54,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── CONTACT CARDS ──
            _contactCard(
              icon: Icons.email_outlined,
              title: "Email",
              detail: "hello@nearyfashion.com",
              subtitle: "We reply within 24 hours",
              color: accent,
            ),
            const SizedBox(height: 12),

            _contactCard(
              icon: Icons.phone_outlined,
              title: "Phone",
              detail: "+855 12 345 678",
              subtitle: "Mon–Sat, 9AM – 6PM",
              color: const Color(0xFFE8A87C),
            ),
            const SizedBox(height: 12),

            _contactCard(
              icon: Icons.location_on_outlined,
              title: "Visit Us",
              detail: "123 Street, Phnom Penh,\nCambodia",
              subtitle: "Come say hi! ☕",
              color: accent,
            ),
            const SizedBox(height: 12),

            _contactCard(
              icon: Icons.chat_bubble_outline_rounded,
              title: "Live Chat",
              detail: "Available on our website",
              subtitle: "We're here to help 💕",
              color: const Color(0xFF7EB5A6),
            ),

            const SizedBox(height: 24),

            // ── SEND US A MESSAGE ──
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
                        child: const Icon(Icons.send_rounded, size: 18, color: accent),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Send Us a Message",
                        style: GoogleFonts.comfortaa(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: darkText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Your Name",
                      hintStyle: GoogleFonts.comfortaa(fontSize: 13, color: Colors.black38),
                      filled: true,
                      fillColor: bgLight,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    style: GoogleFonts.comfortaa(fontSize: 13, color: darkText),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Your Email",
                      hintStyle: GoogleFonts.comfortaa(fontSize: 13, color: Colors.black38),
                      filled: true,
                      fillColor: bgLight,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    style: GoogleFonts.comfortaa(fontSize: 13, color: darkText),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Your Message...",
                      hintStyle: GoogleFonts.comfortaa(fontSize: 13, color: Colors.black38),
                      filled: true,
                      fillColor: bgLight,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    style: GoogleFonts.comfortaa(fontSize: 13, color: darkText),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Message sent! We'll get back to you soon 💌"),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        "SEND MESSAGE",
                        style: GoogleFonts.comfortaa(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── FAQ MINI ──
            Container(
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
                        child: const Icon(Icons.help_outline_rounded, size: 18, color: accent),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Quick Answers",
                        style: GoogleFonts.comfortaa(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: darkText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _faqItem("How long does shipping take?", "3–7 business days within Cambodia 🌸"),
                  const Divider(height: 20),
                  _faqItem("Can I return an item?", "Yes! Free returns within 14 days 💕"),
                  const Divider(height: 20),
                  _faqItem("How can I track my order?", "Check your Order History page for real-time updates 📦"),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ── SIGNATURE ──
            Center(
              child: Text(
                "Thank you for being part of our story 💖",
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

  Widget _contactCard({
    required IconData icon,
    required String title,
    required String detail,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 22, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.comfortaa(
                    fontSize: 12,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  detail,
                  style: GoogleFonts.comfortaa(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.comfortaa(
                    fontSize: 10.5,
                    color: Colors.black38,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _faqItem(String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: GoogleFonts.comfortaa(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: darkText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          answer,
          style: GoogleFonts.comfortaa(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}