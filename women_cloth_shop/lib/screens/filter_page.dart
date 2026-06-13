import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'filter_result_page.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  static const Color background = Color(0xFFF9F7F2);
  static const Color darkText = Color(0xFF2D2926);
  static const Color accent = Color(0xFFC5A081);

  String selectedCategory = "Knitwear";
  String selectedSize = "M";
  String selectedColor = "Mauve";
  RangeValues priceRange = const RangeValues(150, 850);

  final categories = [
    "Dresses",
    "Knitwear",
    "Outerwear",
    "Accessories",
    "Shoes"
  ];

  final sizes = ["XS", "S", "M", "L", "XL", "XXL"];

  final colors = {
    "Ivory": Colors.white,
    "Mauve": const Color(0xFFC08AA6),
    "Gold": const Color(0xFFD4AF37),
    "Ebony": const Color(0xFF2B1B1B),
    "Cloud": Colors.grey,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        iconTheme: const IconThemeData(color: darkText),
        title: Text(
          "Filters",
          style: GoogleFonts.comfortaa(
            color: darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                selectedCategory = "Knitwear";
                selectedSize = "M";
                selectedColor = "Mauve";
                priceRange = const RangeValues(150, 850);
              });
            },
            child: Text(
              "Clear All",
              style: GoogleFonts.comfortaa(
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("CATEGORY"),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10, // FIXED SPACING
              children: categories.map((c) {
                final isSelected = selectedCategory == c;

                return ChoiceChip(
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      c,
                      style: GoogleFonts.comfortaa(
                        color: isSelected ? Colors.white : darkText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: accent,
                  onSelected: (_) => setState(() => selectedCategory = c),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            _sectionTitle("COLOR"),
            const SizedBox(height: 12),
            Row(
              children: colors.entries.map((e) {
                final isSelected = selectedColor == e.key;

                return GestureDetector(
                  onTap: () => setState(() => selectedColor = e.key),
                  child: Container(
                    margin: const EdgeInsets.only(right: 14),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? darkText : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: e.value,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            _sectionTitle("SIZE"),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10, // FIXED SPACING
              children: sizes.map((s) {
                final isSelected = selectedSize == s;

                return ChoiceChip(
                  label: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      s,
                      style: GoogleFonts.comfortaa(
                        color: isSelected ? Colors.white : darkText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: accent,
                  onSelected: (_) => setState(() => selectedSize = s),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            _sectionTitle("PRICE RANGE"),
            const SizedBox(height: 10),
            RangeSlider(
              activeColor: accent,
              inactiveColor: Colors.grey.shade300,
              values: priceRange,
              min: 0,
              max: 1000,
              divisions: 20,
              labels: RangeLabels(
                "\$${priceRange.start.round()}",
                "\$${priceRange.end.round()}",
              ),
              onChanged: (value) {
                setState(() => priceRange = value);
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FilterResultPage(
                        category: selectedCategory,
                        size: selectedSize,
                        color: selectedColor,
                        minPrice: priceRange.start,
                        maxPrice: priceRange.end,
                      ),
                    ),
                  );
                },
                child: Text(
                  "SHOW RESULTS",
                  style: GoogleFonts.comfortaa(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.comfortaa(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: darkText,
        letterSpacing: 1,
      ),
    );
  }
}
