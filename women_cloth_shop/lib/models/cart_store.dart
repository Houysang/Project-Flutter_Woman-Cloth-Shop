import '../services/firestore_service.dart';

class CartItem {
  final String id;
  final String title;
  final String price;
  final String image;
  final String color;
  final String size;

  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.color,
    required this.size,
    this.quantity = 1,
  });
}

/// In-memory cart store (local cache). Changes are synced to Firestore.
final List<CartItem> cart = <CartItem>[];
final FirestoreService _firestore = FirestoreService();

/// Callback for count changes (used by navbar badges)
typedef CartCountCallback = void Function(int count);
CartCountCallback? onCartCountChanged;

void _notifyCountChange() {
  if (onCartCountChanged != null) {
    onCartCountChanged!(cart.length);
  }
}

/// Load cart from Firestore into local cache
Future<void> loadCartFromFirestore() async {
  final items = await _firestore.loadCartFromFirestore();
  cart.clear();
  cart.addAll(items);
  _notifyCountChange();
}

/// Add item to cart (local + Firestore)
void addToCart(CartItem item) {
  final existing = cart.indexWhere(
    (c) => c.id == item.id && c.color == item.color && c.size == item.size,
  );

  if (existing >= 0) {
    cart[existing].quantity += item.quantity;
  } else {
    cart.insert(0, item);
  }

  // Sync to Firestore
  _firestore.addToCartFirestore(item);
  _notifyCountChange();
}

/// Remove specific variant (local + Firestore)
void removeFromCart(String id, String color, String size) {
  cart.removeWhere(
    (c) => c.id == id && c.color == color && c.size == size,
  );

  // Sync to Firestore
  _firestore.removeFromCartFirestore(id);
  _notifyCountChange();
}

/// Clear cart (local + Firestore)
void clearCart() {
  cart.clear();
  _firestore.clearCartFirestore();
  _notifyCountChange();
}