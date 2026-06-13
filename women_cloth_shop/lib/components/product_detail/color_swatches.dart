import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorSwatches extends StatefulWidget {
  final List<Map<String, String>> colors;
  final Function(String colorName) onColorSelected;
  final String selectedColor;

  const ColorSwatches({
    super.key,
    required this.colors,
    required this.onColorSelected,
    required this.selectedColor,
  });

  @override
  State<ColorSwatches> createState() => _ColorSwatchesState();
}

class _ColorSwatchesState extends State<ColorSwatches> {
  late String _selectedColor;

  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.selectedColor;
  }

  Color _hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
    } else if (hexString.length == 8) {
      buffer.write(hexString.replaceFirst('#', ''));
    }
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Color',
              style: GoogleFonts.comfortaa(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: darkText,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                _selectedColor,
                style: GoogleFonts.comfortaa(
                  fontSize: 11,
                  color: accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.colors.length,
            itemBuilder: (context, index) {
              final color = widget.colors[index];
              final colorName = color['name']!;
              final colorHex = color['hex']!;
              final isSelected = _selectedColor == colorName;

              return GestureDetector(
                onTap: () {
                  setState(() => _selectedColor = colorName);
                  widget.onColorSelected(colorName);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // COLOR CIRCLE
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _hexToColor(colorHex),
                          border: Border.all(
                            color: isSelected ? accent : Colors.grey[300]!,
                            width: isSelected ? 3 : 1.5,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: accent.withOpacity(0.3),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        child: isSelected
                            ? const Center(
                                child: Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
