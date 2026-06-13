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

// Simple in-memory cart store
final List<CartItem> cart = <CartItem>[];

// Add item to cart
void addToCart(CartItem item) {
  final existing = cart.indexWhere(
    (c) => c.id == item.id && c.color == item.color && c.size == item.size,
  );

  if (existing >= 0) {
    cart[existing].quantity += item.quantity;
  } else {
    cart.insert(0, item);
  }
}

// Remove specific variant
void removeFromCart(
  String id,
  String color,
  String size,
) {
  cart.removeWhere(
    (c) => c.id == id && c.color == color && c.size == size,
  );
}

// Clear cart
void clearCart() {
  cart.clear();
}
