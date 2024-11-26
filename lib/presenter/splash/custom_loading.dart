import 'dart:math';

import 'package:flutter/material.dart';

class FancyLoadingIndicator extends StatefulWidget {
  const FancyLoadingIndicator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FancyLoadingIndicatorState createState() => _FancyLoadingIndicatorState();
}

class _FancyLoadingIndicatorState extends State<FancyLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Tốc độ quay
    )..repeat(); // Lặp vô hạn
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * pi, // Góc xoay
            child: CustomPaint(
              size: const Size(100, 100), // Kích thước vòng
              painter: _FancyPainter(),
            ),
          );
        },
      ),
    );
  }
}

class _FancyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = SweepGradient(
      colors: [
        Colors.purple,
        Colors.blue,
        Colors.cyan,
        Colors.greenAccent,
        Colors.yellow,
        Colors.orange,
        Colors.red,
        Colors.purple,
      ],
      stops: [0.0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 1.0],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round; // Bo tròn đầu nét vẽ

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      0,
      2 * pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
