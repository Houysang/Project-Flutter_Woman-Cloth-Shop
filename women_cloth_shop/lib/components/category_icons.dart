import 'package:flutter/material.dart';

/// Custom paint-based clothing icons for category navigation.
/// Each icon is drawn as a simple, clean line-art shape.

class DressIcon extends StatelessWidget {
  final double size;
  final Color color;

  const DressIcon({super.key, this.size = 24, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _DressPainter(color: color),
      ),
    );
  }
}

class _DressPainter extends CustomPainter {
  final Color color;
  _DressPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final s = size.width;
    final half = s / 2;

    // Neckline (left strap to right strap)
    canvas.drawLine(Offset(0.25 * s, 0.1 * s), Offset(0.4 * s, 0.3 * s), paint);
    canvas.drawLine(Offset(0.75 * s, 0.1 * s), Offset(0.6 * s, 0.3 * s), paint);

    // Shoulders to waist (sides)
    canvas.drawLine(Offset(0.25 * s, 0.1 * s), Offset(0.15 * s, 0.45 * s), paint);
    canvas.drawLine(Offset(0.75 * s, 0.1 * s), Offset(0.85 * s, 0.45 * s), paint);

    // A-line dress body (waist to hem)
    canvas.drawLine(Offset(0.15 * s, 0.45 * s), Offset(0.05 * s, 0.95 * s), paint);
    canvas.drawLine(Offset(0.85 * s, 0.45 * s), Offset(0.95 * s, 0.95 * s), paint);

    // Waist line
    canvas.drawLine(Offset(0.15 * s, 0.45 * s), Offset(0.85 * s, 0.45 * s), paint);

    // Hem line
    canvas.drawLine(Offset(0.05 * s, 0.95 * s), Offset(0.95 * s, 0.95 * s), paint);

    // Center waist detail (belt bow)
    canvas.drawLine(Offset(half, 0.45 * s), Offset(half, 0.55 * s), paint);
  }

  @override
  bool shouldRepaint(covariant _DressPainter oldDelegate) => oldDelegate.color != color;
}

class TopIcon extends StatelessWidget {
  final double size;
  final Color color;

  const TopIcon({super.key, this.size = 24, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _TopPainter(color: color),
      ),
    );
  }
}

class _TopPainter extends CustomPainter {
  final Color color;
  _TopPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final s = size.width;

    // Neckline (left to right)
    canvas.drawLine(Offset(0.3 * s, 0.15 * s), Offset(0.7 * s, 0.15 * s), paint);

    // Left shoulder
    canvas.drawLine(Offset(0.3 * s, 0.15 * s), Offset(0.1 * s, 0.35 * s), paint);

    // Right shoulder
    canvas.drawLine(Offset(0.7 * s, 0.15 * s), Offset(0.9 * s, 0.35 * s), paint);

    // Left sleeve
    canvas.drawLine(Offset(0.1 * s, 0.35 * s), Offset(0.05 * s, 0.6 * s), paint);
    canvas.drawLine(Offset(0.1 * s, 0.35 * s), Offset(0.2 * s, 0.4 * s), paint);

    // Right sleeve
    canvas.drawLine(Offset(0.9 * s, 0.35 * s), Offset(0.95 * s, 0.6 * s), paint);
    canvas.drawLine(Offset(0.9 * s, 0.35 * s), Offset(0.8 * s, 0.4 * s), paint);

    // Left body
    canvas.drawLine(Offset(0.2 * s, 0.4 * s), Offset(0.25 * s, 0.85 * s), paint);

    // Right body
    canvas.drawLine(Offset(0.8 * s, 0.4 * s), Offset(0.75 * s, 0.85 * s), paint);

    // Bottom hem
    canvas.drawLine(Offset(0.25 * s, 0.85 * s), Offset(0.75 * s, 0.85 * s), paint);

    // Center line (collar opening)
    canvas.drawLine(Offset(0.5 * s, 0.15 * s), Offset(0.5 * s, 0.35 * s), paint);
  }

  @override
  bool shouldRepaint(covariant _TopPainter oldDelegate) => oldDelegate.color != color;
}

class SkirtIcon extends StatelessWidget {
  final double size;
  final Color color;

  const SkirtIcon({super.key, this.size = 24, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _SkirtPainter(color: color),
      ),
    );
  }
}

class _SkirtPainter extends CustomPainter {
  final Color color;
  _SkirtPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final s = size.width;

    // Waistband
    canvas.drawLine(Offset(0.2 * s, 0.15 * s), Offset(0.8 * s, 0.15 * s), paint);

    // Left side (waist to hem)
    canvas.drawLine(Offset(0.2 * s, 0.15 * s), Offset(0.05 * s, 0.95 * s), paint);

    // Right side (waist to hem)
    canvas.drawLine(Offset(0.8 * s, 0.15 * s), Offset(0.95 * s, 0.95 * s), paint);

    // Hem line
    canvas.drawLine(Offset(0.05 * s, 0.95 * s), Offset(0.95 * s, 0.95 * s), paint);

    // Center vertical line (pleat/crease detail)
    canvas.drawLine(Offset(0.5 * s, 0.15 * s), Offset(0.5 * s, 0.95 * s), paint);

    // Left pleat line
    canvas.drawLine(Offset(0.35 * s, 0.35 * s), Offset(0.3 * s, 0.95 * s), paint);

    // Right pleat line
    canvas.drawLine(Offset(0.65 * s, 0.35 * s), Offset(0.7 * s, 0.95 * s), paint);
  }

  @override
  bool shouldRepaint(covariant _SkirtPainter oldDelegate) => oldDelegate.color != color;
}

class PantIcon extends StatelessWidget {
  final double size;
  final Color color;

  const PantIcon({super.key, this.size = 24, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _PantPainter(color: color),
      ),
    );
  }
}

class _PantPainter extends CustomPainter {
  final Color color;
  _PantPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final s = size.width;

    // Waistband
    canvas.drawLine(Offset(0.2 * s, 0.1 * s), Offset(0.8 * s, 0.1 * s), paint);

    // Left side (waist to ankle)
    canvas.drawLine(Offset(0.2 * s, 0.1 * s), Offset(0.15 * s, 0.95 * s), paint);

    // Right side (waist to ankle)
    canvas.drawLine(Offset(0.8 * s, 0.1 * s), Offset(0.85 * s, 0.95 * s), paint);

    // Crotch point (center, mid-way down)
    canvas.drawLine(Offset(0.15 * s, 0.95 * s), Offset(0.35 * s, 0.5 * s), paint);
    canvas.drawLine(Offset(0.85 * s, 0.95 * s), Offset(0.65 * s, 0.5 * s), paint);

    // Crotch curve (inner leg)
    canvas.drawLine(Offset(0.35 * s, 0.5 * s), Offset(0.5 * s, 0.55 * s), paint);
    canvas.drawLine(Offset(0.65 * s, 0.5 * s), Offset(0.5 * s, 0.55 * s), paint);

    // Center waist to crotch (fly/zipper)
    canvas.drawLine(Offset(0.5 * s, 0.1 * s), Offset(0.5 * s, 0.55 * s), paint);

    // Left leg hem
    canvas.drawLine(Offset(0.15 * s, 0.95 * s), Offset(0.35 * s, 0.95 * s), paint);

    // Right leg hem
    canvas.drawLine(Offset(0.65 * s, 0.95 * s), Offset(0.85 * s, 0.95 * s), paint);
  }

  @override
  bool shouldRepaint(covariant _PantPainter oldDelegate) => oldDelegate.color != color;
}