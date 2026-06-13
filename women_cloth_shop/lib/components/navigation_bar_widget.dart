import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  static const Color darkText = Color(0xFF2D2926);
  static const Color accent = Color(0xFFC5A081);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          // Menu icon
          GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.menu_rounded, color: darkText, size: 20),
            ),
          ),

          const Spacer(),

          // Brand logo
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  // color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    "NEARY",
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3,
                      color: darkText,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    "FASHION",
                    style: GoogleFonts.comfortaa(
                      fontSize: 8,
                      letterSpacing: 5,
                      color: Colors.black38,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  // color: accent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),

          const Spacer(),

          // Empty space for balance (to keep the logo centered)
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}
