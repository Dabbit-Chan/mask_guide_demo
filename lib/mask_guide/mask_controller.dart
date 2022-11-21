import 'package:get/get.dart';

class MaskController extends GetxController{
  final RxInt step = 0.obs;
  final RxBool done = false.obs;
  bool canPop = false;

  void preStep() {
    step.value--;
  }

  void nextStep() {
    step.value++;
  }
}
