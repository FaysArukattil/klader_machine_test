import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/errors/auth_failure.dart';
import '../../../data/services/auth_service.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final AuthService _auth = Get.find<AuthService>();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final obscurePassword = true.obs;
  final errorMessage = RxnString();

  void togglePasswordVisibility() => obscurePassword.toggle();

  void goToSignUp() {
    errorMessage.value = null;
    Get.toNamed(Routes.signUp);
  }

  Future<void> signIn() async {
    FocusManager.instance.primaryFocus?.unfocus();
    errorMessage.value = null;

    if (!(formKey.currentState?.validate() ?? false)) return;

    isLoading.value = true;
    try {
      await _auth.signIn(
        email: emailController.text,
        password: passwordController.text,
      );
      Get.offAllNamed<void>(Routes.home);
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
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
