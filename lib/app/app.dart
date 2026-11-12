import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/initial_binding.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_pages.dart';

class KladerApp extends StatelessWidget {
  const KladerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Klader Auth',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialBinding: InitialBinding(),
      initialRoute: AppPages.initial,
      getPages: AppPages.pages,
      defaultTransition: Transition.fadeIn,
    );
  }
}
