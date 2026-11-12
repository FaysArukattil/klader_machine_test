/// Pure form validators (easy to unit test).
class Validators {
  Validators._();

  static final RegExp _emailRegExp =
      RegExp(r'^[\w.+\-]+@([\w\-]+\.)+[\w\-]{2,}$');

  // Strong password requirements
  static final RegExp _hasUppercase = RegExp(r'[A-Z]');
  static final RegExp _hasLowercase = RegExp(r'[a-z]');
  static final RegExp _hasDigit = RegExp(r'\d');
  static final RegExp _hasSpecial = RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-+=\[\]\\\/~`]');

  static String? email(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Email is required';
    if (!_emailRegExp.hasMatch(email)) return 'Enter a valid email address';
    return null;
  }

  /// Validates a strong password:
  /// • At least 9 characters
  /// • At least one uppercase letter (A–Z)
  /// • At least one lowercase letter (a–z)
  /// • At least one digit (0–9)
  /// • At least one special character
  static String? strongPassword(String? value) {
    final password = value ?? '';
    if (password.isEmpty) return 'Password is required';
    if (password.length < 9) return 'Password must be at least 9 characters';
    if (!_hasUppercase.hasMatch(password)) {
      return 'Must include at least one uppercase letter (A–Z)';
    }
    if (!_hasLowercase.hasMatch(password)) {
      return 'Must include at least one lowercase letter (a–z)';
    }
    if (!_hasDigit.hasMatch(password)) {
      return 'Must include at least one number (0–9)';
    }
    if (!_hasSpecial.hasMatch(password)) {
      return 'Must include at least one special character (e.g. @, #, \$, !)';
    }
    return null;
  }

  /// Used on the Sign In form.
  static String? loginPassword(String? value) => strongPassword(value);

  /// Used on the Sign Up form.
  static String? newPassword(String? value) => strongPassword(value);

  static String? confirmPassword(String? value, String original) {
    final confirm = value ?? '';
    if (confirm.isEmpty) return 'Please confirm your password';
    if (confirm != original) return 'Passwords do not match';
    return null;
  }
}
