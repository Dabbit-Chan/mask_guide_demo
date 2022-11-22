import 'package:flutter/material.dart';
import 'package:mask_guide/mask_guide/mask_controller.dart';

abstract class StepWidget extends StatelessWidget {
  StepWidget({super.key});

  final MaskController controller = MaskController();
  ValueNotifier<int> get stepNotifier => controller.step;
  int get step => stepNotifier.value;

  void preStep() {
    controller.preStep();
  }

  void nextStep() {
    controller.nextStep();
  }

  void doneCallBack() {
    controller.done.value = true;
  }
}
