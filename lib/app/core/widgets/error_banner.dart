import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';

/// Inline, animated error message bound to a nullable observable string.
class ErrorBanner extends StatelessWidget {
  const ErrorBanner({super.key, required this.message});

  final RxnString message;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final text = message.value;
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) => SizeTransition(
          sizeFactor: animation,
          alignment: Alignment.topCenter,
          child: FadeTransition(opacity: animation, child: child),
        ),
        child: text == null
            ? const SizedBox(width: double.infinity, key: ValueKey('empty'))
            : Padding(
                key: ValueKey(text),
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.errorBackground,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.error.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        color: AppColors.error,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          text,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: const Color(0xFF991B1B),
                                    height: 1.45,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}
