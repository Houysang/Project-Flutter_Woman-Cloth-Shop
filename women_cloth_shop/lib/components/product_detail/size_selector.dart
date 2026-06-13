import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SizeSelector extends StatefulWidget {
  final List<String> sizes;
  final Function(String size) onSizeSelected;
  final String selectedSize;

  const SizeSelector({
    super.key,
    required this.sizes,
    required this.onSizeSelected,
    required this.selectedSize,
  });

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  late String _selectedSize;

  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  @override
  void initState() {
    super.initState();
    _selectedSize = widget.selectedSize;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // HEADER
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Size',
              style: GoogleFonts.comfortaa(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: darkText,
              ),
            ),
            GestureDetector(
              onTap: () => _showSizeGuide(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.straighten, size: 14, color: accent),
                    const SizedBox(width: 4),
                    Text(
                      'Size Guide',
                      style: GoogleFonts.comfortaa(
                        fontSize: 11,
                        color: accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.sizes.length,
            itemBuilder: (context, index) {
              final size = widget.sizes[index];
              final isSelected = _selectedSize == size;

              return GestureDetector(
                onTap: () {
                  setState(() => _selectedSize = size);
                  widget.onSizeSelected(size);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 48,
                  height: 48,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? accent.withOpacity(0.15) : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? accent : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: accent.withOpacity(0.25),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                  child: Center(
                    child: Text(
                      size,
                      style: GoogleFonts.comfortaa(
                        fontSize: 13,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.grey[700],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ---------------- SIZE GUIDE ----------------
  void _showSizeGuide(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        const Icon(Icons.straighten, color: accent, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Size Guide',
                    style: GoogleFonts.comfortaa(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkText,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // TABLE
              Table(
                border: TableBorder.all(color: Colors.grey.shade200),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.08),
                    ),
                    children: [
                      _sizeGuideCell('Size', isHeader: true),
                      _sizeGuideCell('Chest'),
                      _sizeGuideCell('Length'),
                    ],
                  ),
                  _sizeRow('XS', '32"', '35"'),
                  _sizeRow('S', '34"', '36"'),
                  _sizeRow('M', '36"', '37"'),
                  _sizeRow('L', '38"', '38"'),
                  _sizeRow('XL', '40"', '39"'),
                ],
              ),

              const SizedBox(height: 20),

              // CLOSE BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Close',
                    style: GoogleFonts.comfortaa(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sizeGuideCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.comfortaa(
          fontSize: 12,
          fontWeight: isHeader ? FontWeight.w700 : FontWeight.w500,
          color: darkText,
        ),
      ),
    );
  }

  TableRow _sizeRow(String size, String chest, String length) {
    return TableRow(
      children: [
        _sizeGuideCell(size),
        _sizeGuideCell(chest),
        _sizeGuideCell(length),
      ],
    );
  }
}
