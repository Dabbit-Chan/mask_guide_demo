import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_guide/mask_controller.dart';
import 'package:mask_guide/mask_guide_step_widget.dart';

class MaskGuideWidget extends StatefulWidget {
  const MaskGuideWidget({
    Key? key,
    required this.keys,
    this.guideTexts,
    this.doneCallBack,
    this.customStepWidget,
  }) : super(key: key);

  final List<GlobalKey> keys;
  final List<String>? guideTexts;
  final Widget? customStepWidget;
  final Function? doneCallBack;

  @override
  State<MaskGuideWidget> createState() => _MaskGuideWidgetState();
}

class _MaskGuideWidgetState extends State<MaskGuideWidget> {
  final _ctrl = Get.put(MaskController());

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          ColorFiltered(
            // 源图像，使用srcOut
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(.8),
              BlendMode.srcOut,
            ),
            child: Stack(
              children: [
                // 目标图像
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                ),
                Obx(() {
                  RenderBox renderBox = widget.keys[_ctrl.step.value].currentContext?.findRenderObject() as RenderBox;
                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    left: renderBox.localToGlobal(Offset.zero).dx,
                    top: renderBox.localToGlobal(Offset.zero).dy,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      width: renderBox.size.width,
                      height: renderBox.size.height,
                    ),
                  );
                }),
              ],
            ),
          ),
          // 这里同样通过key可以拿到位置信息，然后显示步骤描述即可
          MaskGuideStepWidget(
            keys: widget.keys,
            guideTexts: widget.guideTexts,
            customStepWidget: widget.customStepWidget,
            doneCallBack: widget.doneCallBack,
          ),
        ],
      ),
    );
  }
}
