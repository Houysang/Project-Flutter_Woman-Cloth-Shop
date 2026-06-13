import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../data/products_grid.dart';
import 'product_card.dart';

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: ProductGridData.products.length,
      itemBuilder: (context, index) {
        return ProductCardWidget(
          product: ProductGridData.products[index],
        );
      },
    );
  }
}