import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/errors/auth_failure.dart';
import '../../../core/utils/app_snackbar.dart';
import '../../../core/utils/validators.dart';
import '../../../data/services/auth_service.dart';
import '../../../routes/app_routes.dart';

class SignUpController extends GetxController {
  final AuthService _auth = Get.find<AuthService>();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;
  final isCheckingEmail = false.obs;
  final emailExistsError = RxnString();
  final obscurePassword = true.obs;
  final obscureConfirm = true.obs;
  final errorMessage = RxnString();

  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_onEmailChanged);
  }

  void _onEmailChanged() {
    final text = emailController.text.trim();
    _debounceTimer?.cancel();

    if (text.isEmpty || Validators.email(text) != null) {
      if (emailExistsError.value != null) {
        emailExistsError.value = null;
        if (errorMessage.value ==
            'An account already exists with this email. Try signing in instead.') {
          errorMessage.value = null;
        }
      }
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 350), () async {
      final currentText = emailController.text.trim();
      if (Validators.email(currentText) != null) return;

      isCheckingEmail.value = true;
      try {
        final exists = await _auth.doesEmailExist(currentText);
        if (emailController.text.trim() == currentText) {
          if (exists) {
            emailExistsError.value =
                'An account already exists with this email. Try signing in instead.';
            errorMessage.value =
                'An account already exists with this email. Try signing in instead.';
          } else {
            emailExistsError.value = null;
            if (errorMessage.value ==
                'An account already exists with this email. Try signing in instead.') {
              errorMessage.value = null;
            }
          }
        }
      } finally {
        isCheckingEmail.value = false;
      }
    });
  }

  void togglePasswordVisibility() => obscurePassword.toggle();
  void toggleConfirmVisibility() => obscureConfirm.toggle();

  String? validateEmail(String? value) {
    final basic = Validators.email(value);
    if (basic != null) return basic;
    return emailExistsError.value;
  }

  String? validateConfirm(String? value) =>
      Validators.confirmPassword(value, passwordController.text);

  void goToLogin() {
    if (Get.previousRoute.isNotEmpty) {
      Get.back<void>();
    } else {
      Get.offAllNamed<void>(Routes.login);
    }
  }

  Future<void> signUp() async {
    FocusManager.instance.primaryFocus?.unfocus();
    errorMessage.value = null;

    if (!(formKey.currentState?.validate() ?? false)) return;

    isLoading.value = true;
    try {
      await _auth.signUp(
        email: emailController.text,
        password: passwordController.text,
      );
      Get.offAllNamed<void>(Routes.home);
      AppSnackbar.success('Account created. Welcome aboard!');
    } on AuthFailure catch (e) {
      errorMessage.value = e.message;
      isLoading.value = false;
    } catch (_) {
      errorMessage.value = 'Something went wrong. Please try again.';
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    emailController.removeListener(_onEmailChanged);
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
