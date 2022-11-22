import 'package:flutter/material.dart';
import 'package:mask_guide/mask_guide/mask_controller.dart';

class MaskGuideNavigatorObserver extends NavigatorObserver {

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    try {
      final MaskController controller = MaskController();
      if (controller.canPop) {
        controller.done.value = true;
      }
    } catch(_) {}
  }
}