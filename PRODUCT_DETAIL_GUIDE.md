# Product Detail Page - Component Documentation

A complete, production-ready product detail page for an e-commerce Flutter app with reusable, well-organized components.

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point
├── models/
│   └── product_model.dart             # Data models for products
├── components/
│   ├── image_gallery.dart             # Image carousel with thumbnails
│   ├── color_swatches.dart            # Color selection component
│   ├── size_selector.dart             # Size picker with guide
│   ├── model_info_note.dart           # Model dimensions info card
│   ├── add_to_cart_favorite.dart      # Cart & favorite buttons
│   └── style_it_with.dart             # Related products section
└── screens/
    └── product_detail_page.dart       # Main product detail screen
```

## 🎯 Components Overview

### 1. **ImageGallery** (`image_gallery.dart`)
Interactive image carousel with thumbnail indicators.

**Features:**
- PageView for smooth image swiping
- Thumbnail navigation below main image
- Image counter (e.g., "1/4")
- Error handling for failed image loads

**Usage:**
```dart
ImageGallery(
  images: [
    'https://example.com/image1.jpg',
    'https://example.com/image2.jpg',
  ],
)
```

---

### 2. **ColorSwatches** (`color_swatches.dart`)
Color selection component with visual swatches.

**Features:**
- Circular color indicators
- Color name labels
- Visual feedback for selected color
- Hex color support

**Usage:**
```dart
ColorSwatches(
  colors: [
    {'name': 'Beige', 'hex': '#D4C5B9'},
    {'name': 'Black', 'hex': '#1A1A1A'},
  ],
  selectedColor: 'Beige',
  onColorSelected: (color) {
    print('Selected: $color');
  },
)
```

---

### 3. **SizeSelector** (`size_selector.dart`)
Size picker with integrated size guide modal.

**Features:**
- Size options (XS, S, M, L, XL, etc.)
- Visual selection indicator
- "Size Guide" link opens modal
- Size guide table with measurements

**Usage:**
```dart
SizeSelector(
  sizes: ['XS', 'S', 'M', 'L', 'XL'],
  selectedSize: 'M',
  onSizeSelected: (size) {
    print('Selected size: $size');
  },
)
```

---

### 4. **ModelInfoNote** (`model_info_note.dart`)
Information card displaying model's height and size.

**Features:**
- Info icon with subtle styling
- Model height and wearing size
- Brown theme matching design
- Lightweight component

**Usage:**
```dart
ModelInfoNote(
  modelHeight: "5'8\"",
  modelSize: 'M',
)
```

---

### 5. **AddToCartFavorite** (`add_to_cart_favorite.dart`)
Action buttons for cart and favorites.

**Features:**
- Prominent "Add to Cart" button
- Heart icon favorite toggle
- Price display with strike-through original price
- SnackBar feedback messages
- Shipping info note

**Usage:**
```dart
AddToCartFavorite(
  price: '\$895',
  isFavorited: false,
  onAddToCart: () {
    // Add to cart logic
  },
  onToggleFavorite: () {
    // Toggle favorite logic
  },
)
```

---

### 6. **StyleItWithSection** (`style_it_with.dart`)
Horizontal scrollable list of related products.

**Features:**
- Horizontally scrollable product cards
- Product image with hover overlay
- Rating and review count
- Price display
- Responsive to taps

**Related Item Model:**
```dart
RelatedItem(
  id: '1',
  name: 'Product Name',
  price: '\$125',
  image: 'https://example.com/image.jpg',
  rating: 4.8,
  reviewCount: 89,
)
```

**Usage:**
```dart
StyleItWithSection(
  relatedItems: [
    RelatedItem(...),
    RelatedItem(...),
  ],
  onItemTap: (itemId) {
    // Navigate to product detail
  },
)
```

---

## 📊 Data Models

### **Product Model**
```dart
class Product {
  final String id;
  final String name;
  final String price;
  final String description;
  final List<String> images;
  final List<Color> colors;
  final List<String> sizes;
  final String modelHeight;
  final String modelSize;
  final double rating;
  final int reviews;
  final List<RelatedProduct> relatedItems;
}
```

### **Color Model**
```dart
class Color {
  final String name;
  final String colorCode; // Hex format: '#D4C5B9'
}
```

---

## 🎨 Design Features

- **Theme Colors**: Brown-based theme (suitable for fashion)
- **Spacing**: Consistent 16px base spacing
- **Typography**: Clear hierarchy with bold headers
- **Icons**: Material Design icons throughout
- **Responsive**: Works on all screen sizes
- **Accessibility**: Proper contrast and touch targets

---

## 🚀 Quick Start

1. **Import the screen:**
```dart
import 'screens/product_detail_page.dart';

// In your app
home: const ProductDetailPage(productId: 'product_001'),
```

2. **Customize sample data** in `ProductDetailPage`:
   - Update product images URLs
   - Modify colors and sizes
   - Add your related products

3. **Connect to API** - Replace sample data with API calls:
```dart
@override
void initState() {
  super.initState();
  _fetchProductData();
}

Future<void> _fetchProductData() async {
  // Fetch from your API
}
```

---

## 💡 Component Customization

### Change Theme Color
Edit the brown color in components. Example for `SizeSelector`:
```dart
// Instead of Colors.brown, use your color
color: Colors.purple,  // Your custom color
```

### Modify Product Details
In `ProductDetailPage.productData`, update:
- `name`, `price`, `description`
- `images` list (image URLs)
- `colors` (with hex codes)
- `sizes` array
- `relatedItems` list

### Add More Product Details
Extend the `_buildAdditionalSection()` in `ProductDetailPage` to show more details like:
- Material composition
- Care instructions
- Return policy
- Customer reviews

---

## 🔧 Integration Tips

### State Management
Current implementation uses `setState()`. For a larger app, consider:
- **Provider** for simple state
- **Riverpod** for advanced state
- **BLoC** for complex logic

### API Integration
Replace sample data in `productData` getter with:
```dart
Future<Map> _fetchProduct() async {
  final response = await http.get('api/products/$productId');
  return jsonDecode(response.body);
}
```

### Navigation
Replace `print()` statements with navigation:
```dart
void _handleRelatedItemTap(String itemId) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ProductDetailPage(productId: itemId),
    ),
  );
}
```

---

## 📝 Notes

- All components are **stateful** and manage their own state
- Components use **callbacks** for parent-child communication
- **Error handling** included for image failures
- Sample data included for testing
- Ready for production with minor customizations

---

## ✨ Features Included

✅ Image gallery with carousel  
✅ Color swatch selection  
✅ Size picker with guide modal  
✅ Model info display  
✅ Add to cart functionality  
✅ Favorite/wishlist toggle  
✅ Related products section  
✅ Product details section  
✅ Responsive design  
✅ Error handling  
✅ User feedback (SnackBars)  

---

**Happy coding! 🎉**
