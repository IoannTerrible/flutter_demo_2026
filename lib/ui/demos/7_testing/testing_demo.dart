import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/demos/7_testing/testing_manager.dart';

class TestingDemo extends StatefulWidget {
  const TestingDemo({super.key});

  @override
  State<TestingDemo> createState() => _TestingDemoState();
}

class _TestingDemoState extends State<TestingDemo> {
  final manager = TestingManager();
  final firstController = TextEditingController();
  final secondController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 50, child: TextField(controller: firstController)),
            SizedBox(width: 10),
            Text('+'),
            SizedBox(width: 10),
            SizedBox(width: 50, child: TextField(controller: secondController)),
            SizedBox(width: 10),
            Text('='),
            SizedBox(width: 10),
            ValueListenableBuilder(
              valueListenable: manager.answerNotifier,
              builder: (context, answer, child) {
                return Text('$answer');
              },
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                manager.add(firstController.text, secondController.text);
              },
              child: Text('Calculate'),
            ),
          ],
        ),
      ),
    );
  }
}
