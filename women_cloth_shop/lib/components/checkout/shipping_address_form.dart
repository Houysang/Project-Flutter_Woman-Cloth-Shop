import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingAddressForm extends StatelessWidget {
  final TextEditingController firstNameCtrl;
  final TextEditingController lastNameCtrl;
  final TextEditingController addressCtrl;
  final TextEditingController provinceCtrl;
  final TextEditingController phoneCtrl;

  final VoidCallback onPickLocation;

  const ShippingAddressForm({
    super.key,
    required this.firstNameCtrl,
    required this.lastNameCtrl,
    required this.addressCtrl,
    required this.provinceCtrl,
    required this.phoneCtrl,
    required this.onPickLocation,
  });

  static const Color darkText = Color(0xFF2D2926);

  InputDecoration _style(String label, IconData icon, {String? hint}) {
    return InputDecoration(
      prefixIcon: Icon(icon, size: 18, color: Colors.grey.shade600),
      labelText: label,
      hintText: hint,
      labelStyle: GoogleFonts.comfortaa(fontSize: 13),
      hintStyle: GoogleFonts.comfortaa(
        fontSize: 12,
        color: Colors.grey.shade400,
      ),
      filled: true,
      fillColor: Colors.grey.shade50,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFC5A081)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 10),
      child: Text(
        text,
        style: GoogleFonts.comfortaa(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: darkText,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Text(
          'Shipping Address',
          style: GoogleFonts.comfortaa(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),

        const SizedBox(height: 14),

        // Name row
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: firstNameCtrl,
                decoration: _inputStyle('First Name'),
                validator: (v) => v?.trim().isEmpty ?? true ? 'Required' : null,
              ),
=======
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping Address',
            style: GoogleFonts.comfortaa(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: darkText,
>>>>>>> c7c26041bded06e1697c5920d16d795020cbd8dd
            ),
          ),

          // ================= NAME =================
          _sectionTitle("Personal Info"),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: firstNameCtrl,
                  decoration: _style('First Name', Icons.person_outline),
                  style: GoogleFonts.comfortaa(fontSize: 13),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: lastNameCtrl,
                  decoration: _style('Last Name', Icons.person),
                  style: GoogleFonts.comfortaa(fontSize: 13),
                ),
              ),
            ],
          ),

          // ================= CONTACT =================
          _sectionTitle("Contact"),
          TextFormField(
            controller: phoneCtrl,
            keyboardType: TextInputType.phone,
            decoration:
                _style('Phone Number', Icons.phone_outlined, hint: '+855...'),
            style: GoogleFonts.comfortaa(fontSize: 13),
          ),

          // ================= ADDRESS =================
          _sectionTitle("Address"),
          TextFormField(
            controller: addressCtrl,
            decoration: _style(
              'Street Address',
              Icons.home_outlined,
              hint: 'House 12, Street 271',
            ),
            style: GoogleFonts.comfortaa(fontSize: 13),
          ),

          const SizedBox(height: 10),

          TextFormField(
            controller: provinceCtrl,
            decoration: _style('City / Province', Icons.location_city),
            style: GoogleFonts.comfortaa(fontSize: 13),
          ),

          // ================= LOCATION CHIP =================
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: onPickLocation,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFC5A081), Color(0xFF8C6A58)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFC5A081).withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.my_location,
                        color: Colors.white, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      "Pick Location",
                      style: GoogleFonts.comfortaa(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
