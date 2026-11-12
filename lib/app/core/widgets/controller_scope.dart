import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

/// Manages the lifecycle of a [GetxController] bound to a widget subtree.
///
/// Automatically creates and registers [T] in [Get] upon initialization,
/// supplies the instance directly to [builder] so child widgets never rely
/// on dynamic [Get.find] lookups during build or route transitions, and cleanly
/// disposes [T] when the widget is unmounted (deferred to post-frame to eliminate
/// mid-frame unmount exceptions with reactive widgets like [Obx]).
class ControllerScope<T extends GetxController> extends StatefulWidget {
  const ControllerScope({
    super.key,
    required this.create,
    required this.builder,
  });

  final T Function() create;
  final Widget Function(BuildContext context, T controller) builder;

  @override
  State<ControllerScope<T>> createState() => _ControllerScopeState<T>();
}

class _ControllerScopeState<T extends GetxController>
    extends State<ControllerScope<T>> {
  late final T _controller;

  @override
  void initState() {
    super.initState();
    if (Get.isRegistered<T>()) {
      Get.delete<T>(force: true);
    }
    _controller = Get.put<T>(widget.create());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.isRegistered<T>()) {
        Get.delete<T>(force: true);
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _controller);
}
