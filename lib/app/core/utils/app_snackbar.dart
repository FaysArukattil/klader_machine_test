import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';

class AppSnackbar {
  AppSnackbar._();

  static void success(String message) => _show(
        title: 'Success',
        message: message,
        color: AppColors.success,
        icon: Icons.check_circle_outline_rounded,
      );

  static void error(String message) => _show(
        title: 'Oops',
        message: message,
        color: AppColors.error,
        icon: Icons.error_outline_rounded,
      );

  static void _show({
    required String title,
    required String message,
    required Color color,
    required IconData icon,
  }) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color,
      colorText: Colors.white,
      icon: Icon(icon, color: Colors.white),
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      duration: const Duration(seconds: 3),
    );
  }
}
