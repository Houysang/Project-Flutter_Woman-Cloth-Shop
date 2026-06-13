import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/cart_store.dart';

class OrderReviewSection extends StatelessWidget {
  final List<CartItem> cartItems;

  const OrderReviewSection({super.key, required this.cartItems});

  static const Color darkText = Color(0xFF2D2926);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TITLE (FIXED FONT)
        Text(
          'Review Order',
          style: GoogleFonts.comfortaa(
<<<<<<< HEAD
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
=======
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: darkText,
>>>>>>> c7c26041bded06e1697c5920d16d795020cbd8dd
          ),
        ),

        const SizedBox(height: 16),

        // ITEMS
        ...cartItems.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(
                      item.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.comfortaa(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: darkText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'One Size',
                        style: GoogleFonts.comfortaa(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item.price,
                      style: GoogleFonts.comfortaa(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: darkText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Qty: ${item.quantity}',
                      style: GoogleFonts.comfortaa(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
