import '../services/firestore_service.dart';
import 'order.dart';
import 'package:flutter/foundation.dart';

List<Order> orderHistory = [];
final FirestoreService _firestore = FirestoreService();

/// Callback for when orders are loaded
typedef OrdersLoadedCallback = void Function(List<Order> orders);
OrdersLoadedCallback? onOrdersLoaded;

/// Save order to Firestore and local cache
Future<void> saveOrder(Order order) async {
  orderHistory.insert(0, order);
  await _firestore.saveOrderToFirestore(order);
}

/// Load orders from Firestore into local cache
Future<void> loadOrdersFromFirestore() async {
  final orders = await _firestore.loadOrdersFromFirestore();
  orderHistory.clear();
  orderHistory.addAll(orders);
  if (onOrdersLoaded != null) {
    onOrdersLoaded!(orderHistory);
  }
}