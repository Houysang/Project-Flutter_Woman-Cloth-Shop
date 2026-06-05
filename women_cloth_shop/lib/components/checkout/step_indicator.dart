import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep; // 1, 2, or 3

  const StepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _stepCircle(1, currentStep >= 1, 'Shipping'),
          _stepLine(currentStep > 1),
          _stepCircle(2, currentStep >= 2, 'Payment'),
          _stepLine(currentStep > 2),
          _stepCircle(3, currentStep >= 3, 'Review'),
        ],
      ),
    );
  }

  Widget _stepCircle(int step, bool active, String label) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: active
                ? const Color.fromARGB(255, 120, 81, 169)
                : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              step.toString(),
              style: TextStyle(
                color: active ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: active ? Colors.black : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _stepLine(bool active) {
    return Expanded(
      child: Container(
        height: 2,
        color:
            active ? const Color.fromARGB(255, 120, 81, 169) : Colors.grey[300],
        margin: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }
}
