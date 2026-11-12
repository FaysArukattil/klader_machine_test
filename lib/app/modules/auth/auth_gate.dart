import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/services/auth_service.dart';
import '../home/home_view.dart';
import 'login/login_view.dart';

/// Single source of truth for "who sees what".
///
/// Listens to `FirebaseAuth.instance.authStateChanges()` through
/// [AuthService]: HomeScreen is shown only when the user is non-null,
/// otherwise the Login screen. Logging in/out therefore switches screens
/// automatically, and the session survives app restarts.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

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
