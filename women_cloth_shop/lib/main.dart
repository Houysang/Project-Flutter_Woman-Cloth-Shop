import 'package:flutter/material.dart';
import 'screens/outfit_builder_screen.dart';

void main() {
  runApp(const OnlyWomenApp());
}

class OnlyWomenApp extends StatelessWidget {
  const OnlyWomenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OnlyWomen',
      theme: ThemeData(
        fontFamily: 'Georgia',
        scaffoldBackgroundColor: const Color(0xFFFAF9F6),
      ),
      home: const OutfitBuilderScreen(),
    );
  }
}
