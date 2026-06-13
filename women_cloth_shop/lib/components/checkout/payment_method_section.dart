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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: GoogleFonts.comfortaa(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),

        // Apple Pay Button
        // Visa Card Button
        GestureDetector(
          onTap: () => onPaymentChanged('visa'),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                color: selectedPayment == 'visa'
                    ? Colors.brown
                    : Colors.grey[300]!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: const [
                Icon(Icons.credit_card, size: 20),
                SizedBox(width: 20),
                Text(
                  'Visa Card',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

// KHQR Button
        GestureDetector(
          onTap: () => onPaymentChanged('khqr'),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                color: selectedPayment == 'khqr'
                    ? Colors.brown
                    : Colors.grey[300]!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: const [
                Icon(Icons.qr_code, size: 20),
                SizedBox(width: 20),
                Text(
                  'KHQR',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),

// Cash on Delivery Button
        GestureDetector(
          onTap: () => onPaymentChanged('cod'),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    selectedPayment == 'cod' ? Colors.brown : Colors.grey[300]!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: const [
                Icon(Icons.local_shipping, size: 20),
                SizedBox(width: 20),
                Text(
                  'Cash on Delivery',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}
