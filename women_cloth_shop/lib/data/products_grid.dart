import '../models/product.dart';

class ProductGridData {
  static const List<Product> products = [
    Product(
      id: 'product_004',
      image: 'assets/images/fashion1.jpg',
      name: 'Summer Dress',
      price: '\$29.99',
      rating: 4.5,
      reviewCount: 156,
    ),
    Product(
      id: 'product_005',
      image: 'assets/images/fashion2.jpg',
      name: 'Elegant Top',
      price: '\$39.99',
      rating: 4.7,
      reviewCount: 203,
    ),
    Product(
      id: 'product_006',
      image: 'assets/images/fashion3.jpg',
      name: 'Casual Shirt',
      price: '\$25.00',
      rating: 4.2,
      reviewCount: 88,
    ),
    Product(
      id: 'product_007',
      image: 'assets/images/fashion4.jpg',
      name: 'Mini Skirt',
      price: '\$19.99',
      rating: 4.4,
      reviewCount: 142,
    ),
    Product(
      id: 'product_008',
      image: 'assets/images/fashion5.jpg',
      name: 'Luxury Bag',
      price: '\$120.00',
      rating: 4.9,
      reviewCount: 312,
    ),
  ];
}