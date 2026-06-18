import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewBookingPage extends StatelessWidget {
  const ViewBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final bookingId = args?['bookingId'] as String? ?? "N/A";
    final date = args?['date'] as String? ?? "N/A";
    final time = args?['time'] as String? ?? "N/A";
    final service = args?['service'] as String? ?? "Clothing Appointment";
    final location = args?['location'] as String? ?? "Main Store";
    final productName = args?['productName'] as String?;
    final productPrice = args?['productPrice'] as String?;
    final selectedSize = args?['selectedSize'] as String?;
    final selectedColor = args?['selectedColor'] as String?;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2D2926)),
        title: Text('My Booking',
            style: GoogleFonts.comfortaa(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2D2926))),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            // Success header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 18,
                      offset: const Offset(0, 10))
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFF3E0),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Text("🎉", style: TextStyle(fontSize: 36)),
                  ),
                  const SizedBox(height: 16),
                  Text("Booking Confirmed!",
                      style: GoogleFonts.comfortaa(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2D2926))),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F1E8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("Booking ID: #$bookingId",
                        style: GoogleFonts.comfortaa(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF5D4E37))),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Booking details card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 18,
                      offset: const Offset(0, 10))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Booking Details",
                      style: GoogleFonts.comfortaa(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2D2926))),
                  const SizedBox(height: 20),
                  _detailRow(Icons.calendar_today, "Date", date),
                  const Divider(height: 24),
                  _detailRow(Icons.access_time, "Time", time),
                  const Divider(height: 24),
                  _detailRow(Icons.spa, "Service", service),
                  const Divider(height: 24),
                  _detailRow(Icons.location_on, "Location", location),
                  if (productName != null) ...[
                    const Divider(height: 24),
                    _detailRow(Icons.shopping_bag, "Product", productName),
                  ],
                  if (selectedSize != null) ...[
                    const Divider(height: 24),
                    _detailRow(Icons.straighten, "Size", selectedSize),
                  ],
                  if (selectedColor != null) ...[
                    const Divider(height: 24),
                    _detailRow(Icons.palette, "Color", selectedColor),
                  ],
                  if (productPrice != null && productPrice.isNotEmpty) ...[
                    const Divider(height: 24),
                    _detailRow(Icons.attach_money, "Price", productPrice),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/manage-booking',
                          arguments: {
                            'bookingId': bookingId,
                            'date': date,
                            'time': time,
                            'service': service,
                            'location': location,
                            'productName': productName,
                            'productPrice': productPrice,
                            'selectedSize': selectedSize,
                            'selectedColor': selectedColor,
                          },
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF5D4E37),
                        side: const BorderSide(color: Color(0xFF5D4E37)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text("Manage Booking",
                          style: GoogleFonts.comfortaa(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/shop', (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5D4E37),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text("Back to Home",
                          style: GoogleFonts.comfortaa(
                              fontSize: 13, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF5D4E37)),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: Text(label,
              style: GoogleFonts.comfortaa(
                  fontSize: 14, color: const Color(0xFF6E655B))),
        ),
        Expanded(
          flex: 3,
          child: Text(value,
              textAlign: TextAlign.right,
              style: GoogleFonts.comfortaa(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2D2926))),
        ),
      ],
    );
  }
}