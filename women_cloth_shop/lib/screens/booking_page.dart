import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/glass_bottom_nav_widget.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? selectedDate;
  String? selectedSlot;

  final List<String> slots = [
    "10:00 AM",
    "11:30 AM",
    "01:00 PM",
    "02:30 PM",
    "04:00 PM",
    "05:30 PM",
  ];

  Future<void> pickDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) setState(() => selectedDate = date);
  }

  void confirmBooking() {
    if (selectedDate == null || selectedSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select date and time")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AppointmentSummaryPage(date: selectedDate!, slot: selectedSlot!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2D2926)),
        title: Text(
          'Booking',
          style: GoogleFonts.comfortaa(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2D2926),
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Image.asset(
                    "assets/atelier_banner.png",
                    height: 280,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 280,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.05),
                          Colors.black.withOpacity(0.35),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Text(
              "The Art of Bespoke Elegance",
              style: GoogleFonts.cormorantGaramond(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2D2926),
                height: 1.1,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Step into a world of unhurried precision. Our atelier sessions are designed for the woman who seeks intention in every silhouette.",
              style: GoogleFonts.comfortaa(
                fontSize: 13,
                height: 1.7,
                color: const Color(0xFF6E655B),
              ),
            ),
            const SizedBox(height: 24),

            _buildAtelierCard(),
            const SizedBox(height: 26),
            Text(
              "Curated Exclusivity",
              style: GoogleFonts.comfortaa(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2D2926),
              ),
            ),
            const SizedBox(height: 14),
            _buildFeatureRow(
              "Bespoke curation",
              "Personalized wardrobe consultation with premium textile selection.",
            ),
            _buildFeatureRow(
              "Precision metrics",
              "Full body measurements and posture mapping for flawless fit.",
            ),
            _buildFeatureRow(
              "Artisan refreshments",
              "Champagne and curated tea service during styling.",
            ),
            _buildFeatureRow(
              "Aftercare plan",
              "Lifetime garment care guidance and styling follow-up.",
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: _buildSelectionCard(
                    title: "Select Date",
                    value: selectedDate == null
                        ? "Choose"
                        : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                    icon: Icons.date_range,
                    onTap: pickDate,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _buildSelectionCard(
                    title: "Time slot",
                    value: selectedSlot ?? "Pick time",
                    icon: Icons.access_time,
                    onTap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: slots.map((slot) {
                final isSelected = selectedSlot == slot;
                return ChoiceChip(
                  label: Text(slot),
                  selected: isSelected,
                  selectedColor: const Color(0xFF5D4E37),
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF4B453F),
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(
                      color: isSelected
                          ? Colors.transparent
                          : const Color(0xFFE2D8CC),
                    ),
                  ),
                  onSelected: (_) => setState(() => selectedSlot = slot),
                );
              }).toList(),
            ),
            const SizedBox(height: 28),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Appointment Summary",
                    style: GoogleFonts.comfortaa(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2D2926),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _buildSummaryRow("Service", "Private Suite Tailoring"),
                  const SizedBox(height: 10),
                  _buildSummaryRow("Duration", "120 Minutes"),
                  const SizedBox(height: 10),
                  _buildSummaryRow("Stylist", "Evelyn Vane"),
                  const SizedBox(height: 10),
                  _buildSummaryRow("Location", "The Atelier Suite, Flagship"),
                  const SizedBox(height: 10),
                  _buildSummaryRow(
                    "Date",
                    selectedDate == null
                        ? "Not selected"
                        : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                  ),
                  const SizedBox(height: 10),
                  _buildSummaryRow("Time", selectedSlot ?? "Not selected"),
                  const SizedBox(height: 20),
                  const Divider(color: Color(0xFFE8E1D6)),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: GoogleFonts.comfortaa(
                          fontSize: 16,
                          color: const Color(0xFF6E655B),
                        ),
                      ),
                      Text(
                        "\$250.00",
                        style: GoogleFonts.comfortaa(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2D2926),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: confirmBooking,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5D4E37),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Text(
                        "CONFIRM APPOINTMENT",
                        style: GoogleFonts.comfortaa(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: const GlassBottomNavWidget(),
    );
  }

  Widget _buildAtelierCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "120 Minutes",
                      style: GoogleFonts.comfortaa(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2D2926),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "The Atelier Suite",
                      style: GoogleFonts.comfortaa(
                        fontSize: 14,
                        color: const Color(0xFF6E655B),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF5D4E37),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                child: Text(
                  "From \$250",
                  style: GoogleFonts.comfortaa(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _buildInfoBadge(Icons.event, "Private Suite"),
              const SizedBox(width: 12),
              _buildInfoBadge(Icons.spa, "Tailoring"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBadge(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F1E8),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF5D4E37)),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.comfortaa(
              color: const Color(0xFF5D4E37),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 3),
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF5D4E37),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.comfortaa(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2D2926),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: GoogleFonts.comfortaa(
                    fontSize: 14,
                    height: 1.55,
                    color: const Color(0xFF6E655B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionCard({
    required String title,
    required String value,
    required IconData icon,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF5D4E37), size: 20),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: GoogleFonts.comfortaa(
                    fontSize: 13,
                    color: const Color(0xFF6E655B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              value,
              style: GoogleFonts.comfortaa(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2D2926),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.comfortaa(fontSize: 14, color: const Color(0xFF6E655B)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.comfortaa(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2D2926),
            ),
          ),
        ),
      ],
    );
  }
}

//
// Appointment Summary Page
//
class AppointmentSummaryPage extends StatelessWidget {
  final DateTime date;
  final String slot;

  const AppointmentSummaryPage({
    super.key,
    required this.date,
    required this.slot,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF2D2926)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          'Appointment Summary',
          style: GoogleFonts.comfortaa(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF2D2926),
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            _buildInfoRow("Service Type", "Private Suite Tailoring"),
            const SizedBox(height: 10),
            _buildInfoRow("Duration", "120 Minutes"),
            const SizedBox(height: 10),
            _buildInfoRow("Stylist", "Evelyn Vane"),
            const SizedBox(height: 10),
            _buildInfoRow("Location", "The Atelier Suite, Flagship"),
            const SizedBox(height: 20),
            _buildInfoRow(
              "Date",
              date.toLocal().toString().split(' ')[0],
            ),
            const SizedBox(height: 10),
            _buildInfoRow("Time", slot),
            const SizedBox(height: 20),
            const Divider(color: Color(0xFFE8E1D6)),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TOTAL FEE",
                  style: GoogleFonts.comfortaa(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6E655B),
                  ),
                ),
                Text(
                  "\$250.00",
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2D2926),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        "Booking Confirmed",
                        style: GoogleFonts.comfortaa(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2D2926),
                        ),
                      ),
                      content: Text(
                        "Your appointment has been successfully booked.\n\n"
                        "We look forward to seeing you at The Atelier Suite!",
                        style: GoogleFonts.comfortaa(
                          color: const Color(0xFF6E655B),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "OK",
                            style: GoogleFonts.comfortaa(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF5D4E37),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5D4E37),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text(
                  "CONFIRM APPOINTMENT",
                  style: GoogleFonts.comfortaa(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "FREE CANCELLATION UP TO 24 HOURS BEFORE",
                style: GoogleFonts.comfortaa(
                  color: Colors.black54,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const GlassBottomNavWidget(),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.comfortaa(
              fontSize: 13,
              color: const Color(0xFF6E655B),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.comfortaa(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2D2926),
            ),
          ),
        ],
      ),
    );
  }
}