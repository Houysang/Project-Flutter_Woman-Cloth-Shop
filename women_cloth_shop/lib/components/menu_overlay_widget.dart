import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItemData {
  final IconData icon;
  final String label;
  final String route;
  final bool isDestructive;

  const MenuItemData({
    required this.icon,
    required this.label,
    required this.route,
    this.isDestructive = false,
  });
}

class MenuOverlayWidget extends StatelessWidget {
  final VoidCallback onClose;
  final String currentRoute;

  const MenuOverlayWidget({
    super.key,
    required this.onClose,
    this.currentRoute = '/shop',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Row(
        children: [
          // Menu panel
          GestureDetector(
            onTap: () {},
            child: Container(
              width: MediaQuery.of(context).size.width * 0.65,
              height: double.infinity,
              color: const Color(0xFFF9F7F2),
              child: Column(
                children: [
                  // Close button
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: onClose,
                      child: Container(
                        margin: const EdgeInsets.only(top: 12, right: 12),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Color(0xFF2D2926),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  // Menu content
                  Expanded(
                    child: _MenuContent(
                      currentRoute: currentRoute,
                      onItemTap: (item) {
                        onClose();
                        _navigateToRoute(context, item);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Dismiss area
          Expanded(
            child: Container(
              color: Colors.black.withOpacity(0.35),
              child: const Center(
                child: Text(
                  "⋮",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 32,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToRoute(BuildContext context, MenuItemData item) {
    if (item.route == '/logout') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Logging out..."),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }
    try {
      Navigator.pushReplacementNamed(context, item.route);
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${item.label} page coming soon"),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }
}

class _MenuContent extends StatelessWidget {
  final String currentRoute;
  final void Function(MenuItemData) onItemTap;

  const _MenuContent({
    this.currentRoute = '/shop',
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      MenuItemData(icon: Icons.home_outlined, label: "Home", route: '/shop'),
      MenuItemData(icon: Icons.person_outline, label: "Profile Setting", route: '/profile'),
      MenuItemData(icon: Icons.calendar_today_outlined, label: "Booking", route: '/booking'),
      MenuItemData(icon: Icons.info_outlined, label: "About Us", route: '/about'),
      MenuItemData(icon: Icons.mail_outline, label: "Contact", route: '/contact'),
      MenuItemData(icon: Icons.logout, label: "Logout", route: '/logout', isDestructive: true),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Center(
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC5A081).withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, size: 24, color: Color(0xFFC5A081)),
                ),
                const SizedBox(height: 8),
                Text(
                  "Hello!",
                  style: GoogleFonts.comfortaa(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2D2926),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(height: 1, color: const Color(0xFFC5A081).withOpacity(0.1)),
          const SizedBox(height: 8),

          // Menu items
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: items.length,
              itemBuilder: (context, i) {
                final item = items[i];
                final isActive = item.route == currentRoute;
                return GestureDetector(
                  onTap: () => onItemTap(item),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    margin: const EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      color: isActive ? const Color(0xFFC5A081).withOpacity(0.1) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: isActive ? Border.all(color: const Color(0xFFC5A081).withOpacity(0.3)) : null,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.icon,
                          size: 18,
                          color: item.isDestructive ? Colors.red : const Color(0xFFC5A081),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          item.label,
                          style: GoogleFonts.comfortaa(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: item.isDestructive ? Colors.red : const Color(0xFF2D2926),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Brand signature
          Center(
            child: Text(
              "NEARY FASHION",
              style: GoogleFonts.comfortaa(
                fontSize: 10,
                letterSpacing: 3,
                color: Colors.black26,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}