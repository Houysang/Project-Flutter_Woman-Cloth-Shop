import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import '../services/profile_service.dart';

class EditProfilePage extends StatefulWidget {
  final String? currentPhotoBase64;

  const EditProfilePage({super.key, this.currentPhotoBase64});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _profileService = ProfileService();
  final _picker = ImagePicker();

  User? _user;
  String? _photoBase64;
  bool _isLoading = false;
  bool _showPasswordFields = false;

  static const Color accent = Color(0xFFC5A081);
  static const Color darkText = Color(0xFF2D2926);
  static const Color mutedText = Color(0xFFA89890);
  static const Color fieldBg = Color(0xFFF8F4F0);

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _nameController.text = _user?.displayName ?? '';
    _photoBase64 = widget.currentPhotoBase64;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );
    if (picked == null) return;

    final bytes = await picked.readAsBytes();
    setState(() {
      _photoBase64 = base64Encode(bytes);
    });
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      _showSnackBar('Name cannot be empty');
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Update display name in Firebase Auth
      await _profileService.updateDisplayName(name);

      // Save profile data (base64 + name) to Firestore
      await _profileService.saveProfile(
        imageBase64: _photoBase64,
        displayName: name,
      );

      // Change password if requested
      if (_showPasswordFields) {
        final password = _passwordController.text;
        final confirm = _confirmPasswordController.text;

        if (password.isNotEmpty) {
          if (password.length < 6) {
            _showSnackBar('Password must be at least 6 characters');
            setState(() => _isLoading = false);
            return;
          }
          if (password != confirm) {
            _showSnackBar('Passwords do not match');
            setState(() => _isLoading = false);
            return;
          }
          await _profileService.changePassword(password);
        }
      }

      if (!mounted) return;
      _showSnackBar('Profile updated successfully!');
      Navigator.pop(context, true);
    } on FirebaseAuthException catch (e) {
      _showSnackBar(e.message ?? 'Failed to update profile');
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
        backgroundColor: Colors.green.shade400,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final email = _user?.email ?? 'No email';

    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9F7F2),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.comfortaa(
            color: darkText,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // ── Profile Image ──
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: accent, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: accent.withOpacity(0.2),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: _photoBase64 != null
                          ? Image.memory(
                              base64Decode(_photoBase64!),
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: accent.withOpacity(0.15),
                              child: Icon(
                                Icons.person,
                                size: 50,
                                color: accent,
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: accent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
            Text(
              'Tap to change photo',
              style: GoogleFonts.comfortaa(
                fontSize: 11,
                color: mutedText,
              ),
            ),

            const SizedBox(height: 28),

            // ── Form Card ──
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Full Name
                  _buildLabel('Full Name'),
                  const SizedBox(height: 8),
                  _buildField(
                    controller: _nameController,
                    hint: 'Enter your name',
                    icon: Icons.person_outline,
                  ),

                  const SizedBox(height: 20),

                  // Email (read-only)
                  _buildLabel('Email'),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: fieldBg,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.email_outlined, color: accent, size: 20),
                        const SizedBox(width: 12),
                        Text(
                          email,
                          style: GoogleFonts.comfortaa(
                            fontSize: 14,
                            color: mutedText,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Change Password toggle
                  GestureDetector(
                    onTap: () {
                      setState(
                        () => _showPasswordFields = !_showPasswordFields,
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          _showPasswordFields
                              ? Icons.lock_open
                              : Icons.lock_outline,
                          color: accent,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _showPasswordFields
                              ? 'Cancel password change'
                              : 'Change Password',
                          style: GoogleFonts.comfortaa(
                            fontSize: 13,
                            color: accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (_showPasswordFields) ...[
                    const SizedBox(height: 16),
                    _buildField(
                      controller: _passwordController,
                      hint: 'New password',
                      icon: Icons.lock_outline,
                      obscure: true,
                    ),
                    const SizedBox(height: 14),
                    _buildField(
                      controller: _confirmPasswordController,
                      hint: 'Confirm new password',
                      icon: Icons.lock_outline,
                      obscure: true,
                    ),
                  ],

                  const SizedBox(height: 28),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        disabledBackgroundColor: accent.withOpacity(0.4),
                        disabledForegroundColor: Colors.white60,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Save Changes',
                              style: GoogleFonts.comfortaa(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.comfortaa(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: darkText,
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: GoogleFonts.comfortaa(
        fontSize: 14,
        color: darkText,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.comfortaa(
          fontSize: 14,
          color: mutedText.withOpacity(0.6),
        ),
        prefixIcon: Icon(icon, color: accent, size: 20),
        filled: true,
        fillColor: fieldBg,
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
          borderSide: BorderSide(color: accent.withOpacity(0.5), width: 1.5),
        ),
      ),
    );
  }
}