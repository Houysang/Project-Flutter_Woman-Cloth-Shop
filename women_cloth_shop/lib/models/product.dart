class Product {
  final String id;
  final String image;
  final List<String> images;
  final String name;
  final String price;
  final double rating;
  final int reviewCount;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    this.rating = 4.5,
    this.reviewCount = 120,
    this.image = '',
    this.images = const [],
  });

  String get coverImage => image.isNotEmpty ? image : (images.isNotEmpty ? images.first : '');

  List<String> get allImages => images.isNotEmpty ? images : (image.isNotEmpty ? [image] : []);
}