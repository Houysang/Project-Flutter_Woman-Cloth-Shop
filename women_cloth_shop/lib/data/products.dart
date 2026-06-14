import '../models/product.dart';

class ProductData {
  static const List<Product> products = [
    Product(
      id: 'product_001',
      image: 'assets/images/fashion4.jpg',
      name: 'Silk Blouse',
      price: '\$59',
      rating: 4.8,
      reviewCount: 234,
    ),
    Product(
      id: 'product_002',
      image: 'assets/images/fashion2.jpg',
      name: 'Elegant Dress',
      price: '\$79',
      rating: 4.6,
      reviewCount: 189,
    ),
    Product(
      id: 'product_003',
      image: 'assets/images/fashion3.jpg',
      name: 'Summer Top',
      price: '\$49',
      rating: 4.3,
      reviewCount: 97,
    ),
     Product(
      id: 'product_004',
      image: 'assets/images/fashion5.jpg',
      name: 'Silk Blouse',
      price: '\$59',
      rating: 4.8,
      reviewCount: 234,
    ),
    Product(
      id: 'product_005',
      image: 'assets/images/fashion6.jpg',
      name: 'Elegant Dress',
      price: '\$79',
      rating: 4.6,
      reviewCount: 189,
    ),
  ];
}