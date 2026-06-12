import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/footer_widget.dart';
import 'pages/interested_page.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RegisterPage(),
  ));
}    
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFDF8F3),
              Color(0xFFF5EDE6),
              Color(0xFFEDE0D4),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const SizedBox(height: 48),

                  /// Logo & Brand
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFD8B384), Color(0xFFC9A17B)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFD8B384).withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "OW",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Title
                  Text(
                    "Create Account",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF3B3232),
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Step into a world of curated fashion made just for you.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF9A8C8C),
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 32),

                  /// Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Full Name
                        _buildLabel("Full Name"),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _nameController,
                          hint: "Enter your name",
                          prefixIcon: Icons.person_outline,
                        ),

                        const SizedBox(height: 18),

                        /// Email
                        _buildLabel("Email Address"),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _emailController,
                          hint: "example@email.com",
                          prefixIcon: Icons.email_outlined,
                        ),

                        const SizedBox(height: 18),

                        /// Phone
                        _buildLabel("Phone Number"),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _phoneController,
                          hint: "+1 234 567 890",
                          prefixIcon: Icons.phone_outlined,
                        ),

                        const SizedBox(height: 18),

                        /// Password
                        _buildLabel("Password"),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller: _passwordController,
                          hint: "Create a strong password",
                          prefixIcon: Icons.lock_outlined,
                          obscureText: _obscurePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: const Color(0xFFB8A8A0),
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() => _obscurePassword = !_obscurePassword);
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// Register Button
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const InterestedPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD8B384),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              "Create Account",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        /// Divider
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(color: Color(0xFFEDE0D4)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                "or sign up with",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFFB8A8A0),
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

                        /// Social Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _socialButton(
                              icon: Icons.g_mobiledata,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 16),
                            _socialButton(
                              icon: Icons.apple,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 16),
                            _socialButton(
                              icon: Icons.facebook,
                              color: const Color(0xFF1877F2),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// Sign In Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF9A8C8C),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: const Color(0xFFD8B384),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                  const FooterWidget(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF5C4F4A),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData prefixIcon,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: const Color(0xFF3B3232),
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: const Color(0xFFC4B8B0),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: const Color(0xFFD8B384),
          size: 20,
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFFF8F4F0),
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
          borderSide: const BorderSide(
            color: Color(0xFFD8B384),
            width: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _socialButton({
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFEDE0D4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: color,
        size: 26,
      ),
    );
  }
}
