import 'package:flutter/material.dart';
import 'package:mask_guide/mask_guide/step_widget.dart';

class CustomStepWidget extends StepWidget {
  CustomStepWidget({
    Key? key,
    required this.keys,
  }) : super(key: key);

  final List<GlobalKey> keys;

  @override
  void preStep() {
    super.preStep();
    print('preStep');
  }

  @override
  void nextStep() {
    super.nextStep();
    print('nextStep');
  }

  @override
  void doneCallBack() {
    super.doneCallBack();
    print('doneCallBack');
  }

  final double divide = 10;
  final double stepHeight = 50;
  final double stepWidth = 100;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: stepNotifier,
      builder: (context, value, child) {
        double? top;
        double? bottom;
        double? left;
        double? right;
        RenderBox renderBox = keys[step].currentContext?.findRenderObject() as RenderBox;
        // 默认位置为左下
        top = renderBox.localToGlobal(Offset.zero).dy + renderBox.size.height + divide;
        left = renderBox.localToGlobal(Offset.zero).dx;

        if (top + stepHeight > MediaQuery.of(context).size.height) {
          top = null;
          bottom = MediaQuery.of(context).size.height - renderBox.localToGlobal(Offset.zero).dy + divide;
        }

        if (left + stepWidth > MediaQuery.of(context).size.width) {
          left = null;
          right = MediaQuery.of(context).size.width - renderBox.localToGlobal(Offset.zero).dx - renderBox.size.width;
        }

        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          top: top,
          bottom: bottom,
          right: right,
          left: left,
          child: InkWell(
            onTap: () {
              if (step >= keys.length - 1) {
                doneCallBack.call();
              } else {
                nextStep();
              }
            },
            onDoubleTap: () {
              if (step != 0) {
                preStep();
              }
            },
            child: Container(
              height: stepHeight,
              width: stepWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: step.isEven ? Colors.green : Colors.blue,
              ),
              alignment: Alignment.center,
              child: Text(
                '${step + 1}/4',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}