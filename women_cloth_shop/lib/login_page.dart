import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_cloth_shop/main.dart';

void main() {
  runApp(const MyApp());
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 🌸 Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("../assests/images/bg1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 🌙 Overlay
          Container(
            color: Colors.black.withOpacity(0.25),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 30),

                    /// 💖 Brand
                    Text(
                      "OnlyWomen",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 34,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffF3D7E3),
                      ),
                    ),

                    const SizedBox(height: 50),

                    /// ✨ Title
                    Text(
                      "Welcome Back",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// 🌷 Subtitle
                    Text(
                      "Your wardrobe’s favorite place is waiting for you again.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// 🌫 Glass Card
                    ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                        child: Container(
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Email
                              Text(
                                "Email",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(height: 10),

                              TextField(
                                decoration: InputDecoration(
                                  hintText: "name@example.com",
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade600),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.85),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 18),

                              /// Password
                              Text(
                                "Password",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(height: 10),

                              TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "••••••••",
                                  suffixIcon:
                                      const Icon(Icons.visibility_outlined),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.85),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 25),

                              /// 🔘 CENTERED LOGIN BUTTON (FIXED)
                              Center(
                                child: SizedBox(
                                  width: 160,
                                  height: 48,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 180, 138, 96),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      elevation: 0,
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/shop');
                                    },
                                    child: Text(
                                      "LOGIN",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 2,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              /// OR
                              Center(
                                child: Text(
                                  "OR CONTINUE WITH",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    letterSpacing: 2,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 18),

                              /// Social Icons
                              /// 🌈 Social Login Buttons (REPLACE OLD ROW)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _socialCircleButton(
                                    icon: Icons.g_mobiledata,
                                    color: Colors.red,
                                  ),
                                  _socialCircleButton(
                                    icon: Icons.apple,
                                    color: Colors.black,
                                  ),
                                  _socialCircleButton(
                                    icon: Icons.facebook,
                                    color: const Color(0xFF1877F2),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    Text(
                      "Don't have an account? Sign Up",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 30),

                    Text(
                      "© 2026 OnlyWomen",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 💡 Social button
  Widget _socialCircleButton({
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 26,
      ),
    );
  }
}
