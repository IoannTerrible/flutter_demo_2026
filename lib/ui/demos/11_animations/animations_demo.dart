import 'package:flutter/material.dart';

class AnimationsDemo extends StatefulWidget {
  const AnimationsDemo({super.key});

  @override
  State<AnimationsDemo> createState() => _AnimationsDemoState();
}

class _AnimationsDemoState extends State<AnimationsDemo> {
  // 1. Define variables for the changing states
  double _size = 300.0;
  Curve _currentCurve = Curves.easeInOut;

  // A map of different curves to test out
  final Map<String, Curve> _curves = {
    'Ease In Out': Curves.easeInOut,
    'Bounce Out': Curves.bounceOut,
    'Elastic Out': Curves.elasticOut,
    'Linear': Curves.linear,
    'Decelerate': Curves.decelerate,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Curves Demo')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 2. A Dropdown to switch between different Curves
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Select Curve: ', style: TextStyle(fontSize: 18)),
              DropdownButton<Curve>(
                value: _currentCurve,
                items: _curves.entries.map((entry) {
                  return DropdownMenuItem<Curve>(
                    value: entry.value,
                    child: Text(entry.key),
                  );
                }).toList(),
                onChanged: (Curve? newCurve) {
                  if (newCurve != null) {
                    setState(() {
                      _currentCurve = newCurve;
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 3. A button to trigger the size change
          ElevatedButton(
            onPressed: () {
              setState(() {
                // Toggle the size between 100 and 300
                _size = _size == 300.0 ? 100.0 : 300.0;
              });
            },
            child: const Text('Animate Size'),
          ),
          const SizedBox(height: 40),

          // 4. Replace Container with AnimatedContainer
          Center(
            child: AnimatedContainer(
              // The duration controls how long the animation takes
              duration: const Duration(seconds: 1),
              // The curve determines the pacing of the animation
              curve: _currentCurve,
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: _size,
              width: _size,
              // Adding a background color to make the bounding box easier to see
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const FlutterLogo(),
            ),
          ),
        ],
      ),
    );
  }
}
