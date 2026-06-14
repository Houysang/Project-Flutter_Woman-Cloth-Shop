import '../services/firestore_service.dart';

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

/// Local in-memory wishlist cache. Changes are synced to Firestore.
final List<WishlistItem> wishlist = <WishlistItem>[];
final FirestoreService _firestore = FirestoreService();

/// Callback for count changes
typedef WishlistCountCallback = void Function(int count);
WishlistCountCallback? onWishlistCountChanged;

void _notifyCountChange() {
  if (onWishlistCountChanged != null) {
    onWishlistCountChanged!(wishlist.length);
  }
}

/// Load wishlist from Firestore into local cache
Future<void> loadWishlistFromFirestore() async {
  final items = await _firestore.loadWishlistFromFirestore();
  wishlist.clear();
  wishlist.addAll(items);
  _notifyCountChange();
}

/// Add to wishlist (local + Firestore). Avoids duplicates by id.
void addToWishlist(WishlistItem item) {
  if (!wishlist.any((w) => w.id == item.id)) {
    wishlist.insert(0, item);
    _firestore.addToWishlistFirestore(item);
    _notifyCountChange();
  }
}

/// Remove from wishlist by id (local + Firestore)
void removeFromWishlistById(String id) {
  wishlist.removeWhere((w) => w.id == id);
  _firestore.removeFromWishlistFirestore(id);
  _notifyCountChange();
}