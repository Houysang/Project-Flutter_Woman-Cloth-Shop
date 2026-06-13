class Product {
  final String id;
  final String name;
  final String price;
  final String description;
  final List<String> images;
  final List<Color> colors;
  final List<String> sizes;
  final String modelHeight;
  final String modelSize;
  final double rating;
  final int reviews;
  final List<RelatedProduct> relatedItems;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.images,
    required this.colors,
    required this.sizes,
    required this.modelHeight,
    required this.modelSize,
    required this.rating,
    required this.reviews,
    required this.relatedItems,
  });
}

class Color {
  final String name;
  final String colorCode;

  Color({required this.name, required this.colorCode});
}

class RelatedProduct {
  final String id;
  final String name;
  final String price;
  final String image;

  RelatedProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });
}
