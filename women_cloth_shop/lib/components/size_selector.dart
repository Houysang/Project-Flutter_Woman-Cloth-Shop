import 'package:flutter/material.dart';

class SizeSelector extends StatefulWidget {
  final List<String> sizes; // ['XS', 'S', 'M', 'L', 'XL']
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Size',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            GestureDetector(
              onTap: () {
                // Show size guide modal
                _showSizeGuide(context);
              },
              child: Text(
                'Size Guide',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.brown[400],
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(widget.sizes.length, (index) {
            final size = widget.sizes[index];
            final isSelected = _selectedSize == size;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSize = size;
                });
                widget.onSizeSelected(size);
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.brown : Colors.grey[300]!,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: isSelected ? Colors.brown[50] : Colors.white,
                ),
                child: Center(
                  child: Text(
                    size,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected ? Colors.brown : Colors.grey[700],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  void _showSizeGuide(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Size Guide',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              Table(
                border: TableBorder.all(color: Colors.grey[300]!),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.brown[50]),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'Size',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'Chest',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'Length',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const TableRow(
                    children: [
                      Padding(padding: EdgeInsets.all(12), child: Text('XS')),
                      Padding(padding: EdgeInsets.all(12), child: Text('32"')),
                      Padding(padding: EdgeInsets.all(12), child: Text('35"')),
                    ],
                  ),
                  const TableRow(
                    children: [
                      Padding(padding: EdgeInsets.all(12), child: Text('S')),
                      Padding(padding: EdgeInsets.all(12), child: Text('34"')),
                      Padding(padding: EdgeInsets.all(12), child: Text('36"')),
                    ],
                  ),
                  const TableRow(
                    children: [
                      Padding(padding: EdgeInsets.all(12), child: Text('M')),
                      Padding(padding: EdgeInsets.all(12), child: Text('36"')),
                      Padding(padding: EdgeInsets.all(12), child: Text('37"')),
                    ],
                  ),
                  const TableRow(
                    children: [
                      Padding(padding: EdgeInsets.all(12), child: Text('L')),
                      Padding(padding: EdgeInsets.all(12), child: Text('38"')),
                      Padding(padding: EdgeInsets.all(12), child: Text('38"')),
                    ],
                  ),
                  const TableRow(
                    children: [
                      Padding(padding: EdgeInsets.all(12), child: Text('XL')),
                      Padding(padding: EdgeInsets.all(12), child: Text('40"')),
                      Padding(padding: EdgeInsets.all(12), child: Text('39"')),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Close',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
