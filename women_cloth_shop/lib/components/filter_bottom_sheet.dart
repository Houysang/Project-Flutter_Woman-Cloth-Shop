import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PriceFilter {
  final double? minPrice;
  final double? maxPrice;

  const PriceFilter({this.minPrice, this.maxPrice});

  bool get isActive => minPrice != null || maxPrice != null;

  bool matches(double price) {
    if (minPrice != null && price < minPrice!) return false;
    if (maxPrice != null && price > maxPrice!) return false;
    return true;
  }
}

class FilterBottomSheet extends StatefulWidget {
  final PriceFilter currentFilter;
  final ValueChanged<PriceFilter> onApply;

  const FilterBottomSheet({
    super.key,
    required this.currentFilter,
    required this.onApply,
  });

  static Future<void> show(BuildContext context, {
    required PriceFilter currentFilter,
    required ValueChanged<PriceFilter> onApply,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FilterBottomSheet(
        currentFilter: currentFilter,
        onApply: onApply,
      ),
    );
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late RangeValues _priceRange;

  static const Color accent = Color(0xFFC5A081);
  static const Color softBg = Color(0xFFFFF8F0);
  static const Color darkText = Color(0xFF2D2926);

  @override
  void initState() {
    super.initState();
    final min = widget.currentFilter.minPrice ?? 0;
    final max = widget.currentFilter.maxPrice ?? 200;
    _priceRange = RangeValues(min, max);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        color: softBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          children: [
            // Cute handle
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: accent.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 14),

            // Title row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.tune, size: 14, color: accent),
                ),
                const SizedBox(width: 8),
                Text(
                  "Filter by Price",
                  style: GoogleFonts.comfortaa(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: darkText,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.close, size: 16, color: Colors.black45),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Price range labels
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _priceLabel("\$${_priceRange.start.round()}"),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.arrow_forward, size: 14, color: accent.withOpacity(0.5)),
                ),
                _priceLabel("\$${_priceRange.end.round()}"),
              ],
            ),
            const SizedBox(height: 6),

            // Slider
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 200,
              divisions: 40,
              activeColor: accent,
              inactiveColor: accent.withOpacity(0.15),
              overlayColor: WidgetStateProperty.all(accent.withOpacity(0.08)),
              labels: RangeLabels(
                "\$${_priceRange.start.round()}",
                "\$${_priceRange.end.round()}",
              ),
              onChanged: (values) => setState(() => _priceRange = values),
            ),

            const SizedBox(height: 2),

            // Quick chips
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _cuteChip("\$0 – \$50", 0, 50),
                const SizedBox(width: 6),
                _cuteChip("\$50 – \$100", 50, 100),
                const SizedBox(width: 6),
                _cuteChip("\$100+", 100, 200),
                const SizedBox(width: 6),
                _cuteChip("All", 0, 200),
              ],
            ),

            const Spacer(),

            // Apply button
            Center(
              child: SizedBox(
                width: 120,
                height: 34,
                child: ElevatedButton(
                  onPressed: () {
                    widget.onApply(PriceFilter(
                      minPrice: _priceRange.start.roundToDouble(),
                      maxPrice: _priceRange.end.roundToDouble(),
                    ));
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shadowColor: accent.withOpacity(0.3),
                  ),
                  child: Text(
                    "Done",
                    style: GoogleFonts.comfortaa(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceLabel(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withOpacity(0.15)),
      ),
      child: Text(
        text,
        style: GoogleFonts.comfortaa(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: accent,
        ),
      ),
    );
  }

  Widget _cuteChip(String label, double min, double max) {
    final isSelected = _priceRange.start == min && _priceRange.end == max;
    return GestureDetector(
      onTap: () => setState(() => _priceRange = RangeValues(min, max)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? accent : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? accent : accent.withOpacity(0.2),
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: accent.withOpacity(0.2), blurRadius: 6, offset: const Offset(0, 2))]
              : null,
        ),
        child: Text(
          label,
          style: GoogleFonts.comfortaa(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : accent,
          ),
        ),
      ),
    );
  }
}