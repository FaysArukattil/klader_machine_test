import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:klader_machine_test/app/core/widgets/controller_scope.dart';

class _TestController extends GetxController {
  bool isDisposed = false;
  final counter = 0.obs;

  @override
  void onClose() {
    isDisposed = true;
    super.onClose();
  }
}

void main() {
  testWidgets('ControllerScope registers controller, provides it to builder, and cleans up post frame on dispose', (tester) async {
    _TestController? capturedController;

    await tester.pumpWidget(
      MaterialApp(
        home: ControllerScope<_TestController>(
          create: _TestController.new,
          builder: (context, controller) {
            capturedController = controller;
            return Obx(() => Text('Count: ${controller.counter.value}'));
          },
        ),
      ),
    );

    expect(find.text('Count: 0'), findsOneWidget);
    expect(Get.isRegistered<_TestController>(), isTrue);
    expect(capturedController, isNotNull);

    // Update value reactively
    capturedController!.counter.value = 5;
    await tester.pump();
    expect(find.text('Count: 5'), findsOneWidget);

    // Unmount ControllerScope
    await tester.pumpWidget(const MaterialApp(home: SizedBox()));
    // During the unmount frame, post frame callback hasn't fired yet
    await tester.pump(); // fires post frame callbacks

    expect(Get.isRegistered<_TestController>(), isFalse);
    expect(capturedController!.isDisposed, isTrue);
  });
}

