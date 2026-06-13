import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationBarWidget extends StatelessWidget {
  final VoidCallback? onMenuTap;

  const NavigationBarWidget({super.key, this.onMenuTap});

  static const Color darkText = Color(0xFF2D2926);
  static const Color accent = Color(0xFFC5A081);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, top: 12, bottom: 12),
      child: Row(
        children: [
          // Menu icon
          GestureDetector(
            onTap: onMenuTap,
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
                decoration: const BoxDecoration(shape: BoxShape.circle),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    "NEARY",
                    style: GoogleFonts.comfortaa(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 4,
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
                decoration: const BoxDecoration(shape: BoxShape.circle),
              ),
            ],
          ),
          const Spacer(),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}