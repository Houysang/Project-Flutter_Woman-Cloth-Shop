import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/cart_store.dart';
import '../models/wishlist_store.dart';

class GlassBottomNavWidget extends StatefulWidget {
  final int selectedIndex;

  const GlassBottomNavWidget({super.key, this.selectedIndex = 0});

  @override
  State<GlassBottomNavWidget> createState() => _GlassBottomNavWidgetState();
}

class _GlassBottomNavWidgetState extends State<GlassBottomNavWidget> {
  int _cartCount = cart.length;
  int _wishlistCount = wishlist.length;

  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  @override
  void initState() {
    super.initState();
    _cartCount = cart.length;
    _wishlistCount = wishlist.length;

    onCartCountChanged = (count) {
      if (mounted) {
        setState(() => _cartCount = count);
      }
    };
    onWishlistCountChanged = (count) {
      if (mounted) {
        setState(() => _wishlistCount = count);
      }
    };
  }

  @override
  void dispose() {
    onCartCountChanged = null;
    onWishlistCountChanged = null;
    super.dispose();
  }

  final List<_NavItem> _navItems = [
    _NavItem(
        icon: Icons.store_outlined, activeIcon: Icons.store, label: 'Shop'),
    _NavItem(
        icon: Icons.favorite_outline,
        activeIcon: Icons.favorite,
        label: 'Wishlist'),
    _NavItem(
        icon: Icons.shopping_bag_outlined,
        activeIcon: Icons.shopping_bag,
        label: 'Cart'),
    _NavItem(
        icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile'),
  ];

  void _onItemTap(int index) {
    final routes = ['/shop', '/wishlist', '/cart', '/profile'];
    Navigator.pushNamed(context, routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            height: 68,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.88),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
                BoxShadow(
                  color: accent.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(_navItems.length, (i) {
                final item = _navItems[i];
                final isSelected = i == widget.selectedIndex;
                final badgeCount = i == 1
                    ? _wishlistCount
                    : i == 2
                        ? _cartCount
                        : 0;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => _onItemTap(i),
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutBack,
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: isSelected ? 4 : 0,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? accent.withOpacity(0.12)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              AnimatedContainer(
                                duration:
                                    const Duration(milliseconds: 250),
                                curve: Curves.easeOutBack,
                                child: Icon(
                                  isSelected ? item.activeIcon : item.icon,
                                  size: isSelected ? 24 : 22,
                                  color: isSelected
                                      ? accent
                                      : Colors.grey[400],
                                ),
                              ),
                              if (badgeCount > 0)
                                Positioned(
                                  right: -8,
                                  top: -4,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints:
                                        const BoxConstraints(
                                            minWidth: 18, minHeight: 18),
                                    child: Text(
                                      badgeCount > 99
                                          ? '99+'
                                          : '$badgeCount',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          AnimatedDefaultTextStyle(
                            duration:
                                const Duration(milliseconds: 250),
                            style: GoogleFonts.comfortaa(
                              fontSize: isSelected ? 11 : 10,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color:
                                  isSelected ? accent : Colors.grey[400],
                            ),
                            child: Text(item.label),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}