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
import 'login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ControllerScope<LoginController>(
      create: LoginController.new,
      builder: (context, controller) => _LoginBody(controller: controller),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody({required this.controller});

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthHeader(
              icon: Icons.lock_outline_rounded,
              title: 'Welcome back',
              subtitle: 'Sign in with your email and password to continue.',
            ),
            const SizedBox(height: 32),
            ErrorBanner(message: controller.errorMessage),
            AppTextField(
              label: 'Email',
              hint: 'you@example.com',
              icon: Icons.mail_outline_rounded,
              controller: controller.emailController,
              validator: Validators.email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
            ),
            const SizedBox(height: 18),
            Obx(
              () => AppTextField(
                label: 'Password',
                hint: 'Enter your password',
                icon: Icons.lock_outline_rounded,
                controller: controller.passwordController,
                validator: Validators.loginPassword,
                obscureText: controller.obscurePassword.value,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => controller.signIn(),
                autofillHints: const [AutofillHints.password],
                suffix: IconButton(
                  onPressed: controller.togglePasswordVisibility,
                  icon: Icon(
                    controller.obscurePassword.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Obx(
              () => PrimaryButton(
                label: 'Sign In',
                isLoading: controller.isLoading.value,
                onPressed: controller.signIn,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                TextButton(
                  onPressed: controller.goToSignUp,
                  child: const Text(
                    'Sign up',
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
