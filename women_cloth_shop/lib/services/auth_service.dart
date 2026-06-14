import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ── Stream: listen to auth state changes ──
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // ── Get current user ──
  User? get currentUser => _auth.currentUser;

  // ── Sign Up with email & password ──
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  // ── Sign In with email & password ──
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  // ── Sign Out ──
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // ── Delete current user ──
  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.delete();
    }
  }
}