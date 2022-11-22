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
    List<Function>? nextStepCallBacks,
    List<Function>? preStepCallBacks,
    /// UI
    double? divide,
    EdgeInsets? margin,
    /// stepWidget UI
    double? maxWidthScale,
    String? nextText,
    String? preText,
    String? doneText,
    TextStyle? guideTextStyle,
    TextStyle? stepTextStyle,
    EdgeInsets? stepPadding,
    BorderRadius? stepBorderRadius,
    Color? stepColor,
  }) {
    if (customStepWidget == null && guideTexts == null) {
      throw('自定义提示组件和需要展示的提示其中一个必不能为空');
    }
    if (customStepWidget == null && keys.length != guideTexts!.length) {
      throw('不使用自定义提示组件时，key的数量需要和引导词的数量一致');
    }
    if (nextStepCallBacks != null && nextStepCallBacks.length != keys.length) {
      throw('nextStepCallBacks长度必须与keys长度一致');
    }
    if (preStepCallBacks != null && preStepCallBacks.length != keys.length) {
      throw('preStepCallBacks长度必须与keys长度一致');
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
        nextStepCallBacks: nextStepCallBacks,
        preStepCallBacks: preStepCallBacks,
        divide: divide ?? 10,
        margin: margin ?? EdgeInsets.zero,
        maxWidthScale: maxWidthScale ?? 2/3,
        nextText: nextText ?? '下一个',
        preText: preText ?? '上一个',
        doneText: doneText ?? '完成',
        guideTextStyle: guideTextStyle ?? const TextStyle(
          fontSize: 12,
          color: Colors.black,
        ),
        stepTextStyle: stepTextStyle ?? const TextStyle(
          fontSize: 12,
          color: Colors.blue,
        ),
        stepPadding: stepPadding ?? const EdgeInsets.all(5),
        stepBorderRadius: stepBorderRadius ?? BorderRadius.circular(10),
        stepColor: stepColor ?? Colors.white,
      ),
    );

    Overlay.of(context)!.insert(overlayEntry);
  }
}
