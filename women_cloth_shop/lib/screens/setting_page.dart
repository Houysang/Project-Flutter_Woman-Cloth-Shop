import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 👇 Import your pages
import 'help_center_page.dart';
import 'about_app_page.dart';
import 'rate_us_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static const Color darkText = Color(0xFF2D2926);
  static const Color accent = Color(0xFFC5A081);

  bool notifications = true;
  bool darkMode = false;
  bool location = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F7F2),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: darkText),
        title: Text(
          "Settings",
          style: GoogleFonts.comfortaa(
            color: darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // ================= PREFERENCES =================
            _buildSection(
              title: "Preferences",
              children: [
                _switchItem(
                  Icons.notifications_none,
                  "Notifications",
                  notifications,
                  (val) => setState(() => notifications = val),
                ),
                _switchItem(
                  Icons.dark_mode_outlined,
                  "Dark Mode",
                  darkMode,
                  (val) => setState(() => darkMode = val),
                ),
                _switchItem(
                  Icons.location_on_outlined,
                  "Location Access",
                  location,
                  (val) => setState(() => location = val),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ================= SUPPORT =================
            _buildSection(
              title: "Support",
              children: [
                _menuItem(Icons.help_outline, "Help Center", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HelpCenterPage(),
                    ),
                  );
                }),
                _menuItem(Icons.info_outline, "About App", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AboutAppPage(),
                    ),
                  );
                }),
                _menuItem(Icons.star_border, "Rate Us", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RateUsPage(),
                    ),
                  );
                }),
              ],
            ),

            const SizedBox(height: 20),

            // ================= LOGOUT =================
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: Text(
                  "Logout",
                  style: GoogleFonts.comfortaa(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ================= SECTION WIDGET =================
  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: GoogleFonts.comfortaa(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: darkText,
                ),
              ),
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }

  // ================= MENU ITEM (WITH NAVIGATION) =================
  Widget _menuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: accent),
      title: Text(
        title,
        style: GoogleFonts.comfortaa(
          color: darkText,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, size: 18),
      onTap: onTap,
    );
  }

  // ================= SWITCH ITEM =================
  Widget _switchItem(
    IconData icon,
    String title,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      activeColor: accent,
      secondary: Icon(icon, color: accent),
      title: Text(
        title,
        style: GoogleFonts.comfortaa(
          color: darkText,
          fontWeight: FontWeight.w600,
        ),
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
