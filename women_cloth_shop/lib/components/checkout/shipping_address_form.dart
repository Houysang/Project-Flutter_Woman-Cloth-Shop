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

  InputDecoration _inputStyle(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 14),
        Text(
          'Shipping Address',
          style: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w700,
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
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: lastNameCtrl,
                decoration: _inputStyle('Last Name'),
                validator: (v) => v?.trim().isEmpty ?? true ? 'Required' : null,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Phone
        TextFormField(
          controller: phoneCtrl,
          keyboardType: TextInputType.phone,
          decoration: _inputStyle(
            'Phone Number',
            hint: '+855 12 345 678',
          ),
          validator: (v) => v?.trim().isEmpty ?? true ? 'Required' : null,
        ),

        const SizedBox(height: 10),

        // Address
        TextFormField(
          controller: addressCtrl,
          decoration: _inputStyle(
            'House / Street / Village',
            hint: 'House 12, Street 271, BKK1',
          ),
          validator: (v) => v?.trim().isEmpty ?? true ? 'Required' : null,
        ),

        const SizedBox(height: 10),

        // Province
        TextFormField(
          controller: provinceCtrl,
          decoration: _inputStyle(
            'Province / City',
            hint: 'Phnom Penh',
          ),
          validator: (v) => v?.trim().isEmpty ?? true ? 'Required' : null,
        ),

        const SizedBox(height: 12),

        // 📍 Smaller Google Map Button
        GestureDetector(
          onTap: onPickLocation,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.location_on, color: Colors.red, size: 18),
                SizedBox(width: 6),
                Flexible(
                  child: Text(
                    'Pick Location',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
