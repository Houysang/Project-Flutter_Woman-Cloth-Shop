import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/glass_bottom_nav_widget.dart';
import '../models/cart_store.dart';
import '../screens/order_history_page.dart';

class OrderConfirmationPage extends StatefulWidget {
  const OrderConfirmationPage({super.key});

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage>
    with SingleTickerProviderStateMixin {
  int currentStep = 0;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);
  static const Color bgLight = Color(0xFFF9F7F2);

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => currentStep = 1);
    });
    Timer(const Duration(seconds: 6), () {
      if (mounted) setState(() => currentStep = 2);
    });
    Timer(const Duration(seconds: 9), () {
      if (mounted) setState(() => currentStep = 3);
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Widget _buildAmbientCircle(
      double size, Color color, double? left, double? top,
      {double blur = 60}) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.15),
        ),
      ),
    );
  }

  Widget _buildTrackingOrb({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool completed,
    required bool active,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline column
          Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                width: completed ? 44 : 36,
                height: completed ? 44 : 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: completed ? accent : Colors.transparent,
                  border: Border.all(
                    color: completed ? accent : Colors.grey.shade300,
                    width: completed ? 0 : 1.5,
                  ),
                  boxShadow: completed
                      ? [
                          BoxShadow(
                            color: accent.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: active && !completed
                      ? SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(accent),
                          ),
                        )
                      : Icon(
                          completed ? Icons.check : icon,
                          size: completed ? 20 : 18,
                          color:
                              completed ? Colors.white : Colors.grey.shade400,
                        ),
                ),
              ),
              if (!isLast)
                Container(
                  width: 1.5,
                  height: 40,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        completed ? accent : Colors.grey.shade200,
                        Colors.grey.shade200,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: completed ? 8 : 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.comfortaa(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: completed ? darkText : Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.comfortaa(
                      fontSize: 12,
                      color: completed ? Colors.black54 : Colors.grey.shade300,
                    ),
                  ),
                  if (!isLast) const SizedBox(height: 36),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getStatusText() {
    switch (currentStep) {
      case 0:
        return 'Order Confirmed';
      case 1:
        return 'Processing Order...';
      case 2:
        return 'Order Shipped';
      case 3:
        return 'Order Delivered';
      default:
        return 'Order Confirmed';
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final customer = args?['customer'] as String?;
    final total = args?['total'] as double?;

    return Scaffold(
      backgroundColor: bgLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: darkText),
        title: Text(
          'Order',
          style: GoogleFonts.comfortaa(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: darkText,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Ambient abstract circles
          _buildAmbientCircle(200, accent, -60, 40),
          _buildAmbientCircle(140, const Color(0xFFE8D5C4), null, 300,
              blur: 80),
          _buildAmbientCircle(100, const Color(0xFFD4B8A0), 260, 500, blur: 60),

          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // ---- SUCCESS ICON AMBIENT ----
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: child,
                    );
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [accent, Color(0xFF8C6A58)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: accent.withValues(alpha: 0.3),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 44,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ---- THANK YOU ----
                Text(
                  'Thank you${customer != null ? ', $customer' : ''}!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.comfortaa(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  total != null
                      ? 'Your order of \$${total.toStringAsFixed(0)} has been gracefully received.'
                      : 'Your order has been gracefully received.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.comfortaa(
                    fontSize: 13,
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 24),

                // ---- STATUS CHIP ----
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: accent.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentStep >= 3 ? Colors.green : accent,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        getStatusText(),
                        style: GoogleFonts.comfortaa(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: darkText,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ---- TRACKING CARD ----
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title line with decorative line
                      Row(
                        children: [
                          Container(
                            width: 3,
                            height: 20,
                            decoration: BoxDecoration(
                              color: accent,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Journey',
                            style: GoogleFonts.comfortaa(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: darkText,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      _buildTrackingOrb(
                        icon: Icons.check_rounded,
                        title: 'Order Confirmed',
                        subtitle: 'Your order has been received.',
                        completed: currentStep >= 0,
                        active: currentStep == 0,
                      ),
                      _buildTrackingOrb(
                        icon: Icons.inventory_2_outlined,
                        title: 'Processing',
                        subtitle: 'Preparing your order.',
                        completed: currentStep >= 1,
                        active: currentStep == 1,
                      ),
                      _buildTrackingOrb(
                        icon: Icons.local_shipping_outlined,
                        title: 'Shipped',
                        subtitle: 'Your package is on the way.',
                        completed: currentStep >= 2,
                        active: currentStep == 2,
                      ),
                      _buildTrackingOrb(
                        icon: Icons.house_outlined,
                        title: 'Delivered',
                        subtitle: 'Arrived at your address.',
                        completed: currentStep >= 3,
                        active: currentStep == 3,
                        isLast: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ---- ORDER DETAILS MINI CARD ----
                if (total != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey.shade100,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: accent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.receipt_long_outlined,
                            color: accent,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order Total',
                              style: GoogleFonts.comfortaa(
                                fontSize: 12,
                                color: Colors.black45,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${total.toStringAsFixed(0)}.00',
                              style: GoogleFonts.comfortaa(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: accent,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'PAID',
                            style: GoogleFonts.comfortaa(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.green,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 30),

                // ---- BUTTONS ----
                // CONTINUE SHOPPING
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/shop',
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'CONTINUE SHOPPING',
                      style: GoogleFonts.comfortaa(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // VIEW ORDER HISTORY
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OrderHistoryPage(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: darkText,
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'VIEW ORDER HISTORY',
                      style: GoogleFonts.comfortaa(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const GlassBottomNavWidget(),
    );
  }
}
