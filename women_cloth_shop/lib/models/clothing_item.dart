import 'package:flutter/material.dart';

class ClothingItem {
  final String id;
  final String name;
  final String type; // e.g., "top", "bottom", "shoes", "accessory"
  final Color color;

  const ClothingItem({
    required this.id,
    required this.name,
    required this.type,
    required this.color,
  });
}
