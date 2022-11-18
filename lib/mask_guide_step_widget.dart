import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_guide/mask_controller.dart';

class MaskGuideStepWidget extends StatefulWidget {
  const MaskGuideStepWidget({
    Key? key,
    required this.keys,
    this.guideTexts,
    this.customStepWidget,
    required this.doneCallBack,
  }) : super(key: key);

  final List<GlobalKey> keys;
  final List<String>? guideTexts;
  final Widget? customStepWidget;
  final Function? doneCallBack;

  @override
  State<MaskGuideStepWidget> createState() => _MaskGuideStepWidgetState();
}

class _MaskGuideStepWidgetState extends State<MaskGuideStepWidget> {
  final _ctrl = Get.put(MaskController());
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
    return widget.customStepWidget ?? Obx(() {
      double? top;
      double? bottom;
      double? left;
      double? right;
      RenderBox renderBox = widget.keys[_ctrl.step.value].currentContext?.findRenderObject() as RenderBox;
      // 默认位置为左下
      top = renderBox.localToGlobal(Offset.zero).dy + renderBox.size.height + divide;
      left = renderBox.localToGlobal(Offset.zero).dx;

      if (top + stepWidgetSize(widget.guideTexts![_ctrl.step.value]).height > Get.height) {
        top = null;
        bottom = Get.height - renderBox.localToGlobal(Offset.zero).dy + divide;
      }
      if (left + stepWidgetSize(widget.guideTexts![_ctrl.step.value]).width > Get.width) {
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
                widget.guideTexts![_ctrl.step.value],
                style: _textStyle,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      _ctrl.preStep();
                    },
                    child: Text(
                      _ctrl.step.value == 0 ? '' : '上一步',
                      style: _textStyle,
                    ),
                  ),
                  Visibility(
                    visible: _ctrl.step.value != 0,
                    child: const SizedBox(width: 10),
                  ),
                  InkWell(
                    onTap: () {
                      if (_ctrl.step.value >= widget.keys.length - 1) {
                        widget.doneCallBack?.call();
                        Get.delete<MaskController>();
                      } else {
                        _ctrl.nextStep();
                      }
                    },
                    child: Text(
                      _ctrl.step.value >= widget.keys.length - 1 ? '结束' : '下一步',
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
