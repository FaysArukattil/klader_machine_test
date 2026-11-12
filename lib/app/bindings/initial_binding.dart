import 'package:get/get.dart';

import '../data/services/auth_service.dart';

/// App-wide dependencies that live for the whole app lifetime.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthService>(AuthService(), permanent: true);
  }
}
