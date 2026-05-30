import 'package:flutter/material.dart';

class ColorSwatches extends StatefulWidget {
  final List<Map<String, String>>
  colors; // [{name: 'Beige', hex: '#D4C5B9'}, ...]
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
        const Text(
          'Color',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 70, // reduced height to avoid overflow
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
                  setState(() {
                    _selectedColor = colorName;
                  });
                  widget.onColorSelected(colorName);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // prevents overflow
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _hexToColor(colorHex),
                          border: Border.all(
                            color: isSelected
                                ? Colors.black
                                : Colors.grey[300]!,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        colorName,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isSelected ? Colors.black : Colors.grey[600],
                        ),
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
