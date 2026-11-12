import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String? initError;
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e, stackTrace) {
    initError = e.toString();
    debugPrint('Firebase initialization failed: $e\n$stackTrace');
  }

  if (initError != null) {
    runApp(FirebaseSetupRequiredApp(errorMessage: initError));
  } else {
    runApp(const KladerApp());
  }
}

class FirebaseSetupRequiredApp extends StatelessWidget {
  const FirebaseSetupRequiredApp({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF4F46E5),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.warning_amber_rounded,
                            color: Color(0xFFD97706),
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Firebase Setup Required',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'The app is running, but Firebase has not been configured yet. '
                          'Run the setup command in your project terminal to link your Firebase project:',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF64748B),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F172A),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const SelectableText(
                            'flutterfire configure',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xFF38BDF8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

