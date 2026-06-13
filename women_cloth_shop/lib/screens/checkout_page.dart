import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/glass_bottom_nav_widget.dart';
import '../components/checkout/step_indicator.dart';
import '../components/checkout/shipping_address_form.dart';
import '../components/checkout/payment_method_section.dart';
import '../components/checkout/order_review_section.dart';
import '../components/checkout/price_breakdown.dart';
import '../models/cart_store.dart';
import '../models/order.dart';
import '../models/order_store.dart';
import '../screens/map_picker_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _provinceCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  final _scrollController = ScrollController();

  String _selectedPayment = '';
  int _currentStep = 1;

  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

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

  double get subtotal {
    double sum = 0;

    for (final item in cart) {
      final price =
          double.tryParse(item.price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;

      sum += price * item.quantity;
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

    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: List.from(cart),
      totalPrice: total,
      date: DateTime.now(),
      status: OrderStatus.processing,
    );

    orderHistory.add(order); // ✅ SAVE TO HISTORY

    final orderTotal = total;
    clearCart(); // empty cart AFTER saving order

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
      backgroundColor: Colors.white,

      // APP BAR (MATCH HOMEPAGE STYLE)
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: darkText),
        title: Text(
          'Checkout',
          style: GoogleFonts.comfortaa(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: darkText,
          ),
        ),
      ),

      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepIndicator(currentStep: _currentStep),
              const SizedBox(height: 24),
              ShippingAddressForm(
                firstNameCtrl: _firstNameCtrl,
                lastNameCtrl: _lastNameCtrl,
                addressCtrl: _addressCtrl,
                provinceCtrl: _provinceCtrl,
                phoneCtrl: _phoneCtrl,
                onPickLocation: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MapPickerPage(),
                    ),
                  );

                  if (result == null || result is! Map) return;

                  setState(() {
                    // street / detail address
                    _addressCtrl.text = result["address"] ?? "";

                    // city only
                    _provinceCtrl.text = result["city"] ?? "";

                    // optional: if you want separate field later
                    // country can be stored elsewhere or merged
                  });
                },
              ),
              const SizedBox(height: 28),
              PaymentMethodSection(
                selectedPayment: _selectedPayment,
                onPaymentChanged: (value) {
                  setState(() => _selectedPayment = value);
                  _updateStep();
                },
              ),
              const SizedBox(height: 28),
              OrderReviewSection(cartItems: cart),
              const SizedBox(height: 20),
              PriceBreakdown(
                subtotal: subtotal,
                tax: tax,
                total: total,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _placeOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'PLACE ORDER',
                    style: GoogleFonts.comfortaa(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'By placing your order, you agree to our\nTerms of Service and Privacy Policy.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.comfortaa(
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const GlassBottomNavWidget(),
    );
  }
}
