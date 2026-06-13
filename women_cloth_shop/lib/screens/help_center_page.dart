import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

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
          "Help Center",
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

            // FAQ SECTION
            _section(
              "Frequently Asked Questions",
              [
                _faqItem(
                  "How do I track my order?",
                  "Go to Order History and select your order to view details.",
                ),
                _faqItem(
                  "How can I cancel an order?",
                  "Orders can be canceled shortly after placing them.",
                ),
                _faqItem(
                  "How do I return an item?",
                  "Open your order and select 'Request Return'.",
                ),
              ],
            ),

            const SizedBox(height: 20),

            // CONTACT SECTION
            _section(
              "Contact Support",
              [
                _contactItem(
                    Icons.email, "Email Support", "support@yourapp.com"),
                _contactItem(Icons.phone, "Call Us", "+855 12 345 678"),
                _contactItem(Icons.chat, "Live Chat", "8AM - 10PM"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // SECTION
  Widget _section(String title, List<Widget> children) {
    return Container(
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: GoogleFonts.comfortaa(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: darkText,
                ),
              ),
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }

  // FAQ ITEM
  Widget _faqItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: GoogleFonts.comfortaa(
          fontWeight: FontWeight.w600,
          color: darkText,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            answer,
            style: GoogleFonts.comfortaa(color: Colors.black54),
          ),
        ),
      ],
    );
  }

  // CONTACT ITEM
  Widget _contactItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: accent),
      title: Text(
        title,
        style: GoogleFonts.comfortaa(
          color: darkText,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.comfortaa(color: Colors.black54),
      ),
      onTap: () {},
    );
  }
}
