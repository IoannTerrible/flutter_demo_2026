import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PaintingDemo extends StatefulWidget {
  const PaintingDemo({super.key});

  @override
  State<PaintingDemo> createState() => _PaintingDemoState();
}

class _PaintingDemoState extends State<PaintingDemo> {
  double _cp1X = 80;
  double _cp1Y = 30;
  double _cp2X = 220;
  double _cp2Y = 270;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: CustomPaint(
                size: const Size(300, 300),
                painter: MyPainter(cp1X: _cp1X, cp1Y: _cp1Y, cp2X: _cp2X, cp2Y: _cp2Y),
              ),
            ),
            const SizedBox(height: 16),
            _SliderRow(label: 'CP1 X', value: _cp1X, onChanged: (v) => setState(() => _cp1X = v)),
            _SliderRow(label: 'CP1 Y', value: _cp1Y, onChanged: (v) => setState(() => _cp1Y = v)),
            _SliderRow(label: 'CP2 X', value: _cp2X, onChanged: (v) => setState(() => _cp2X = v)),
            _SliderRow(label: 'CP2 Y', value: _cp2Y, onChanged: (v) => setState(() => _cp2Y = v)),
          ],
        ),
      ),
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({required this.label, required this.value, required this.onChanged});
  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 80, child: Text('$label: ${value.toStringAsFixed(0)}', textAlign: TextAlign.end)),
        Expanded(child: Slider(value: value, min: 0, max: 300, onChanged: onChanged)),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  const MyPainter({required this.cp1X, required this.cp1Y, required this.cp2X, required this.cp2Y});
  final double cp1X, cp1Y, cp2X, cp2Y;

  static const _startX = 30.0;
  static const _startY = 150.0;
  static const _endX = 270.0;
  static const _endY = 150.0;

  @override
  void paint(Canvas canvas, Size size) {
    final curvePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final path = Path()
      ..moveTo(_startX, _startY)
      ..cubicTo(cp1X, cp1Y, cp2X, cp2Y, _endX, _endY);
    canvas.drawPath(path, curvePaint);

    // draw control point handles
    final handlePaint = Paint()
      ..color = Colors.blue.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawLine(Offset(_startX, _startY), Offset(cp1X, cp1Y), handlePaint);
    canvas.drawLine(Offset(_endX, _endY), Offset(cp2X, cp2Y), handlePaint);

    final dotPaint = Paint()..color = Colors.blue;
    canvas.drawCircle(Offset(cp1X, cp1Y), 5, dotPaint);
    canvas.drawCircle(Offset(cp2X, cp2Y), 5, dotPaint);
  }

  @override
  bool shouldRepaint(MyPainter old) {
    return old.cp1X != cp1X || old.cp1Y != cp1Y || old.cp2X != cp2X || old.cp2Y != cp2Y;
  }
}

class ProgressBar extends LeafRenderObjectWidget {
  const ProgressBar({
    super.key,
    required this.barColor,
    required this.thumbColor,
    this.thumbSize = 20.0,
  });

  final Color barColor;
  final Color thumbColor;
  final double thumbSize;

  @override
  RenderProgressBar createRenderObject(BuildContext context) {
    return RenderProgressBar(
      barColor: barColor,
      thumbColor: thumbColor,
      thumbSize: thumbSize,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderProgressBar renderObject,
  ) {
    renderObject
      ..barColor = barColor
      ..thumbColor = thumbColor
      ..thumbSize = thumbSize;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('barColor', barColor));
    properties.add(ColorProperty('thumbColor', thumbColor));
    properties.add(DoubleProperty('thumbSize', thumbSize));
  }
}

class RenderProgressBar extends RenderBox {
  RenderProgressBar({
    required Color barColor,
    required Color thumbColor,
    required double thumbSize,
  }) : _barColor = barColor,
       _thumbColor = thumbColor,
       _thumbSize = thumbSize {
    // initialize the gesture recognizer
    _drag = HorizontalDragGestureRecognizer()
      ..onStart = (DragStartDetails details) {
        _updateThumbPosition(details.localPosition);
      }
      ..onUpdate = (DragUpdateDetails details) {
        _updateThumbPosition(details.localPosition);
      };
  }

  void _updateThumbPosition(Offset localPosition) {
    var dx = localPosition.dx.clamp(0, size.width);
    _currentThumbValue = dx / size.width;
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  Color get barColor => _barColor;
  Color _barColor;
  set barColor(Color value) {
    if (_barColor == value) return;
    _barColor = value;
    markNeedsPaint();
  }

  Color get thumbColor => _thumbColor;
  Color _thumbColor;
  set thumbColor(Color value) {
    if (_thumbColor == value) return;
    _thumbColor = value;
    markNeedsPaint();
  }

  double get thumbSize => _thumbSize;
  double _thumbSize;
  set thumbSize(double value) {
    if (_thumbSize == value) return;
    _thumbSize = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final desiredWidth = constraints.maxWidth;
    final desiredHeight = thumbSize;
    final desiredSize = Size(desiredWidth, desiredHeight);
    return constraints.constrain(desiredSize);
  }

  static const _minDesiredWidth = 100.0;

  @override
  double computeMinIntrinsicWidth(double height) => _minDesiredWidth;

  @override
  double computeMaxIntrinsicWidth(double height) => _minDesiredWidth;

  @override
  double computeMinIntrinsicHeight(double width) => thumbSize;

  @override
  double computeMaxIntrinsicHeight(double width) => thumbSize;

  double _currentThumbValue = 0.5;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    
  }

  late HorizontalDragGestureRecognizer _drag;

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent) {
      _drag.addPointer(event);
    }
  }
}
