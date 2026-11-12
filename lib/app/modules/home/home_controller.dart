import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/errors/auth_failure.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_snackbar.dart';
import '../../data/services/auth_service.dart';
import '../../routes/app_routes.dart';
import '../auth/login/login_controller.dart';
import '../auth/signup/signup_controller.dart';

class HomeController extends GetxController {
  final AuthService _auth = Get.find<AuthService>();

  final isLoggingOut = false.obs;

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  String get email => _auth.currentUser?.email ?? '-';

  String get uid => _auth.currentUser?.uid ?? '-';

  /// Friendly name derived from the email, e.g. "john.doe@x.com" -> "John.doe".
  String get displayName {
    final local = email.split('@').first;
    if (local.isEmpty || local == '-') return 'there';
    return local[0].toUpperCase() + local.substring(1);
  }

  String get initial =>
      displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U';

  String get createdAt => _format(_auth.currentUser?.metadata.creationTime);

  String get lastSignIn => _format(_auth.currentUser?.metadata.lastSignInTime);

  String _format(DateTime? date) {
    if (date == null) return '-';
    final d = date.toLocal();
    final hh = d.hour.toString().padLeft(2, '0');
    final mm = d.minute.toString().padLeft(2, '0');
    return '${d.day} ${_months[d.month - 1]} ${d.year}, $hh:$mm';
  }

  Future<void> confirmLogout() async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Log out?'),
        content: const Text(
          'You will need to sign in again to access your account.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back<bool>(result: false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () => Get.back<bool>(result: true),
            child: const Text('Log out'),
          ),
        ],
      ),
    );

    if (confirmed == true) await logout();
  }

  Future<void> logout() async {
    if (isLoggingOut.value) return;
    isLoggingOut.value = true;
    try {
      await _auth.signOut();

      // Dispose all active controllers so no stale text, errors, or timers linger
      if (Get.isRegistered<SignUpController>()) {
        Get.delete<SignUpController>(force: true);
      }
      if (Get.isRegistered<LoginController>()) {
        Get.delete<LoginController>(force: true);
      }
      if (Get.isRegistered<HomeController>()) {
        Get.delete<HomeController>(force: true);
      }

      // Route cleanly back to Login
      Get.offAllNamed<void>(Routes.login);
    } on AuthFailure catch (e) {
      AppSnackbar.error(e.message);
      isLoggingOut.value = false;
    } catch (_) {
      AppSnackbar.error('Failed to log out. Please try again.');
      isLoggingOut.value = false;
    }
  }
}
