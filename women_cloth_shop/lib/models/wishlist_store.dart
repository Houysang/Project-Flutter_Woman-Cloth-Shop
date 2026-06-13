class WishlistItem {
  final String id;
  final String title;
  final String price;
  final String image;
  final String tag;

  const WishlistItem({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.tag,
  });
}

// Simple in-memory wishlist store used by pages and components.
final List<WishlistItem> wishlist = <WishlistItem>[];

void addToWishlist(WishlistItem item) {
  // Avoid duplicates by id
  if (!wishlist.any((w) => w.id == item.id)) {
    wishlist.insert(0, item);
  }
}

void removeFromWishlistById(String id) {
  wishlist.removeWhere((w) => w.id == id);
}
