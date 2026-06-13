import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodSection extends StatelessWidget {
  final String selectedPayment;
  final Function(String) onPaymentChanged;

  const PaymentMethodSection({
    super.key,
    required this.selectedPayment,
    required this.onPaymentChanged,
  });

  static const Color darkText = Color(0xFF2D2926);
  static const Color accent = Color(0xFFC5A081);

  Widget _buildOption({
    required String id,
    required IconData icon,
    required String title,
  }) {
    final isSelected = selectedPayment == id;

    return GestureDetector(
      onTap: () => onPaymentChanged(id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? accent : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? accent.withOpacity(0.08) : Colors.white,
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: darkText),
            const SizedBox(width: 16),
            Text(
              title,
              style: GoogleFonts.comfortaa(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TITLE (FIXED FONT)
        Text(
          'Payment Method',
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

        _buildOption(
          id: 'visa',
          icon: Icons.credit_card,
          title: 'Visa Card',
        ),

        const SizedBox(height: 12),

        _buildOption(
          id: 'khqr',
          icon: Icons.qr_code,
          title: 'KHQR',
        ),

        const SizedBox(height: 12),

        _buildOption(
          id: 'cod',
          icon: Icons.local_shipping,
          title: 'Cash on Delivery',
        ),
      ],
    );
  }
}
