import 'package:flutter/material.dart';
import 'screens/lookbook_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/map_screen.dart';

void main() {
  runApp(const OutfitBuilderApp());
}

class OutfitBuilderApp extends StatelessWidget {
  const OutfitBuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Outfit Builder',

      // ✅ START FROM LOOKBOOK (better app flow)
      home: const LookbookPage(),

      // ✅ START FROM BOOKING PAGE
      //home: const BookingPage(),

      // ✅ START FROM CHAT PAGE
      //home: const ChatPage(),

      // ✅ START FROM MAP PAGE
      //home: const MapPage(),
    );
  }
}
