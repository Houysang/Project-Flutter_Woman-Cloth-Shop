import 'package:flutter/material.dart';

class ModelInfoNote extends StatelessWidget {
  final String modelHeight;
  final String modelSize;

  const ModelInfoNote({
    super.key,
    required this.modelHeight,
    required this.modelSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.brown[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.brown[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.brown[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Model Info',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Height: $modelHeight | Wearing Size: $modelSize',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
