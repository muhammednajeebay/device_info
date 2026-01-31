import 'dart:math' as math;
import 'package:flutter/material.dart';

class SplashIcon extends StatefulWidget {
  final double size;
  final Color color;

  const SplashIcon({
    super.key,
    this.size = 120,
    this.color = const Color(0xFF00E5FF),
  });

  @override
  State<SplashIcon> createState() => _SplashIconState();
}

class _SplashIconState extends State<SplashIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: _SplashIconPainter(
            progress: _controller.value,
            color: widget.color,
          ),
        );
      },
    );
  }
}

class _SplashIconPainter extends CustomPainter {
  final double progress;
  final Color color;

  _SplashIconPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // 1. Draw Outer Biometric Ring
    final ringPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawCircle(center, radius * 0.9, ringPaint);

    // 2. Draw Scanning Intersections
    final linePaint = Paint()
      ..color = color.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    const lineCount = 12;
    for (int i = 0; i < lineCount; i++) {
      final angle = (i * 2 * math.pi / lineCount) + (progress * 0.5);
      final x1 = center.dx + math.cos(angle) * radius * 0.9;
      final y1 = center.dy + math.sin(angle) * radius * 0.9;

      final targetAngle = angle + math.pi * 0.7;
      final x2 = center.dx + math.cos(targetAngle) * radius * 0.9;
      final y2 = center.dy + math.sin(targetAngle) * radius * 0.9;

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), linePaint);
    }

    // 3. Draw Digital Pulse Rhythm
    final pulsePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final pulsePath = Path();
    final pulseWidth = radius * 0.8;
    final pulsePoints = 40;

    for (int i = 0; i < pulsePoints; i++) {
      final x = center.dx - (pulseWidth / 2) + (i * pulseWidth / pulsePoints);
      // Sine wave with dynamic movement
      final normalizedX = i / pulsePoints;
      double wave = math.sin(
        normalizedX * 4 * math.pi + (progress * 2 * math.pi),
      );

      // Add "spike" in the middle
      if (normalizedX > 0.4 && normalizedX < 0.6) {
        wave *= 3.0 * math.sin((normalizedX - 0.4) / 0.2 * math.pi);
      }

      final y = center.dy + (wave * radius * 0.15);

      if (i == 0) {
        pulsePath.moveTo(x, y);
      } else {
        pulsePath.lineTo(x, y);
      }
    }

    // Add glow to pulse
    canvas.drawPath(
      pulsePath,
      Paint()
        ..color = color.withOpacity(0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6.0
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );

    canvas.drawPath(pulsePath, pulsePaint);

    // 4. Center Glowing Core
    canvas.drawCircle(
      center,
      radius * 0.4,
      Paint()
        ..shader = RadialGradient(
          colors: [color.withOpacity(0.15), Colors.transparent],
        ).createShader(Rect.fromCircle(center: center, radius: radius * 0.4)),
    );
  }

  @override
  bool shouldRepaint(covariant _SplashIconPainter oldDelegate) => true;
}
