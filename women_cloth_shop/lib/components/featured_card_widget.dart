import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturedCardWidget extends StatefulWidget {
  const FeaturedCardWidget({super.key});

  @override
  State<FeaturedCardWidget> createState() => _FeaturedCardWidgetState();
}

class _FeaturedCardWidgetState extends State<FeaturedCardWidget> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  final List<String> _images = [
    'assets/images/f1.gif',
    '../../assets/images/promotion5.jpg',
    '../../assets/images/promotion3.webp',
  ];

  final List<String> _titles = [
    "Flash Sales\n2026",
    "New Collection\nSummer 2026",
    "Spring Vibes\nCollection",
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_currentPage < _images.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            // PageView of images
            PageView(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentPage = index),
              children: List.generate(_images.length, (i) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    _images[i],
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                );
              }),
            ),

            // Gradient overlay so text is readable
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
            ),

            // Title text
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Text(
                _titles[_currentPage],
                style: GoogleFonts.comfortaa(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2926),
                ),
              ),
            ),

            // Dots indicator
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_images.length, (i) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: _currentPage == i ? 18 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: _currentPage == i
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}