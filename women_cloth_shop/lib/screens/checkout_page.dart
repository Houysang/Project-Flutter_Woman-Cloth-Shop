import 'package:flutter/material.dart';
import '../components/app_footer.dart';
import '../models/cart_store.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _cardCtrl = TextEditingController();

  double get subtotal {
    double sum = 0;
    for (final c in cart) {
      final p =
          double.tryParse(c.price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
      sum += p * c.quantity;
    }
    return sum;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _addressCtrl.dispose();
    _cardCtrl.dispose();
    super.dispose();
  }

  void _placeOrder() {
    if (!_formKey.currentState!.validate()) return;

    // In a real app you'd call payment APIs here.
    final customer = _nameCtrl.text.trim();
    final orderTotal = subtotal;

    clearCart();

    Navigator.pushReplacementNamed(
      context,
      '/order_confirmation',
      arguments: {'customer': customer, 'total': orderTotal},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text('Checkout', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const Text(
                      'Shipping Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _nameCtrl,
                      decoration: const InputDecoration(labelText: 'Full name'),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Please enter your name'
                          : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _addressCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Shipping address',
                      ),
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Please enter an address'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Payment',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _cardCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Card number',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (v) => (v == null || v.trim().length < 8)
                          ? 'Enter a valid card'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '\$${subtotal.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: cart.isEmpty ? null : _placeOrder,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: const SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    'PLACE ORDER',
                    style: TextStyle(letterSpacing: 1.2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
      bottomNavigationBar: AppFooter(
        currentIndex: 1,
        onTap: (i) => AppFooter.navigateTo(context, i),
      ),
    );
  }
}
