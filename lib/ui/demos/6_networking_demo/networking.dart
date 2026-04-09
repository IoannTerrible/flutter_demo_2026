import 'package:flutter/material.dart';
import 'networking_manager.dart'; 

class NetworkingDemoWidget extends StatefulWidget {
  const NetworkingDemoWidget({super.key});

  @override
  State<NetworkingDemoWidget> createState() => _NetworkingDemoWidgetState();
}

class _NetworkingDemoWidgetState extends State<NetworkingDemoWidget> {
  final api = NetworkHelper();
  final result = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();
    api.init();
  }

  @override
  void dispose() {
    result.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(title: const Text("Networking")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                result.value = await api.get(1);
              },
              child: Text('GET'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                result.value = await api.post({
                  "title": "test",
                  "body": "hello",
                  "userId": 1
                });
              },
              child: Text('POST'),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder(
              valueListenable: result,
              builder: (context, value, _) => Text(value),
            ),
            ]
        ),
      ),
    ));
  }
}