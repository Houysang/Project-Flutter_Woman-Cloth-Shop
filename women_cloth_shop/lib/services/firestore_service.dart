import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:firebase_auth/firebase_auth.dart';
import '../models/cart_store.dart';
import '../models/wishlist_store.dart';
import '../models/order.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _uid => _auth.currentUser?.uid;

  // ─────────────── CART ───────────────

  CollectionReference<Map<String, dynamic>> get _cartRef =>
      _firestore.collection('users').doc(_uid).collection('cart');

  Future<void> addToCartFirestore(CartItem item) async {
    await _cartRef.doc(item.id).set({
      'id': item.id,
      'title': item.title,
      'price': item.price,
      'image': item.image,
      'color': item.color,
      'size': item.size,
      'quantity': item.quantity,
      'addedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> removeFromCartFirestore(String id) async {
    await _cartRef.doc(id).delete();
  }

  Future<void> updateCartQuantityFirestore(String id, int quantity) async {
    await _cartRef.doc(id).update({'quantity': quantity});
  }

  Future<void> clearCartFirestore() async {
    final snap = await _cartRef.get();
    for (final doc in snap.docs) {
      await doc.reference.delete();
    }
  }

  Future<List<CartItem>> loadCartFromFirestore() async {
    final snap = await _cartRef.orderBy('addedAt', descending: true).get();
    return snap.docs.map((doc) {
      final data = doc.data();
      return CartItem(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        price: data['price'] ?? '',
        image: data['image'] ?? '',
        color: data['color'] ?? '',
        size: data['size'] ?? '',
        quantity: data['quantity'] ?? 1,
      );
    }).toList();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get cartStream =>
      _cartRef.orderBy('addedAt', descending: true).snapshots();

  // ─────────────── WISHLIST ───────────────

  CollectionReference<Map<String, dynamic>> get _wishlistRef =>
      _firestore.collection('users').doc(_uid).collection('wishlist');

  Future<void> addToWishlistFirestore(WishlistItem item) async {
    await _wishlistRef.doc(item.id).set({
      'id': item.id,
      'title': item.title,
      'price': item.price,
      'image': item.image,
      'tag': item.tag,
      'addedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> removeFromWishlistFirestore(String id) async {
    await _wishlistRef.doc(id).delete();
  }

  Future<void> clearWishlistFirestore() async {
    final snap = await _wishlistRef.get();
    for (final doc in snap.docs) {
      await doc.reference.delete();
    }
  }

  Future<List<WishlistItem>> loadWishlistFromFirestore() async {
    final snap =
        await _wishlistRef.orderBy('addedAt', descending: true).get();
    return snap.docs.map((doc) {
      final data = doc.data();
      return WishlistItem(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        price: data['price'] ?? '',
        image: data['image'] ?? '',
        tag: data['tag'] ?? '',
      );
    }).toList();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get wishlistStream =>
      _wishlistRef.orderBy('addedAt', descending: true).snapshots();

  // ─────────────── ORDERS ───────────────

  CollectionReference<Map<String, dynamic>> get _ordersRef =>
      _firestore.collection('users').doc(_uid).collection('orders');

  Future<void> saveOrderToFirestore(Order order) async {
    await _ordersRef.doc(order.id).set({
      'id': order.id,
      'totalPrice': order.totalPrice,
      'date': order.date.toIso8601String(),
      'status': order.status.name,
      'items': order.items
          .map((item) => {
                'id': item.id,
                'title': item.title,
                'price': item.price,
                'image': item.image,
                'color': item.color,
                'size': item.size,
                'quantity': item.quantity,
              })
          .toList(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<Order>> loadOrdersFromFirestore() async {
    final snap = await _ordersRef.orderBy('createdAt', descending: true).get();
    return snap.docs.map((doc) {
      final data = doc.data();
      final items = (data['items'] as List<dynamic>).map((itemData) {
        final item = itemData as Map<String, dynamic>;
        return CartItem(
          id: item['id'] ?? '',
          title: item['title'] ?? '',
          price: item['price'] ?? '',
          image: item['image'] ?? '',
          color: item['color'] ?? '',
          size: item['size'] ?? '',
          quantity: item['quantity'] ?? 1,
        );
      }).toList();

      return Order(
        id: data['id'] ?? '',
        items: items,
        totalPrice: (data['totalPrice'] ?? 0.0).toDouble(),
        date: DateTime.tryParse(data['date'] ?? '') ?? DateTime.now(),
        status: _parseStatus(data['status'] ?? 'pending'),
      );
    }).toList();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get ordersStream =>
      _ordersRef.orderBy('createdAt', descending: true).snapshots();

  OrderStatus _parseStatus(String status) {
    switch (status) {
      case 'processing':
        return OrderStatus.processing;
      case 'shipped':
        return OrderStatus.shipped;
      case 'delivered':
        return OrderStatus.delivered;
      default:
        return OrderStatus.pending;
    }
  }
}