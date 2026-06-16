import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/interested_page.dart';
import 'package:women_cloth_shop/register_page.dart';
import 'package:women_cloth_shop/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  static const Color _accent = Color(0xFFC5A081);
  static const Color _darkText = Color(0xFF2D2926);
  static const Color _mutedText = Color(0xFFA89890);
  static const Color _fieldBg = Color(0xFFF8F4F0);

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('Please fill in all fields');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.signIn(email: email, password: password);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const InterestedPage()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No account found with this email';
          break;
        case 'wrong-password':
          message = 'Incorrect password';
          break;
        case 'invalid-email':
          message = 'Invalid email address';
          break;
        case 'invalid-credential':
          message = 'Invalid email or password';
          break;
        default:
          message = 'Login failed: ${e.message}';
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
    _emailController.dispose();
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const Spacer(flex: 1),

                // ── Circular Logo ──
                Container(
                  width: 100,
                  height: 100,
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
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // ── Tagline ──
                Text(
                  "Welcome back to NEARY Fashion, lovely!\n Your favorite styles are waiting for you💕",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.comfortaa(
                    fontSize: 15,
                    color: _mutedText,
                    height: 1.6,
                    letterSpacing: 0.3,
                  ),
                ),

                const Spacer(flex: 1),

                // ── Login Card ──
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: _accent.withOpacity(0.08),
                        blurRadius: 40,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Email
                      _buildField(
                        controller: _emailController,
                        hint: "Email",
                        icon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 16),

                      /// Password
                      _buildField(
                        controller: _passwordController,
                        hint: "Password",
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

                      const SizedBox(height: 8),

                      /// Forgot
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            visualDensity: VisualDensity.compact,
                          ),
                          child: Text(
                            "Forgot?",
                            style: GoogleFonts.comfortaa(
                              fontSize: 12,
                              color: _accent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// Sign In — centered, 40% width
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _signIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _accent,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text(
                              "Sign In",
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
                              "or",
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

                      const SizedBox(height: 20),

                      /// Social row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _socialBtn(Icons.g_mobiledata, const Color(0xFF4285F4)),
                          const SizedBox(width: 20),
                          _socialBtn(Icons.apple, Colors.black),
                          const SizedBox(width: 20),
                          _socialBtn(Icons.facebook, const Color(0xFF1877F2)),
                        ],
                      ),
                    ],
                  ),
                ),

                const Spacer(flex: 1),

                /// Sign Up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New here? ",
                      style: GoogleFonts.comfortaa(
                        fontSize: 13,
                        color: _mutedText,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Join us",
                        style: GoogleFonts.comfortaa(
                          fontSize: 13,
                          color: _accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
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
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
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