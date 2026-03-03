import 'package:flutter/material.dart';

class StateManagementManager {
  final colorNotifier = ValueNotifier<Color>(Colors.black);
  final numberNotifier = ValueNotifier<int>(1);

  int _colorIndex = 0;
  final _colors = [
    Colors.blue,
    Colors.yellow,
    Colors.teal,
    Colors.lightGreen,
    Colors.deepPurple,
    Colors.red,
  ];

  void changeColor() {
    _colorIndex++;
    _colorIndex = _colorIndex % _colors.length;
    final color = _colors[_colorIndex];
    colorNotifier.value = color;
  }

  void changeText() {
    numberNotifier.value++;
  }
}
