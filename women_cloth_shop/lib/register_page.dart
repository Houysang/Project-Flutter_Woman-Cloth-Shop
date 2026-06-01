import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static const Color bgColor = Color(0xFFF8F3EF);
  static const Color accentColor = Color(0xFFD8B384);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                /// Logo
                Text(
                  "OnlyWomen",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6E5B61),
                  ),
                ),

                const SizedBox(height: 20),

                /// Title
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Create Your Profile",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3B3232),
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Step into a world of curated fashion made just for you.",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildField(
                        label: "Full Name",
                        hint: "Enter your name",
                      ),

                      _buildField(
                        label: "Email Address",
                        hint: "example@email.com",
                      ),

                      _buildField(
                        label: "Phone Number",
                        hint: "+1 234 567 890",
                      ),

                      _buildField(
                        label: "Password",
                        hint: "••••••••",
                        obscure: true,
                      ),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: accentColor,
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
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Text(
                              "OR",
                              style: GoogleFonts.poppins(
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                        children: [
                          _socialButton(
                            Icons.g_mobiledata,
                            Colors.red,
                          ),
                          _socialButton(
                            Icons.apple,
                            Colors.black,
                          ),
                          _socialButton(
                            Icons.facebook,
                            const Color(0xFF1877F2),
                          ),
                        ],
                      ),

                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.poppins(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                          children: const [
                            TextSpan(
                              text:
                                  "Already have an account? ",
                            ),
                            TextSpan(
                              text: "Sign In",
                              style: TextStyle(
                                color: accentColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildField({
    required String label,
    required String hint,
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _socialButton(
    IconData icon,
    Color color,
  ) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 28,
      ),
    );
  }
}