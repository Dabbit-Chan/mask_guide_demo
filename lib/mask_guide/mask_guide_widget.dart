import 'package:flutter/material.dart';
import 'package:mask_guide/mask_guide/default_step_widget.dart';
import 'package:mask_guide/mask_guide/mask_controller.dart';
import 'package:mask_guide/mask_guide/step_widget.dart';

class MaskGuideWidget extends StatefulWidget {
  const MaskGuideWidget({
    Key? key,
    required this.keys,
    this.guideTexts,
    this.customStepWidget,
    required this.overlay,
    required this.needAnimate,
    required this.canPop,
    required this.canDismiss,
    this.dismissCallBack,
    this.doneCallBack,
    this.nextStepCallBacks,
    this.preStepCallBacks,
  }) : super(key: key);

  /// 主要
  final List<GlobalKey> keys;
  final List<String>? guideTexts;
  final StepWidget? customStepWidget;
  final OverlayEntry overlay;
  /// 次要
  final bool needAnimate;
  final bool canPop;
  final bool canDismiss;
  final Function? dismissCallBack;
  final Function? doneCallBack;
  final List<Function>? nextStepCallBacks;
  final List<Function>? preStepCallBacks;

  @override
  State<MaskGuideWidget> createState() => _MaskGuideWidgetState();
}

class _MaskGuideWidgetState extends State<MaskGuideWidget> {
  final MaskController controller = MaskController();

  void doneListener() {
    if (controller.done.value) {
      controller.done.removeListener(doneListener);
      controller.done.value = false;
      controller.step.value = 0;

      widget.overlay.remove();
      widget.dismissCallBack?.call();
    }
  }

  @override
  void initState() {
    super.initState();
    controller.canPop = widget.canPop;
    controller.done.addListener(doneListener);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              if (widget.canDismiss) {
                controller.done.removeListener(doneListener);
                controller.done.value = false;
                controller.step.value = 0;

                widget.overlay.remove();
                widget.dismissCallBack?.call();
              }
            },
            child: ColorFiltered(
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
                  ValueListenableBuilder(
                    valueListenable: controller.step,
                    builder: (context, value, child) {
                      RenderBox renderBox = widget.keys[controller.step.value].currentContext?.findRenderObject() as RenderBox;
                      return AnimatedPositioned(
                        duration: widget.needAnimate ? const Duration(milliseconds: 300) : Duration.zero,
                        left: renderBox.localToGlobal(Offset.zero).dx,
                        top: renderBox.localToGlobal(Offset.zero).dy,
                        child: Container(
                          width: renderBox.size.width,
                          height: renderBox.size.height,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          widget.customStepWidget ?? DefaultStepWidget(
            keys: widget.keys,
            guideTexts: widget.guideTexts,
            needAnimate: widget.needAnimate,
            nextStepCallBacks: widget.nextStepCallBacks,
            preStepCallBacks: widget.preStepCallBacks,
          ),
        ],
      ),
    );
  }
}
