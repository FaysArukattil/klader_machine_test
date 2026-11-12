import 'package:get/get.dart';

import '../modules/auth/auth_gate.dart';
import '../modules/auth/login/login_view.dart';
import '../modules/auth/signup/signup_view.dart';
import '../modules/home/home_view.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.root;

  static final pages = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: Routes.root,
      page: () => const AuthGate(),
    ),
    GetPage<dynamic>(
      name: Routes.login,
      page: () => const LoginView(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: Routes.home,
      page: () => const HomeView(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: Routes.signUp,
      page: () => const SignUpView(),
      transition: Transition.rightToLeft,
    ),
  ];
}
