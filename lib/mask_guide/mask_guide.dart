import 'package:flutter/material.dart';
import 'package:mask_guide/mask_guide/mask_guide_widget.dart';
import 'package:mask_guide/mask_guide/step_widget.dart';

class MaskGuide {
  late OverlayEntry overlayEntry;

  showMaskGuide({
    /// 主要
    required BuildContext context,
    required List<GlobalKey> keys,
    List<String>? guideTexts,
    StepWidget? customStepWidget,
    /// 次要
    bool? needAnimate,
    bool? canPop,
    bool? canDismiss,
    Function? dismissCallBack,
    Function? doneCallBack,
  }) {
    if (customStepWidget == null && guideTexts == null) {
      throw('自定义提示组件和需要展示的提示其中一个必不能为空');
    }
    if (customStepWidget == null && keys.length != guideTexts!.length) {
      throw('不使用自定义提示组件时，key的数量需要和引导词的数量一致');
    }

    overlayEntry = OverlayEntry(
      builder: (_) => MaskGuideWidget(
        keys: keys,
        guideTexts: guideTexts,
        customStepWidget: customStepWidget,
        overlay: overlayEntry,
        needAnimate: needAnimate ?? true,
        canPop: canPop ?? false,
        canDismiss: canDismiss ?? false,
        dismissCallBack: dismissCallBack,
        doneCallBack: doneCallBack,
      ),
    );

    Overlay.of(context)!.insert(overlayEntry);
  }
}
