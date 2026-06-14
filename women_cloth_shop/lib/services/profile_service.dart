import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Save profile data (base64 image, display name) to Firestore
  Future<void> saveProfile({
    String? imageBase64,
    String? displayName,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final data = <String, dynamic>{};
    if (imageBase64 != null) data['photoBase64'] = imageBase64;
    if (displayName != null) data['displayName'] = displayName;

    await _firestore.collection('users').doc(user.uid).set(
      data,
      SetOptions(merge: true),
    );
  }

  /// Get profile data from Firestore
  Future<Map<String, dynamic>?> getProfile() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    return doc.data();
  }

  /// Change user password (re-authentication required)
  Future<void> changePassword(String newPassword) async {
    final user = _auth.currentUser;
    if (user == null) return;
    await user.updatePassword(newPassword);
  }

  /// Update display name in Firebase Auth
  Future<void> updateDisplayName(String name) async {
    final user = _auth.currentUser;
    if (user == null) return;
    await user.updateDisplayName(name);
    await user.reload();
  }
}