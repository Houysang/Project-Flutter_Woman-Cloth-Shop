import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
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
import 'pages/home_page.dart';
import 'screens/tops_page.dart';
import 'screens/skirts_page.dart';
import 'screens/bags_page.dart';
import 'screens/booking_page.dart';
import 'screens/view_booking_page.dart';
import 'screens/manage_booking_page.dart';
import 'screens/profile_page.dart';
import 'screens/chat_page.dart';
import 'screens/outfit_builder_page.dart';
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
        '/tops': (context) => const TopsPage(),
        '/skirts': (context) => const SkirtsPage(),
        '/bags': (context) => const BagsPage(),
        '/cart': (context) => const CartPage(),
        '/bag': (context) => const CartPage(),
        '/checkout': (context) => const CheckoutPage(),
        '/order_confirmation': (context) => const OrderConfirmationPage(),
        '/profileuser': (context) => const ProfilePage(),
        '/booking': (context) => const BookingPage(),
        '/view-booking': (context) => const ViewBookingPage(),
        '/manage-booking': (context) => const ManageBookingPage(),
        '/chat': (context) => const ChatPage(),
        '/outfit-builder': (context) => const OutfitBuilderPage(),
        '/profile': (context) => const ProfilePage(),
        '/about': (context) => const AboutAppPage(),
        '/contact': (context) => const ContactPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}