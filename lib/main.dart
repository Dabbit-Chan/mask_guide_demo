import 'package:flutter/material.dart';
import 'package:mask_guide/custom_step_widget.dart';
import 'package:mask_guide/mask_guide/mask_guide.dart';
import 'package:mask_guide/mask_guide/mask_guide_navigator_observer.dart';

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
      navigatorObservers: [MaskGuideNavigatorObserver()],
      home: const FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MyHomePage(title: 'Flutter Demo Home Page')));
          },
          child: const Text('跳转'),
        ),
      ),
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

  bool canPop = false;
  bool prevent = false;

  void showMaskGuide() {
    prevent = false;
    maskGuide.showMaskGuide(
      context: context,
      keys: [appBarKey, textKey, countKey, buttonKey],
      guideTexts: ['这是第一个' * 10, '这是第二个', '这是第三个', '这是第四个'],
      canPop: true,
      doneCallBack: () {
        print('default done');
      }
    );
  }

  void showCustomMaskGuide() {
    prevent = true;
    maskGuide.showMaskGuide(
      context: context,
      keys: [appBarKey, textKey, countKey, buttonKey],
      customStepWidget: CustomStepWidget(
        keys: [appBarKey, textKey, countKey, buttonKey],
      ),
      canDismiss: true,
      dismissCallBack: () {
        prevent = false;
      },
      doneCallBack: () {
        canPop = true;
        print('custom done');
      }
    );
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) => showMaskGuide());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (prevent) {
          return Future.value(canPop);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
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
                '0',
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
      ),
    );
  }
}
