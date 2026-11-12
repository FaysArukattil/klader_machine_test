import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/services/auth_service.dart';
import '../home/home_view.dart';
import '../splash/splash_view.dart';
import 'login/login_view.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    // Hold splash for 1.2 seconds so user sees the Klader logo clearly
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() => _showSplash = false);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/images/klader_logo.png'), context);
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return const SplashView();
    }

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
