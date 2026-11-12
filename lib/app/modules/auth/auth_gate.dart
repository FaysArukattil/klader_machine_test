import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/services/auth_service.dart';
import '../home/home_view.dart';
import '../splash/splash_view.dart';
import 'login/login_view.dart';

/// Single source of truth for "who sees what".
///
/// Displays the full-bleed branded splash screen with the expanded Klader logo
/// for 1.5 seconds on launch, then smoothly crossfades to either [HomeView] or
/// [LoginView] based on `FirebaseAuth.instance.authStateChanges()`.
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _isSplashVisible = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isSplashVisible = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      child: _isSplashVisible ? const SplashView() : const _AuthStreamContent(),
    );
  }
}

class _AuthStreamContent extends StatelessWidget {
  const _AuthStreamContent();

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthService>();

    return StreamBuilder<User?>(
      stream: auth.authStateChanges,
      initialData: auth.currentUser,
      builder: (context, snapshot) {
        final user = snapshot.data;
        return user != null ? const HomeView() : const LoginView();
      },
    );
  }
}
