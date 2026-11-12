import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Shared, responsive page shell for Login / Sign Up:
/// soft background blobs + centred, scrollable, width-constrained content.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -90,
            right: -70,
            child: _Blob(
              size: 260,
              color: AppColors.primary.withValues(alpha: 0.14),
            ),
          ),
          Positioned(
            bottom: -110,
            left: -90,
            child: _Blob(
              size: 300,
              color: AppColors.accent.withValues(alpha: 0.12),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.color});

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
