import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_guide/step_widget.dart';

// ignore: must_be_immutable
class MyStepWidget extends StepWidget {
  MyStepWidget({
    Key? key,
    required this.keys,
    this.guideTexts,
    required this.removeEntry,
  }) : super(key: key, remove: removeEntry);

  final List<GlobalKey> keys;
  final List<String>? guideTexts;
  final Function? removeEntry;

  final TextStyle _textStyle = const TextStyle(
    fontSize: 12,
    color: Colors.black,
  );

  Size stepWidgetSize(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: _textStyle),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: Get.width * 2 / 3, minWidth: 82);
    return Size(textPainter.size.width + 10, textPainter.size.height + 10);
  }

  double divide = 10;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      double? top;
      double? bottom;
      double? left;
      double? right;
      RenderBox renderBox = keys[step].currentContext?.findRenderObject() as RenderBox;
      // 默认位置为左下
      top = renderBox.localToGlobal(Offset.zero).dy + renderBox.size.height + divide;
      left = renderBox.localToGlobal(Offset.zero).dx;

      if (top + stepWidgetSize(guideTexts![step]).height > Get.height) {
        top = null;
        bottom = Get.height - renderBox.localToGlobal(Offset.zero).dy + divide;
      }

      if (left + stepWidgetSize(guideTexts![step]).width > Get.width) {
        left = null;
        right = Get.width - renderBox.localToGlobal(Offset.zero).dx - renderBox.size.width;
      }

      return AnimatedPositioned(
        duration: const Duration(milliseconds: 300),
        top: top,
        bottom: bottom,
        right: right,
        left: left,
        child: Container(
          padding: const EdgeInsets.all(5),
          constraints: BoxConstraints(
            maxWidth: Get.width * 2 / 3,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                guideTexts![step],
                style: _textStyle,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      preStep();
                    },
                    child: Text(
                      step == 0 ? '' : '上一步',
                      style: _textStyle,
                    ),
                  ),
                  Visibility(
                    visible: step != 0,
                    child: const SizedBox(width: 10),
                  ),
                  InkWell(
                    onTap: () {
                      if (step >= keys.length - 1) {
                        doneCallBack.call();
                      } else {
                        nextStep();
                      }
                    },
                    child: Text(
                      step >= keys.length - 1 ? '结束' : '下一步',
                      style: _textStyle.copyWith(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}