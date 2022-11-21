import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_guide/mask_controller.dart';

abstract class StepWidget extends StatelessWidget {
  StepWidget({Key? key}) : super(key: key);

  final _ctrl = Get.put(MaskController());

  int get step => _ctrl.step.value;

  void preStep() {
    _ctrl.step.value--;
  }

  void nextStep() {
    _ctrl.step.value++;
  }

  void doneCallBack() {
    Get.delete<MaskController>();
  }
}
