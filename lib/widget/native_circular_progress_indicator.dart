library custom_ui;

import 'dart:math';

import 'package:flutter/material.dart';

class NativeCircularProgressIndicator extends StatefulWidget {
  const NativeCircularProgressIndicator({
    Key? key,
    required this.size,
    this.stokeWidth = 5,
    this.gradient,
    this.baseGradient,
    this.color,
    this.baseColor,
    this.progress,
  }) : super(key: key);

  final double size;
  final double stokeWidth;
  final Color? color;
  final Color? baseColor;
  final Gradient? gradient;
  final double? progress;
  final Gradient? baseGradient;

  @override
  State<NativeCircularProgressIndicator> createState() =>
      _NativeCircularProgressIndicatorState();
}

class _NativeCircularProgressIndicatorState
    extends State<NativeCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller = AnimationController(vsync: this);
  double progressNull = 0;
  bool isReverse = false;
  double startAngle = 0;

  @override
  void initState() {
    super.initState();
    if (widget.progress == null) {
      _controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
        animationBehavior: AnimationBehavior.preserve,
      )..repeat();

      _controller.addListener(() {
        if (_controller.value > 0.98) {
          isReverse = !isReverse;
        }
        if (isReverse) {
          progressNull = _controller.value * (pi * 2);
          if (_controller.value == 0.5) {
            startAngle = 2 * pi;
          }
        } else {
          progressNull = (1 - _controller.value) * (pi * 2);
          if (_controller.value == 0.5) {
            startAngle = pi / 2;
          }
        }
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double? progress = widget.progress;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        children: [
          //base
          Container(
            width: widget.size,
            height: widget.size,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: CustomPaint(
              painter: MyPainter(
                size: widget.size,
                stokeWidth: widget.stokeWidth,
                color: widget.baseColor ?? Colors.grey,
                gradient: widget.baseGradient,
              ),
            ),
          ),

          //progress
          Container(
            width: widget.size,
            height: widget.size,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: RotationTransition(
              turns: _controller,
              child: CustomPaint(
                painter: MyPainter(
                  size: widget.size,
                  stokeWidth: widget.stokeWidth,
                  startAngle: progress == null ? startAngle : 0,
                  sweepAngle:
                      progress == null ? progressNull : (pi * 2) * progress,
                  color: widget.color ?? Colors.blue,
                  gradient: widget.gradient,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double startAngle;
  final double sweepAngle;
  final double size;
  final double stokeWidth;
  final Gradient? gradient;
  final Color color;

  MyPainter({
    this.startAngle = 0,
    this.sweepAngle = pi * 2,
    this.size = 90,
    required this.color,
    required this.stokeWidth,
    this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Rect outerRect = Offset.zero & size;
    canvas.drawArc(
      outerRect,
      startAngle,
      sweepAngle,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..shader = gradient?.createShader(outerRect)
        ..color = color
        ..strokeWidth = stokeWidth,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
