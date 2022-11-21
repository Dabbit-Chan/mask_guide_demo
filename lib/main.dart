import 'package:flutter/material.dart';
import 'package:mask_guide/custom_step_widget.dart';
import 'package:mask_guide/mask_guide/mask_guide.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey appBarKey = GlobalKey();
  final GlobalKey textKey = GlobalKey();
  final GlobalKey countKey = GlobalKey();
  final GlobalKey buttonKey = GlobalKey();

  final MaskGuide maskGuide = MaskGuide();

  final int _counter = 0;

  void showMaskGuide() {
    maskGuide.showMaskGuide(
      context: context,
      keys: [appBarKey, textKey, countKey, buttonKey],
      guideTexts: ['这是第一个' * 10, '这是第二个', '这是第三个', '这是第四个'],
    );
  }

  void showCustomMaskGuide() {
    maskGuide.showMaskGuide(
      context: context,
      keys: [appBarKey, textKey, countKey, buttonKey],
      customStepWidget: CustomStepWidget(
        keys: [appBarKey, textKey, countKey, buttonKey],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) => showMaskGuide());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: appBarKey,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () => showCustomMaskGuide(),
              child: const Text('Use custom step widget'),
            ),
            const SizedBox(height: 10),
            Text(
              'You have pushed the button this many times:',
              key: textKey,
            ),
            Text(
              '$_counter',
              key: countKey,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: buttonKey,
        onPressed: () => showMaskGuide(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
