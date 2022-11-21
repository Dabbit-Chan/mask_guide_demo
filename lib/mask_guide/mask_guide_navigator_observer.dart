import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_guide/mask_guide/mask_controller.dart';

class MaskGuideNavigatorObserver extends NavigatorObserver {

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    try {
      final MaskController ctrl = Get.find<MaskController>();
      if (ctrl.canPop) {
        ctrl.done.value = true;
      }
    } catch(_) {}
  }
}