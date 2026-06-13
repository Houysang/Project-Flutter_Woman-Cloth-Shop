import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;

  const StepIndicator({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _stepCircle(1, 'Shipping'),
        _line(1),
        _stepCircle(2, 'Payment'),
        _line(2),
        _stepCircle(3, 'Review'),
      ],
    );
  }

  bool _isActive(int step) => currentStep >= step;
  bool _isCurrent(int step) => currentStep == step;

  Widget _stepCircle(int step, String label) {
    final active = _isActive(step);
    final current = _isCurrent(step);

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          width: current ? 46 : 40,
          height: current ? 46 : 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: active
                ? const LinearGradient(
                    colors: [Color(0xFFC5A081), Color(0xFF8C6A58)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: active ? null : Colors.grey.shade300,
            boxShadow: current
                ? [
                    BoxShadow(
                      color: const Color(0xFFC5A081).withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              step.toString(),
              style: GoogleFonts.comfortaa(
                color: active ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: GoogleFonts.comfortaa(
            fontSize: current ? 13 : 12,
            fontWeight: current ? FontWeight.w700 : FontWeight.w500,
            color: active ? Colors.black : Colors.grey,
          ),
          child: Text(label),
        ),
      ],
    );
  }

  Widget _line(int step) {
    final active = currentStep > step;

    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        height: active ? 3 : 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: active
              ? const LinearGradient(
                  colors: [Color(0xFFC5A081), Color(0xFF8C6A58)],
                )
              : null,
          color: active ? null : Colors.grey.shade300,
        ),
      ),
    );
  }
}
