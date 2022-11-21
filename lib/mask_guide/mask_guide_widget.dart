import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  State<MaskGuideWidget> createState() => _MaskGuideWidgetState();
}

class _MaskGuideWidgetState extends State<MaskGuideWidget> {
  final MaskController _ctrl = Get.put(MaskController());

  @override
  void initState() {
    super.initState();
    _ctrl.canPop = widget.canPop;
    _ctrl.done.stream.listen((done) {
      if (done) {
        widget.overlay.remove();
        Get.delete<MaskController>();
        widget.doneCallBack?.call();
      }
    });
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
                widget.overlay.remove();
                Get.delete<MaskController>();
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
                  Obx(() {
                    RenderBox renderBox = widget.keys[_ctrl.step.value].currentContext?.findRenderObject() as RenderBox;
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
                  }),
                ],
              ),
            ),
          ),

          widget.customStepWidget ?? DefaultStepWidget(
            keys: widget.keys,
            guideTexts: widget.guideTexts,
            needAnimate: widget.needAnimate,
          ),
        ],
      ),
    );
  }
}
