import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/auth_header.dart';
import '../../../core/widgets/auth_scaffold.dart';
import '../../../core/widgets/controller_scope.dart';
import '../../../core/widgets/error_banner.dart';
import '../../../core/widgets/primary_button.dart';
import 'signup_controller.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return ControllerScope<SignUpController>(
      create: SignUpController.new,
      builder: (context, controller) => _SignUpBody(controller: controller),
    );
  }
}

class _SignUpBody extends StatelessWidget {
  const _SignUpBody({required this.controller});

  final SignUpController controller;

  Widget _visibilityToggle(bool obscured, VoidCallback onTap) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        size: 20,
        color: AppColors.textSecondary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton.filledTonal(
                onPressed: controller.goToLogin,
                icon: const Icon(Icons.arrow_back_rounded),
              ),
            ),
            const SizedBox(height: 12),
            const AuthHeader(
              icon: Icons.person_add_alt_1_rounded,
              title: 'Create account',
              subtitle: 'Sign up with your email to get started in seconds.',
            ),
            const SizedBox(height: 32),
            ErrorBanner(message: controller.errorMessage),
            Obx(
              () => AppTextField(
                label: 'Email',
                hint: 'you@example.com',
                icon: Icons.mail_outline_rounded,
                controller: controller.emailController,
                validator: controller.validateEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.newUsername],
                suffix: controller.isCheckingEmail.value
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 18),
            Obx(
              () => AppTextField(
                label: 'Password',
                hint: 'Enter your password',
                icon: Icons.lock_outline_rounded,
                controller: controller.passwordController,
                validator: Validators.newPassword,
                obscureText: controller.obscurePassword.value,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.newPassword],
                suffix: _visibilityToggle(
                  controller.obscurePassword.value,
                  controller.togglePasswordVisibility,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Obx(
              () => AppTextField(
                label: 'Confirm password',
                hint: 'Re-enter your password',
                icon: Icons.lock_reset_rounded,
                controller: controller.confirmPasswordController,
                validator: controller.validateConfirm,
                obscureText: controller.obscureConfirm.value,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => controller.signUp(),
                suffix: _visibilityToggle(
                  controller.obscureConfirm.value,
                  controller.toggleConfirmVisibility,
                ),
              ),
            ),
            const SizedBox(height: 28),
            Obx(
              () => PrimaryButton(
                label: 'Create Account',
                isLoading: controller.isLoading.value,
                onPressed: controller.signUp,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                TextButton(
                  onPressed: controller.goToLogin,
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
