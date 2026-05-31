import 'package:flutter/material.dart';
import '../components/app_footer.dart';
import '../components/floating_cart_button.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final customer = args != null && args['customer'] != null
        ? args['customer'] as String
        : null;
    final total = args != null && args['total'] != null
        ? args['total'] as double
        : null;

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
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 84,
            ),
            const SizedBox(height: 18),
            Text(
              'Thank you${customer != null ? ', $customer' : ''}!',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              'Your order${total != null ? ' of \$${total.toStringAsFixed(0)}' : ''} has been placed successfully.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                '/shop',
                (r) => false,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
              ),
              child: const Text('CONTINUE SHOPPING'),
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
