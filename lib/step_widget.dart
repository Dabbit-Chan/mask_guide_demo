import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_guide/mask_controller.dart';

// ignore: must_be_immutable
abstract class StepWidget extends StatelessWidget {
  StepWidget({super.key});

  final MaskController _ctrl = Get.put(MaskController());
  int get step => _ctrl.step.value;

  void preStep() {
    _ctrl.preStep();
  }

  void nextStep() {
    _ctrl.nextStep();
  }

  void doneCallBack() {
    _ctrl.done.value = true;
  }
}
