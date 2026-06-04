import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppFooter({super.key, required this.currentIndex, required this.onTap});

  static Future<void> navigateTo(BuildContext context, int index) async {
    String? route;
    switch (index) {
      case 0:
        route = '/shop';
        break;
      case 1:
        route = '/cart';
        break;
      case 2:
        route = '/wishlist';
        break;
      case 3:
        route = '/profile';
        break;
    }
    if (route != null) {
      await Navigator.pushNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.brown,
      unselectedItemColor: Colors.grey[600],
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.store_outlined),
          label: 'Shop',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined),
          label: 'Bag',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}
