import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  static const Color darkText = Color(0xFF2D2926);
  static const Color accent = Color(0xFFC5A081);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 10,
      ),
      child: Row(
        children: [
          // MENU
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Icon(
              Icons.menu_rounded,
              color: darkText,
            ),
          ),

          const Spacer(),

          // BRAND
          Column(
            children: [
              Text(
                "NEARY",
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: darkText,
                ),
              ),
              Text(
                "fashion",
                style: GoogleFonts.comfortaa(
                  fontSize: 10,
                  letterSpacing: 3,
                  color: Colors.black54,
                ),
              ),
            ],
          ),

          const Spacer(),

          // HEART
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Icon(
              Icons.favorite_border_rounded,
              color: darkText,
              size: 20,
            ),
          ),

          const SizedBox(width: 10),

          // CART
          Stack(
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  color: darkText,
                  size: 20,
                ),
              ),
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  height: 16,
                  width: 16,
                  decoration: const BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      "2",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
