import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../core/errors/auth_failure.dart';

/// Thin wrapper around [FirebaseAuth].
///
/// Controllers never touch Firebase directly; they call this service and only
/// deal with [AuthFailure] (a user-friendly error).
class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Emits whenever the user signs in or out.
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  /// Registration (Sign Up).
  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) {
    return _guard(
      () => _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      ),
    );
  }

  /// Login (Sign In).
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) {
    return _guard(
      () => _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      ),
    );
  }

  Future<void> signOut() => _guard(_auth.signOut);

  /// Checks whether an account already exists with the given email.
  Future<bool> doesEmailExist(String email) async {
    final cleanEmail = email.trim();
    if (cleanEmail.isEmpty) return false;
    try {
      // ignore: deprecated_member_use
      final methods = await _auth.fetchSignInMethodsForEmail(cleanEmail);
      return methods.isNotEmpty;
    } catch (e) {
      debugPrint('Error checking email existence: $e');
      return false;
    }
  }

  /// Converts [FirebaseAuthException] into [AuthFailure].
  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.code} - ${e.message}');
      throw AuthFailure.fromCode(e.code);
    }
  }
}
