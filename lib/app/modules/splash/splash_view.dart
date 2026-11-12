import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Full-bleed whitish splash screen matching the login screen aesthetic,
/// featuring the dark-shade Klader logo prominently across the center.
class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Soft ambient blobs matching AuthScaffold
          Positioned(
            top: -90,
            right: -70,
            child: _AmbientBlob(
              size: 260,
              color: AppColors.primary.withValues(alpha: 0.14),
            ),
          ),
          Positioned(
            bottom: -110,
            left: -90,
            child: _AmbientBlob(
              size: 300,
              color: AppColors.accent.withValues(alpha: 0.12),
            ),
          ),
          // Full expanded dark-shade Klader logo centered across the screen
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Image.asset(
                  'assets/images/klader_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AmbientBlob extends StatelessWidget {
  const _AmbientBlob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}
