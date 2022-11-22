import 'package:flutter/foundation.dart';

class MaskController {
  static MaskController? _instance;

  MaskController._internal() {
    _instance = this;
  }

  factory MaskController() => _instance ?? MaskController._internal();

  final ValueNotifier<int> step = ValueNotifier(0);
  final ValueNotifier<bool> done = ValueNotifier(false);
  bool canPop = false;

  void preStep() {
    step.value--;
  }

  void nextStep() {
    step.value++;
  }
}
