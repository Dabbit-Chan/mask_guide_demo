import 'package:flutter/material.dart';
import 'package:mask_guide/default_step_widget.dart';

class MaskGuideStepWidget extends StatefulWidget {
  const MaskGuideStepWidget({
    Key? key,
    required this.keys,
    this.guideTexts,
    this.customStepWidget,
    required this.removeEntry,
  }) : super(key: key);

  final List<GlobalKey> keys;
  final List<String>? guideTexts;
  final Widget? customStepWidget;
  final Function? removeEntry;

  @override
  State<MaskGuideStepWidget> createState() => _MaskGuideStepWidgetState();
}

class _MaskGuideStepWidgetState extends State<MaskGuideStepWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.customStepWidget ?? MyStepWidget(
      keys: widget.keys,
      guideTexts: widget.guideTexts,
      removeEntry: widget.removeEntry,
    );
  }
}
