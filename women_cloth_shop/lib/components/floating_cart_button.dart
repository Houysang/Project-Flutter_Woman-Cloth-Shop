import 'package:flutter/material.dart';
import '../models/cart_store.dart';

class FloatingCartButton extends StatelessWidget {
  const FloatingCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (cart.isEmpty) {
      return const SizedBox.shrink();
    }

    return FloatingActionButton.extended(
      onPressed: () => Navigator.pushNamed(context, '/cart'),
      icon: const Icon(Icons.shopping_bag_outlined),
      label: Text('View bag (${cart.length})'),
      backgroundColor: Colors.brown,
      foregroundColor: Colors.white,
    );
  }
}
