import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: InterestedPage(),
  ));
}

class InterestedPage extends StatefulWidget {
  const InterestedPage({super.key});

  @override
  State<InterestedPage> createState() => _InterestedPageState();
}

class _InterestedPageState extends State<InterestedPage> {
  final Set<int> _selected = {};

  static const Color bg = Color(0xFFF9F7F2);
  static const Color accent = Color(0xFFC5A081);
  static const Color dark = Color(0xFF2D2926);

  final List<_StyleItem> _items = [
    _StyleItem("Soft Neutral", Icons.wb_sunny_outlined, "Warm & earthy"),
    _StyleItem("Cozy Chic", Icons.weekend_outlined, "Comfy & trendy"),
    _StyleItem("Minimal", Icons.diamond_outlined, "Clean & timeless"),
    _StyleItem("Boho", Icons.spa_outlined, "Free & artistic"),
    _StyleItem("Everyday Luxe", Icons.star_outline, "Effortless glam"),
    _StyleItem("Romantic", Icons.local_florist_outlined, "Soft & delicate"),
    _StyleItem("Tailored", Icons.checkroom_outlined, "Bold & sharp"),
    _StyleItem("Warm Tones", Icons.whatshot_outlined, "Rich & cozy"),
    _StyleItem("Casual", Icons.shopping_bag_outlined, "Easy & relaxed"),
    _StyleItem("Vintage", Icons.watch_later_outlined, "Retro charm"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Circular Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: accent.withOpacity(0.3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: accent.withOpacity(0.15),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    '../../assets/images/logo1.png',
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Title
              Text(
                "Tell us your style",
                textAlign: TextAlign.center,
                style: GoogleFonts.comfortaa(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: dark,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "Pick what you love, we'll do the rest",
                style: GoogleFonts.comfortaa(
                  fontSize: 12,
                  color: Colors.black45,
                ),
              ),

              const SizedBox(height: 24),

              // Chips
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: List.generate(_items.length, (i) {
                      final item = _items[i];
                      final sel = _selected.contains(i);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (sel) {
                              _selected.remove(i);
                            } else {
                              _selected.add(i);
                            }
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOutBack,
                          padding: EdgeInsets.symmetric(
                            horizontal: sel ? 20 : 18,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: sel ? accent : Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color:
                                  sel ? accent : Colors.black.withOpacity(0.06),
                              width: sel ? 0 : 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: sel
                                    ? accent.withOpacity(0.25)
                                    : Colors.black.withOpacity(0.04),
                                blurRadius: sel ? 12 : 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                item.icon,
                                size: 18,
                                color: sel ? Colors.white : accent,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item.name,
                                style: GoogleFonts.comfortaa(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: sel ? Colors.white : dark,
                                ),
                              ),
                              if (sel)
                                const Icon(Icons.check_circle,
                                    size: 16, color: Colors.white),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),

              // Selected count pill
              if (_selected.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      "${_selected.length} style${_selected.length > 1 ? 's' : ''} selected",
                      style: GoogleFonts.comfortaa(
                        fontSize: 12,
                        color: accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

              // Continue
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _selected.isNotEmpty
                      ? () => Navigator.pushNamedAndRemoveUntil(
                          context, '/shop', (route) => false)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    disabledBackgroundColor: accent.withOpacity(0.25),
                    disabledForegroundColor: Colors.white54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    _selected.isNotEmpty ? "Let's Go!" : "Pick your styles",
                    style: GoogleFonts.comfortaa(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Skip
              TextButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, '/shop', (route) => false),
                child: Text(
                  "Skip, I'll decide later",
                  style: GoogleFonts.comfortaa(
                    fontSize: 12,
                    color: Colors.black38,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _StyleItem {
  final String name;
  final IconData icon;
  final String subtitle;
  const _StyleItem(this.name, this.icon, this.subtitle);
}