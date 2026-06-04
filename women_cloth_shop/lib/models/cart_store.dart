class CartItem {
  final String id;
  final String title;
  final String price;
  final String image;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
}

// Simple in-memory cart store
final List<CartItem> cart = <CartItem>[];

void addToCart(CartItem item) {
  final existing = cart.indexWhere((c) => c.id == item.id);
  if (existing >= 0) {
    cart[existing].quantity += item.quantity;
  } else {
    cart.insert(0, item);
  }
}

void removeFromCartById(String id) {
  cart.removeWhere((c) => c.id == id);
}

void clearCart() {
  cart.clear();
}
