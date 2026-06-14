import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_cloth_shop/services/auth_service.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  static const Color _accent = Color(0xFFC5A081);
  static const Color _darkText = Color(0xFF2D2926);
  static const Color _mutedText = Color(0xFFA89890);
  static const Color _fieldBg = Color(0xFFF8F4F0);

  Future<void> _signUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      _showSnackBar('Please fill in all fields');
      return;
    }

    if (password.length < 6) {
      _showSnackBar('Password must be at least 6 characters');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final credential = await _authService.signUp(
        email: email,
        password: password,
      );

      // Update display name
      await credential.user?.updateDisplayName(name);

      if (!mounted) return;
      // Navigate to login page after successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = 'An account with this email already exists';
          break;
        case 'invalid-email':
          message = 'Invalid email address';
          break;
        case 'weak-password':
          message = 'Password is too weak';
          break;
        default:
          message = 'Registration failed: ${e.message}';
      }
      _showSnackBar(message);
    } catch (e) {
      _showSnackBar('An error occurred. Please try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade400,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF9F7F2),
              Color(0xFFF5EDE6),
              Color(0xFFF9F7F2),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // ── Circular Logo ──
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _accent.withOpacity(0.3),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _accent.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/logo1.png',
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Title ──
                  Text(
                    "Create Account",
                    style: GoogleFonts.comfortaa(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: _darkText,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ── Tagline ──
                  Text(
                    "Welcome to NEARY Fashion, \n where every outfit is designed to make you feel \n confident, beautiful, and special✨",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.comfortaa(
                      fontSize: 13,
                      color: _mutedText,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Card ──
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: _accent.withOpacity(0.08),
                          blurRadius: 40,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Full Name
                        _buildLabel("Full Name"),
                        const SizedBox(height: 8),
                        _buildField(
                          controller: _nameController,
                          hint: "Enter your name",
                          icon: Icons.person_outline,
                        ),

                        const SizedBox(height: 16),

                        /// Email
                        _buildLabel("Email Address"),
                        const SizedBox(height: 8),
                        _buildField(
                          controller: _emailController,
                          hint: "example@email.com",
                          icon: Icons.email_outlined,
                        ),

                        const SizedBox(height: 16),

                        /// Phone
                        _buildLabel("Phone Number"),
                        const SizedBox(height: 8),
                        _buildField(
                          controller: _phoneController,
                          hint: "+855",
                          icon: Icons.phone_outlined,
                        ),

                        const SizedBox(height: 16),

                        /// Password
                        _buildLabel("Password"),
                        const SizedBox(height: 8),
                        _buildField(
                          controller: _passwordController,
                          hint: "Create a strong password",
                          icon: Icons.lock_outlined,
                          obscure: _obscurePassword,
                          suffix: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: _mutedText,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() => _obscurePassword = !_obscurePassword);
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// Create Account — centered, 40% width
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _signUp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _accent,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Text(
                                "Create Account",
                                style: GoogleFonts.comfortaa(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// Divider
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(color: Color(0xFFEDE0D4)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              child: Text(
                                "or sign up with",
                                style: GoogleFonts.comfortaa(
                                  fontSize: 11,
                                  color: _mutedText,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(color: Color(0xFFEDE0D4)),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        /// Social Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _socialBtn(Icons.g_mobiledata, const Color(0xFF4285F4)),
                            const SizedBox(width: 18),
                            _socialBtn(Icons.apple, Colors.black),
                            const SizedBox(width: 18),
                            _socialBtn(Icons.facebook, const Color(0xFF1877F2)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// Sign In Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: GoogleFonts.comfortaa(
                          fontSize: 13,
                          color: _mutedText,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.comfortaa(
                            fontSize: 13,
                            color: _accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Label ──
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.comfortaa(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: _darkText,
      ),
    );
  }

  // ── Field ──
  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: GoogleFonts.comfortaa(
        fontSize: 14,
        color: _darkText,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.comfortaa(
          fontSize: 14,
          color: _mutedText.withOpacity(0.6),
        ),
        prefixIcon: Icon(icon, color: _accent, size: 20),
        suffixIcon: suffix,
        filled: true,
        fillColor: _fieldBg,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: _accent.withOpacity(0.5), width: 1.5),
        ),
      ),
    );
  }

  // ── Social Icon ──
  Widget _socialBtn(IconData icon, Color color) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFEDE0D4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: _accent.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }
}