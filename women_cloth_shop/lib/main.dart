import 'package:flutter/material.dart';
import 'screens/product_detail_page.dart';
import 'screens/wishlist_page.dart';
import 'screens/cart_page.dart';
import 'screens/checkout_page.dart';
import 'screens/order_confirmation_page.dart';
import 'components/app_footer.dart';
import 'components/floating_cart_button.dart';
import 'models/wishlist_store.dart';
import 'models/cart_store.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'screens/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Women Cloth Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      routes: {
        '/shop': (context) => const ProductDetailPage(productId: 'product_001'),
        '/wishlist': (context) =>
            WishlistPage(items: wishlist, currentProductId: 'product_001'),
        '/cart': (context) => const CartPage(),
        '/bag': (context) => const CartPage(),
        '/checkout': (context) => const CheckoutPage(),
        '/order_confirmation': (context) => const OrderConfirmationPage(),
        '/profileuser': (context) => ProfilePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
