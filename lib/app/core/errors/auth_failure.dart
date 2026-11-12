/// A user-friendly representation of a Firebase Authentication error.
class AuthFailure implements Exception {
  const AuthFailure(this.code, this.message);

  /// The original FirebaseAuthException code, e.g. `weak-password`.
  final String code;

  /// A message that is safe to show directly to the user.
  final String message;

  factory AuthFailure.fromCode(String code) {
    switch (code) {
      // --- Required by the assessment -----------------------------------
      case 'weak-password':
        return AuthFailure(
          code,
          'Your password is too weak. Use at least 9 characters with '
          'uppercase, lowercase, a number, and a special character.',
        );
      case 'email-already-in-use':
        return AuthFailure(
          code,
          'An account already exists with this email. '
          'Try signing in instead.',
        );
      case 'user-not-found':
        return AuthFailure(
          code,
          'No account found with this email. Please sign up first.',
        );

      // --- Other common sign-in / sign-up errors ------------------------
      case 'wrong-password':
      case 'invalid-credential':
        return AuthFailure(
          code,
          'Incorrect email or password. Please check and try again.',
        );
      case 'invalid-email':
        return AuthFailure(code, 'That email address looks invalid.');
      case 'user-disabled':
        return AuthFailure(
          code,
          'This account has been disabled. Please contact support.',
        );
      case 'too-many-requests':
        return AuthFailure(
          code,
          'Too many attempts. Please wait a moment and try again.',
        );
      case 'network-request-failed':
        return AuthFailure(
          code,
          'No internet connection. Check your network and try again.',
        );
      case 'operation-not-allowed':
        return AuthFailure(
          code,
          'Email/password sign-in is not enabled for this project.',
        );
      default:
        return AuthFailure(
          code,
          'Something went wrong. Please try again.',
        );
    }
  }

  @override
  String toString() => 'AuthFailure($code): $message';
}
