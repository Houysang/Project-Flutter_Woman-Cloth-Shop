import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/wishlist_page.dart';
import 'screens/cart_page.dart';
import 'screens/checkout_page.dart';
import 'screens/order_confirmation_page.dart';
import 'models/wishlist_store.dart';
import 'login_page.dart';
import 'pages/home_page.dart';
import 'screens/dress_page.dart';
import 'screens/tops_page.dart';
import 'screens/skirts_page.dart';
import 'screens/bags_page.dart';
import 'screens/profile_page.dart';
import 'screens/about_app_page.dart';
import 'screens/contact_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        '/shop': (context) => const HomePage(),
        '/wishlist': (context) =>
            WishlistPage(items: wishlist, currentProductId: 'product_001'),
        '/dresses': (context) => const DressPage(),
        '/tops': (context) => const TopsPage(),
        '/skirts': (context) => const SkirtsPage(),
        '/bags': (context) => const BagsPage(),
        '/cart': (context) => const CartPage(),
        '/bag': (context) => const CartPage(),
        '/checkout': (context) => const CheckoutPage(),
        '/order_confirmation': (context) => const OrderConfirmationPage(),
        '/profile': (context) => const ProfilePage(),
        '/about': (context) => const AboutAppPage(),
        '/contact': (context) => const ContactPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
