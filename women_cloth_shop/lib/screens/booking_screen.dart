import 'package:flutter/material.dart';

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
      backgroundColor: const Color(0xFFF8F3EC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF5D4E37),
            size: 20,
          ),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          "OnlyWomen",
          style: TextStyle(
            color: Color(0xFF5D4E37),
            fontSize: 24,
            fontFamily: 'Times New Roman',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.shopping_bag_outlined, color: Color(0xFF5D4E37)),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const Text(
              "The Art of Bespoke Elegance",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1D1B18),
                height: 1.1,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Step into a world of unhurried precision. Our atelier sessions are designed for the woman who seeks intention in every silhouette.",
              style: TextStyle(
                fontSize: 15,
                height: 1.6,
                color: Color(0xFF6E655B),
              ),
            ),
            const SizedBox(height: 24),

            Container(
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
                          children: const [
                            Text(
                              "120 Minutes",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1D1B18),
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "The Atelier Suite",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6E655B),
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
                        child: const Text(
                          "From \$250",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
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
            ),
            const SizedBox(height: 26),
            const Text(
              "Curated Exclusivity",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1D1B18),
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
                  const Text(
                    "Appointment Summary",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1D1B18),
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
                    children: const [
                      Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6E655B),
                        ),
                      ),
                      Text(
                        "\$250.00",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1D1B18),
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
                      child: const Text(
                        "CONFIRM APPOINTMENT",
                        style: TextStyle(
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

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {},
        selectedItemColor: const Color(0xFF5D4E37),
        unselectedItemColor: const Color(0xFF9F8E7F),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Collections",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.cut), label: "Atelier"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Bookings",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
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
            style: const TextStyle(
              color: Color(0xFF5D4E37),
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
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1D1B18),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.55,
                    color: Color(0xFF6E655B),
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
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6E655B),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1D1B18),
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
            style: const TextStyle(fontSize: 14, color: Color(0xFF6E655B)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1D1B18),
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
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5DC),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Appointment Summary",
          style: TextStyle(
            color: Color(0xFF5D4E37),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Service Type  Private Suite Tailoring",
              style: TextStyle(fontSize: 16),
            ),
            const Text("Duration  120 Minutes", style: TextStyle(fontSize: 16)),
            const Text("Stylist  Evelyn Vane", style: TextStyle(fontSize: 16)),
            const Text(
              "Location  The Atelier Suite, Flagship",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              "Date: ${date.toLocal().toString().split(' ')[0]}",
              style: const TextStyle(fontSize: 16),
            ),
            Text("Time: $slot", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text(
              "TOTAL FEE  \$250.00",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // ✅ Show success dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Booking Confirmed"),
                      content: const Text(
                        "Your appointment has been successfully booked.\n\n"
                        "We look forward to seeing you at The Atelier Suite!",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // close dialog
                            Navigator.pop(context); // go back to booking page
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5D4E37),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("CONFIRM APPOINTMENT"),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "FREE CANCELLATION UP TO 24 HOURS BEFORE",
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
          ],
        ),
      ),

      // ✅ Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // highlight Bookings
        onTap: (index) {
          // handle navigation logic here
        },
        selectedItemColor: const Color(0xFF5D4E37),
        unselectedItemColor: Colors.black54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Collections",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.cut), label: "Atelier"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Bookings",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }
}
