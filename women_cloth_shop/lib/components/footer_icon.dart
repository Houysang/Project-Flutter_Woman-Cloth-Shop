import 'package:flutter/material.dart';

class FooterIcon extends StatelessWidget {
  final int index;
  final Color color;

  const FooterIcon({
    super.key,
    required this.index,
    this.color = const Color(0xFFC5A081),
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      index == 0
          ? Icons.wb_sunny_outlined
          : index == 1
              ? Icons.favorite_outline
              : index == 2
                  ? Icons.diamond_outlined
                  : index == 3
                      ? Icons.star_outline
                      : Icons.whatshot_outlined,
      size: 14,
      color: color,
    );
  }
}