import 'package:get/get.dart';

class MaskController extends GetxController{
  final step = 0.obs;
  final done = false.obs;

  void preStep() {
    step.value--;
  }

  void nextStep() {
    step.value++;
  }
}
