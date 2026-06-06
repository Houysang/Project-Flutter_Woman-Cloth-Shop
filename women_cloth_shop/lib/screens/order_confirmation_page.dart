import 'dart:async';

import 'package:flutter/material.dart';
import '../components/app_footer.dart';
import '../components/floating_cart_button.dart';

class OrderConfirmationPage extends StatefulWidget {
  const OrderConfirmationPage({super.key});

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  int currentStep = 0;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          currentStep = 1;
        });
      }
    });

    Timer(const Duration(seconds: 6), () {
      if (mounted) {
        setState(() {
          currentStep = 2;
        });
      }
    });

    Timer(const Duration(seconds: 9), () {
      if (mounted) {
        setState(() {
          currentStep = 3;
        });
      }
    });
  }

  Widget trackingStep({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool completed,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              icon,
              color: completed ? Colors.green : Colors.grey,
              size: 28,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 20,
                color: completed ? Colors.green : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: completed ? Colors.black : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
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

    final customer = args != null && args['customer'] != null
        ? args['customer'] as String
        : null;

    final total =
        args != null && args['total'] != null ? args['total'] as double : null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          'Order Confirmed',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 10),
            Text(
              'Thank you${customer != null ? ', $customer' : ''}!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Your order${total != null ? ' of \$${total.toStringAsFixed(0)}' : ''} has been placed successfully.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              getStatusText(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Tracking',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  trackingStep(
                    icon: Icons.check_circle,
                    title: 'Order Confirmed',
                    subtitle: 'Your order has been received.',
                    completed: currentStep >= 0,
                  ),
                  trackingStep(
                    icon: Icons.inventory_2,
                    title: 'Processing',
                    subtitle: 'Preparing your order.',
                    completed: currentStep >= 1,
                  ),
                  trackingStep(
                    icon: Icons.local_shipping,
                    title: 'Shipped',
                    subtitle: 'Your package is on the way.',
                    completed: currentStep >= 2,
                  ),
                  trackingStep(
                    icon: Icons.home,
                    title: 'Delivered',
                    subtitle: 'Delivered to your address.',
                    completed: currentStep >= 3,
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/shop',
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                ),
                child: const Text(
                  'CONTINUE SHOPPING',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const FloatingCartButton(),
      bottomNavigationBar: AppFooter(
        currentIndex: 0,
        onTap: (i) => AppFooter.navigateTo(context, i),
      ),
    );
  }
}
