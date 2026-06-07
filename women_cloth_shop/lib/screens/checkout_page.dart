import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/app_footer.dart';
import '../components/checkout/step_indicator.dart';
import '../components/checkout/shipping_address_form.dart';
import '../components/checkout/payment_method_section.dart';
import '../components/checkout/order_review_section.dart';
import '../components/checkout/price_breakdown.dart';
import '../models/cart_store.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _provinceCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  final _scrollController = ScrollController();

  String _selectedPayment = '';
  int _currentStep = 1;

  @override
  void initState() {
    super.initState();

    _firstNameCtrl.addListener(_updateStep);
    _lastNameCtrl.addListener(_updateStep);
    _addressCtrl.addListener(_updateStep);
    _provinceCtrl.addListener(_updateStep);
    _phoneCtrl.addListener(_updateStep);
  }

  bool _isShippingComplete() {
    return _firstNameCtrl.text.trim().isNotEmpty &&
        _lastNameCtrl.text.trim().isNotEmpty &&
        _addressCtrl.text.trim().isNotEmpty &&
        _provinceCtrl.text.trim().isNotEmpty &&
        _phoneCtrl.text.trim().isNotEmpty;
  }

  void _updateStep() {
    setState(() {
      if (!_isShippingComplete()) {
        _currentStep = 1;
      } else if (_selectedPayment.isEmpty) {
        _currentStep = 2;
      } else {
        _currentStep = 3;
      }
    });
  }

  // ===== PRICE =====
  double get subtotal {
    double sum = 0;
    for (final c in cart) {
      final p =
          double.tryParse(c.price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
      sum += p * c.quantity;
    }
    return sum;
  }

  double get tax => subtotal * 0.2;
  double get total => subtotal + tax;

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _addressCtrl.dispose();
    _provinceCtrl.dispose();
    _phoneCtrl.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _placeOrder() {
    if (!_formKey.currentState!.validate()) return;

    final orderTotal = total;
    clearCart();

    Navigator.pushReplacementNamed(
      context,
      '/order_confirmation',
      arguments: {
        'customer': _firstNameCtrl.text,
        'total': orderTotal,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Checkout',
          style: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StepIndicator(currentStep: _currentStep),

                // ===== SHIPPING =====
                ShippingAddressForm(
                  firstNameCtrl: _firstNameCtrl,
                  lastNameCtrl: _lastNameCtrl,
                  addressCtrl: _addressCtrl,
                  provinceCtrl: _provinceCtrl,
                  phoneCtrl: _phoneCtrl,
                  onPickLocation: () {},
                ),

                const SizedBox(height: 28),

                // ===== PAYMENT =====
                PaymentMethodSection(
                  selectedPayment: _selectedPayment,
                  onPaymentChanged: (value) {
                    setState(() {
                      _selectedPayment = value;
                      _updateStep();
                    });
                  },
                ),

                const SizedBox(height: 28),

                // ===== REVIEW =====
                OrderReviewSection(cartItems: cart),

                const SizedBox(height: 20),

                // ===== PRICE =====
                PriceBreakdown(
                  subtotal: subtotal,
                  tax: tax,
                  total: total,
                ),

                const SizedBox(height: 20),

                // ===== BUTTON =====
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _placeOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 180, 138, 96),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'PLACE ORDER',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Center(
                  child: Text(
                    'By placing your order, you agree to our\nTerms of Service and Privacy Policy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: AppFooter(
        currentIndex: 1,
        onTap: (i) => AppFooter.navigateTo(context, i),
      ),
    );
  }
}
