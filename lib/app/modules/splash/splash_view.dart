import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Seamless Flutter-side splash screen.
/// Background (#F5F6FA) and logo placement exactly mirror the native
/// Android launch_background.xml so there is zero visual jump.
class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: screenW - 96),
            child: Image.asset(
              'assets/images/klader_logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
