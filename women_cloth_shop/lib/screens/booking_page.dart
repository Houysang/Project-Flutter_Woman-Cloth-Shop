import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/glass_bottom_nav_widget.dart';

class BookingPage extends StatefulWidget {
  final String? productPrice;
  final String? productName;
  final String? productImage;
  final String? selectedSize;
  final String? selectedColor;
  final int? quantity;
  final String? material;
  final String? care;
  final String? origin;
  final String? lining;

  const BookingPage({
    super.key,
    this.productPrice,
    this.productName,
    this.productImage,
    this.selectedSize,
    this.selectedColor,
    this.quantity,
    this.material,
    this.care,
    this.origin,
    this.lining,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? selectedDate;
  String? selectedSlot;
  String? selectedLocation;

  final List<String> slots = [
    "10:00 AM",
    "11:30 AM",
    "01:00 PM",
    "02:30 PM",
    "04:00 PM",
    "05:30 PM",
  ];

  final List<Map<String, String>> locations = [
    {
      "name": "Neary Woman Fashion - 5th Avenue",
      "address": "572 5th Ave, Bactouk ,Phnom Penh"
    },
    {
      "name": "Neary Woman Fashion - Toul Kork",
      "address": "#168, St. 315, Toul Kork, Phnom Penh "
    },
    {
      "name": "Neary Woman Fashion - River",
      "address": "#72, Sisowath Quay, Daun Penh, Phnom Penh"
    },
  ];

  String get _formattedDate {
    const months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return "${months[selectedDate!.month - 1]} ${selectedDate!.day}, ${selectedDate!.year}";
  }

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
    if (selectedDate == null ||
        selectedSlot == null ||
        selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select date, time, and location")),
      );
      return;
    }
    _showAppointmentConfirmed();
  }

