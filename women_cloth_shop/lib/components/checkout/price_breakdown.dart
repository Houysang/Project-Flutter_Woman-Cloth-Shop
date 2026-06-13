import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PriceBreakdown extends StatelessWidget {
  final double subtotal;
  final double tax;
  final double total;

  const PriceBreakdown({
    super.key,
    required this.subtotal,
    required this.tax,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _priceRow('Subtotal', '\€${subtotal.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          _priceRow('Shipping', 'Free'),
          const SizedBox(height: 8),
          _priceRow('Tax', '\€${tax.toStringAsFixed(2)}'),
          const Divider(height: 16),
          _priceRow(
            'Total',
            '\€${total.toStringAsFixed(2)}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.comfortaa(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        Text(
          amount,
          style: GoogleFonts.comfortaa(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
