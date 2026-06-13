import 'cart_store.dart';

enum OrderStatus {
  pending,
  processing,
  shipped,
  delivered,
}

class Order {
  final String id;
  final List<CartItem> items;
  final double totalPrice;
  final DateTime date;
  final OrderStatus status;

  Order({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.date,
    required this.status,
  });
}
