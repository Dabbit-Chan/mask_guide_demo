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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [MaskGuideNavigatorObserver()],
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool autoStart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Page')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => MyHomePage(autoStart: autoStart)));
              },
              child: const Text('Start'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Auto Show:'),
                Switch(value: autoStart, onChanged: (value) {
                  setState(() {
                    autoStart = value;
                  });
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.autoStart});

  final bool autoStart;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey redKey = GlobalKey();
  final GlobalKey yellowKey = GlobalKey();
  final GlobalKey blueKey = GlobalKey();
  final GlobalKey greenKey = GlobalKey();

  final MaskGuide maskGuide = MaskGuide();

  bool pop = false;
  bool prevent = false;

  void showMaskGuide({required bool canPop, required bool canDismiss}) {
    if (canPop) {
      prevent = false;
      pop = true;
    } else {
      prevent = true;
      pop = false;
    }
    maskGuide.showMaskGuide(
      context: context,
      keys: [redKey, yellowKey, blueKey, greenKey],
      guideTexts: ['这是第一个' * 10, '这是第二个', '这是第三个', '这是第四个'],
      canPop: canPop,
      canDismiss: canDismiss,
      doneCallBack: () {
        prevent = false;
        pop = true;
        print('default done');
      },
      dismissCallBack: () {
        prevent = false;
        pop = true;
        print('default dismiss');
      }
    );
  }

  void showCustomMaskGuide({required bool canPop, required bool canDismiss}) {
    if (canPop) {
      prevent = false;
      pop = true;
    } else {
      prevent = true;
      pop = false;
    }
    maskGuide.showMaskGuide(
      context: context,
      keys: [redKey, yellowKey, blueKey, greenKey],
      customStepWidget: CustomStepWidget(
        keys: [redKey, yellowKey, blueKey, greenKey],
      ),
      canPop: canPop,
      canDismiss: canDismiss,
      doneCallBack: () {
        prevent = false;
        pop = true;
        print('custom done');
      },
      dismissCallBack: () {
        prevent = false;
        pop = true;
        print('custom dismiss');
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.autoStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) => showMaskGuide(canPop: false, canDismiss: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (prevent) {
          return Future.value(pop);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showMaskGuide(canPop: false, canDismiss: false);
                    },
                    child: const Text("Default, can't dismiss, can't pop"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showMaskGuide(canPop: true, canDismiss: false);
                    },
                    child: const Text("Default, can't dismiss, can pop"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showMaskGuide(canPop: false, canDismiss: true);
                    },
                    child: const Text("Default, can dismiss, can't pop"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showMaskGuide(canPop: true, canDismiss: true);
                    },
                    child: const Text("Default, can dismiss, can pop"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showCustomMaskGuide(canPop: false, canDismiss: false);
                    },
                    child: const Text("Custom, can't dismiss, can't pop"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showCustomMaskGuide(canPop: true, canDismiss: false);
                    },
                    child: const Text("Custom, can't dismiss, can pop"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showCustomMaskGuide(canPop: false, canDismiss: true);
                    },
                    child: const Text("Custom, can dismiss, can't pop"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showCustomMaskGuide(canPop: true, canDismiss: true);
                    },
                    child: const Text("Custom, can dismiss, can pop"),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    key: redKey,
                    width: 50,
                    height: 50,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    key: yellowKey,
                    width: 50,
                    height: 50,
                    color: Colors.yellow,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    key: blueKey,
                    width: 50,
                    height: 50,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 30),
                  Container(
                    key: greenKey,
                    width: 50,
                    height: 50,
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
