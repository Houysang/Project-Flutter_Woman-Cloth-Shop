import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageBookingPage extends StatelessWidget {
  const ManageBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final bookingId = args?['bookingId'] as String? ?? "BK10245";
    final date = args?['date'] as String? ?? "June 25, 2026";
    final time = args?['time'] as String? ?? "2:00 PM";
    final service = args?['service'] as String? ?? "Clothing Appointment";
    final location = args?['location'] as String? ?? "Main Store";

    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2D2926)),
        title: Text('Manage Booking',
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
            // Status Badge
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle,
                      color: Color(0xFF4CAF50), size: 20),
                  const SizedBox(width: 10),
                  Text('Status: Confirmed',
                      style: GoogleFonts.comfortaa(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2E7D32))),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Section Title
            Row(
              children: [
                const Icon(Icons.calendar_today,
                    size: 18, color: Color(0xFF5D4E37)),
                const SizedBox(width: 8),
                Text('Manage Your Booking',
                    style: GoogleFonts.comfortaa(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2D2926))),
              ],
            ),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Text('Booking ID: #$bookingId',
                  style: GoogleFonts.comfortaa(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6E655B))),
            ),
            // Divider
            Container(height: 1, color: const Color(0xFFE7DFD1)),
            const SizedBox(height: 12),
            // Booking Details
            _detailRow(Icons.calendar_today, 'Date', date),
            const SizedBox(height: 12),
            _detailRow(Icons.access_time, 'Time', time),
            const SizedBox(height: 12),
            _detailRow(Icons.spa, 'Service', service),
            const SizedBox(height: 12),
            _detailRow(Icons.location_on, 'Location', location),
            // Divider
            const SizedBox(height: 16),
            Container(height: 1, color: const Color(0xFFE7DFD1)),
            const SizedBox(height: 20),
            // Section: What would you like to do?
            Text("What would you like to do?",
                style: GoogleFonts.comfortaa(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2D2926))),
            const SizedBox(height: 16),
            // Action buttons
            _buildActionTile(
              context,
              icon: Icons.cancel_outlined,
              title: "Cancel Booking",
              subtitle: "This action cannot be undone",
              color: const Color(0xFFD32F2F),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    title: Text("Cancel Booking?",
                        style: GoogleFonts.comfortaa(
                            fontSize: 18, fontWeight: FontWeight.w700)),
                    content: Text(
                        "Are you sure you want to cancel this booking?",
                        style: GoogleFonts.comfortaa(fontSize: 14)),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text("Keep Booking",
                            style: GoogleFonts.comfortaa(
                                color: const Color(0xFF5D4E37))),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/shop', (route) => false);
                        },
                        child: Text("Yes, Cancel",
                            style: GoogleFonts.comfortaa(
                                color: const Color(0xFFD32F2F))),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildActionTile(
              context,
              icon: Icons.description_outlined,
              title: "View Booking",
              subtitle: "Review your booking details",
              color: const Color(0xFF5D4E37),
              onTap: () {
                Navigator.pushNamed(context, '/view-booking', arguments: args);
              },
            ),
            const SizedBox(height: 24),
            // Status info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F1E8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline,
                      size: 18, color: Color(0xFF5D4E37)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('Status: Confirmed',
                        style: GoogleFonts.comfortaa(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF5D4E37))),
                  ),
                ],
              ),
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
        Icon(icon, size: 18, color: const Color(0xFF5D4E37)),
        const SizedBox(width: 12),
        SizedBox(
          width: 80,
          child: Text(label,
              style: GoogleFonts.comfortaa(
                  fontSize: 14, color: const Color(0xFF6E655B))),
        ),
        Expanded(
          child: Text(value,
              style: GoogleFonts.comfortaa(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2D2926))),
        ),
      ],
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE7DFD1)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.comfortaa(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2D2926))),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: GoogleFonts.comfortaa(
                          fontSize: 12, color: const Color(0xFF6E655B))),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: color, size: 24),
          ],
        ),
      ),
    );
  }
}