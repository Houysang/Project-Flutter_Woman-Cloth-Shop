import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'order_history_page.dart';
import 'setting_page.dart';
import 'wishlist_page.dart';
import 'filter_page.dart';
import 'edit_profile_page.dart';
import '../components/glass_bottom_nav_widget.dart';
import '../models/wishlist_store.dart';
import '../login_page.dart';
import '../services/auth_service.dart';
import '../services/profile_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  final ProfileService _profileService = ProfileService();
  User? _user;
  String? _photoBase64;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() {
    setState(() {
      _user = _authService.currentUser;
    });
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final profile = await _profileService.getProfile();
    if (profile != null && mounted) {
      setState(() {
        _photoBase64 = profile['photoBase64'] as String?;
      });
    }
  }

  Future<void> _navigateToEdit() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfilePage(currentPhotoBase64: _photoBase64),
      ),
    );
    if (result == true) {
      _loadUser();
    }
  }

  Future<void> _logout() async {
    await _authService.signOut();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);

  @override
  Widget build(BuildContext context) {
    final name = _user?.displayName ?? "User";
    final email = _user?.email ?? "No email";
    final initial = name.isNotEmpty ? name[0].toUpperCase() : "U";

    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),

      // APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F7F2),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile",
          style: GoogleFonts.comfortaa(
            color: darkText,
            fontWeight: FontWeight.bold,
          ),
        ),

        // FILTER BUTTON NAVIGATION
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black54),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const FilterPage(),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: const GlassBottomNavWidget(selectedIndex: 3),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // PROFILE HEADER (tap to edit)
            GestureDetector(
              onTap: _navigateToEdit,
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: accent, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: accent.withOpacity(0.2),
                        backgroundImage: _photoBase64 != null
                            ? MemoryImage(base64Decode(_photoBase64!))
                            : null,
                        child: _photoBase64 == null
                            ? Text(
                                initial,
                                style: GoogleFonts.comfortaa(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: accent,
                                ),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.comfortaa(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: darkText,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            email,
                            style: GoogleFonts.comfortaa(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.edit, color: Colors.black45),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // PERSONAL INFO
            _cardSection(
              title: "Personal Information",
              children: [
                _infoTile(Icons.person_outline, "Full Name", name),
                _infoTile(Icons.email_outlined, "Email", email),
              ],
            ),

            const SizedBox(height: 20),

            // MENU
            _cardSection(
              title: "Account",
              children: [
                _menuTile(
                  Icons.receipt_long,
                  "Order History",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OrderHistoryPage(),
                      ),
                    );
                  },
                ),
                _menuTile(
                  Icons.settings_outlined,
                  "Settings",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SettingsPage(),
                      ),
                    );
                  },
                ),
                _menuTile(
                  Icons.favorite_border,
                  "Wishlist",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => WishlistPage(
                          items: wishlist,
                          currentProductId: "",
                        ),
                      ),
                    );
                  },
                ),
                _menuTile(
                  Icons.logout,
                  "Logout",
                  isDanger: true,
                  onTap: _logout,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // CARD SECTION
  Widget _cardSection({
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

  // INFO TILE
  Widget _infoTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: accent),
      title: Text(
        title,
        style: GoogleFonts.comfortaa(
          fontSize: 12,
          color: Colors.black54,
        ),
      ),
      subtitle: Text(
        value,
        style: GoogleFonts.comfortaa(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: darkText,
        ),
      ),
    );
  }

  // MENU TILE
  Widget _menuTile(
    IconData icon,
    String title, {
    VoidCallback? onTap,
    bool isDanger = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDanger ? Colors.red : accent,
      ),
      title: Text(
        title,
        style: GoogleFonts.comfortaa(
          color: isDanger ? Colors.red : darkText,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, size: 18),
      onTap: onTap,
    );
  }
}