  void _showAppointmentConfirmed() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCircleIcon(Colors.green.shade100,
                  Icons.check_circle_rounded, Colors.green.shade700, 48),
              const SizedBox(height: 20),
              Text("Appointment Confirmed",
                  style: GoogleFonts.comfortaa(
                      fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text("Thank you for your booking!",
                  style: GoogleFonts.comfortaa(
                      fontSize: 14, color: const Color(0xFF6E655B))),
              const SizedBox(height: 24),
              _detailWithEmoji("📅", "Date", _formattedDate),
              const SizedBox(height: 12),
              _detailWithEmoji("🕒", "Time", selectedSlot ?? ""),
              const SizedBox(height: 12),
              _detailWithEmoji("👕", "Service", widget.productName ?? "Clothing Fitting"),
              const SizedBox(height: 12),
              _detailWithEmoji("📍", "Location", selectedLocation ?? "Main Store"),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildButton("View Booking", isFilled: false, onTap: () {
                      Navigator.pop(ctx);
                      final String bookingId =
                          "BK${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 11)}";
                      Navigator.pushNamed(
                        context,
                        '/view-booking',
                        arguments: {
                          'bookingId': bookingId,
                          'date': _formattedDate,
                          'time': selectedSlot,
                          'service': widget.productName ?? "Clothing Appointment",
                          'location': selectedLocation,
                          'productName': widget.productName,
                          'productPrice': widget.productPrice,
                          'selectedSize': widget.selectedSize,
                          'selectedColor': widget.selectedColor,
                          'quantity': widget.quantity,
                        },
                      );
                    }),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildButton("Done", isFilled: true, onTap: () {
                      Navigator.pop(ctx);
                      _showConfirmed();
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmed() {
    final String bookingId =
        "BK${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 11)}";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              const SizedBox(height: 20),
              Text("Booking Confirmed!",
                  style: GoogleFonts.comfortaa(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2D2926))),
              const SizedBox(height: 6),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F1E8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text("Booking ID: #$bookingId",
                    style: GoogleFonts.comfortaa(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF5D4E37))),
              ),
              const SizedBox(height: 24),
              _detailWithEmoji("📅", "Date", _formattedDate),
              const SizedBox(height: 12),
              _detailWithEmoji("🕒", "Time", selectedSlot ?? ""),
              const SizedBox(height: 12),
              _detailWithEmoji("👕", "Service", widget.productName ?? "Clothing Appointment"),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildButton("Manage Booking",
                        isFilled: false, onTap: () {
                      Navigator.pop(ctx);
                      final String bookingId =
                          "BK${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 11)}";
                      Navigator.pushNamed(
                        context,
                        '/manage-booking',
                        arguments: {
                          'bookingId': bookingId,
                          'date': _formattedDate,
                          'time': selectedSlot,
                          'service': widget.productName ?? "Clothing Appointment",
                          'location': selectedLocation,
                          'productName': widget.productName,
                          'productPrice': widget.productPrice,
                          'selectedSize': widget.selectedSize,
                          'selectedColor': widget.selectedColor,
                          'quantity': widget.quantity,
                        },
                      );
                    }),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildButton("Back to Home", isFilled: true, onTap: () {
                      Navigator.pop(ctx);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/shop', (route) => false);
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleIcon(
      Color bg, IconData icon, Color iconColor, double size) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Icon(icon, color: iconColor, size: size),
    );
  }

  Widget _detailWithEmoji(String emoji, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$emoji  ", style: const TextStyle(fontSize: 14)),
        Text(label + ": ",
            style: GoogleFonts.comfortaa(
                fontSize: 13,
                color: const Color(0xFF6E655B),
                fontWeight: FontWeight.w600)),
        Text(value,
            style: GoogleFonts.comfortaa(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2D2926))),
      ],
    );
  }

  Widget _buildButton(String text,
      {required bool isFilled, required VoidCallback onTap}) {
    return isFilled
        ? SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5D4E37),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(text,
                  style: GoogleFonts.comfortaa(
                      fontSize: 13, fontWeight: FontWeight.w600)),
            ),
          )
        : SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF5D4E37),
                side: const BorderSide(color: Color(0xFF5D4E37)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(text,
                  style: GoogleFonts.comfortaa(
                      fontSize: 13, fontWeight: FontWeight.w600)),
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
        title: Text('Booking',
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
            const SizedBox(height: 20),
            _buildImageSection(),
            const SizedBox(height: 22),
            Text("The Art of Bespoke Elegance",
                style: GoogleFonts.cormorantGaramond(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2D2926),
                    height: 1.1)),
            const SizedBox(height: 12),
            Text(
                "Step into a world of unhurried precision. Our atelier sessions are designed for the woman who seeks intention in every silhouette.",
                style: GoogleFonts.comfortaa(
                    fontSize: 13, height: 1.7, color: const Color(0xFF6E655B))),
            const SizedBox(height: 24),
            _buildAtelierCard(),
            const SizedBox(height: 26),
            Text("Curated Exclusivity",
                style: GoogleFonts.comfortaa(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2D2926))),
            const SizedBox(height: 14),
            _buildFeatureRow("Bespoke curation",
                "Personalized wardrobe consultation with premium textile selection."),
            _buildFeatureRow("Precision metrics",
                "Full body measurements and posture mapping for flawless fit."),
            _buildFeatureRow("Artisan refreshments",
                "Champagne and curated tea service during styling."),
            _buildFeatureRow("Aftercare plan",
                "Lifetime garment care guidance and styling follow-up."),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                    child: _buildSelectionCard(
                        title: "Select Date",
                        value: selectedDate == null ? "Choose" : _formattedDate,
                        icon: Icons.date_range,
                        onTap: pickDate)),
                const SizedBox(width: 14),
                Expanded(
                    child: _buildSelectionCard(
                        title: "Time slot",
                        value: selectedSlot ?? "Pick time",
                        icon: Icons.access_time,
                        onTap: () {})),
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
                      color:
                          isSelected ? Colors.white : const Color(0xFF4B453F),
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(
                        color: isSelected
                            ? Colors.transparent
                            : const Color(0xFFE2D8CC)),
                  ),
                  onSelected: (_) => setState(() => selectedSlot = slot),
                );
              }).toList(),
            ),
            const SizedBox(height: 28),
            Text("Select Store",
                style: GoogleFonts.comfortaa(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2D2926))),
            const SizedBox(height: 14),
            ...locations.map(_buildStoreCard),
            const SizedBox(height: 18),
            _buildSummarySection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const GlassBottomNavWidget(),
    );
  }

  Widget _buildImageSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4))
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 400,
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    widget.productImage ?? "assets/images/fashion1.jpg",
                    height: 400,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 400,
                      color: const Color(0xFFF5E6D3),
                      child: const Center(
                          child: Icon(Icons.image_outlined,
                              color: Color(0xFFC4B5A0), size: 60)),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF5D4E37),
                        borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Text(widget.productPrice ?? "\$250.00",
                        style: GoogleFonts.comfortaa(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStoreCard(Map<String, String> loc) {
    final isSelected = selectedLocation == loc["name"];
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => setState(() => selectedLocation = loc["name"]),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
                color: isSelected
                    ? const Color(0xFF5D4E37)
                    : const Color(0xFFE7DFD1),
                width: isSelected ? 2 : 1),
          ),
          child: Row(
            children: [
              Icon(isSelected ? Icons.store_rounded : Icons.store_outlined,
                  color: isSelected
                      ? const Color(0xFF5D4E37)
                      : const Color(0xFF9E9E9E),
                  size: 24),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(loc["name"]!,
                        style: GoogleFonts.comfortaa(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF2D2926))),
                    const SizedBox(height: 4),
                    Text(loc["address"]!,
                        style: GoogleFonts.comfortaa(
                            fontSize: 12, color: const Color(0xFF6E655B))),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(Icons.check_circle,
                    color: Color(0xFF5D4E37), size: 22),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
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
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Appointment Summary",
              style: GoogleFonts.comfortaa(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2D2926))),
          const SizedBox(height: 18),
          if (widget.productName != null)
            _buildSummaryRow("Product", widget.productName!),
          if (widget.productName != null) const SizedBox(height: 10),
          if (widget.selectedColor != null)
            _buildSummaryRow("Color", widget.selectedColor!),
          if (widget.selectedColor != null) const SizedBox(height: 10),
          if (widget.selectedSize != null)
            _buildSummaryRow("Size", widget.selectedSize!),
          if (widget.selectedSize != null) const SizedBox(height: 10),
          if (widget.quantity != null && widget.quantity! > 1)
            _buildSummaryRow("Quantity", "${widget.quantity}"),
          if (widget.quantity != null && widget.quantity! > 1)
            const SizedBox(height: 10),
          if (widget.material != null)
            _buildSummaryRow("Material", widget.material!),
          if (widget.material != null) const SizedBox(height: 10),
          if (widget.care != null) _buildSummaryRow("Care", widget.care!),
          if (widget.care != null) const SizedBox(height: 10),
          if (widget.origin != null) _buildSummaryRow("Origin", widget.origin!),
          if (widget.origin != null) const SizedBox(height: 10),
          if (widget.lining != null) _buildSummaryRow("Lining", widget.lining!),
          if (widget.lining != null) const SizedBox(height: 10),
          _buildSummaryRow("Service", "Private Suite Tailoring"),
          const SizedBox(height: 10),
          _buildSummaryRow("Duration", "60 Minutes"),
          const SizedBox(height: 10),
          _buildSummaryRow("Stylist", "Evelyn Vane"),
          const SizedBox(height: 10),
          _buildSummaryRow("Location", selectedLocation ?? "Not selected"),
          const SizedBox(height: 10),
          _buildSummaryRow(
              "Date", selectedDate == null ? "Not selected" : _formattedDate),
          const SizedBox(height: 10),
          _buildSummaryRow("Time", selectedSlot ?? "Not selected"),
          const SizedBox(height: 10),
          _buildSummaryRow("Price", widget.productPrice ?? ""),
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
                    borderRadius: BorderRadius.circular(18)),
              ),
              child: Text("CONFIRM APPOINTMENT",
                  style: GoogleFonts.comfortaa(
                      fontSize: 16, fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
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
              offset: const Offset(0, 8))
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
                    Text("60 Minutes",
                        style: GoogleFonts.comfortaa(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF2D2926))),
                    const SizedBox(height: 6),
                    Text("The Atelier Suite",
                        style: GoogleFonts.comfortaa(
                            fontSize: 14, color: const Color(0xFF6E655B))),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color(0xFF5D4E37),
                    borderRadius: BorderRadius.circular(16)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Text(widget.productPrice ?? "From \$250",
                    style: GoogleFonts.comfortaa(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13)),
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
          borderRadius: BorderRadius.circular(18)),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF5D4E37)),
          const SizedBox(width: 8),
          Text(label,
              style: GoogleFonts.comfortaa(
                  color: const Color(0xFF5D4E37),
                  fontSize: 13,
                  fontWeight: FontWeight.w600)),
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
                  color: Color(0xFF5D4E37), shape: BoxShape.circle)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.comfortaa(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2D2926))),
                const SizedBox(height: 6),
                Text(subtitle,
                    style: GoogleFonts.comfortaa(
                        fontSize: 14,
                        height: 1.55,
                        color: const Color(0xFF6E655B))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionCard(
      {required String title,
      required String value,
      required IconData icon,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE7DFD1))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF5D4E37), size: 20),
                const SizedBox(width: 10),
                Text(title,
                    style: GoogleFonts.comfortaa(
                        fontSize: 13,
                        color: const Color(0xFF6E655B),
                        fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 14),
            Text(value,
                style: GoogleFonts.comfortaa(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2D2926))),
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
            child: Text(label,
                style: GoogleFonts.comfortaa(
                    fontSize: 14, color: const Color(0xFF6E655B)))),
        const SizedBox(width: 8),
        Expanded(
            flex: 2,
            child: Text(value,
                textAlign: TextAlign.right,
                style: GoogleFonts.comfortaa(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2D2926)))),
      ],
    );
  }
}
