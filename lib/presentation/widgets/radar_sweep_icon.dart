import 'dart:math' as math;
import 'package:flutter/material.dart';

class RadarSweepIcon extends StatefulWidget {
  final Color color;

  const RadarSweepIcon({super.key, required this.color});

  @override
  State<RadarSweepIcon> createState() => _RadarSweepIconState();
}

class _RadarSweepIconState extends State<RadarSweepIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
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
          size: const Size(60, 60),
          painter: RadarPainter(
            rotation: _controller.value * 2 * math.pi,
            color: widget.color,
          ),
        );
      },
    );
  }
}

class RadarPainter extends CustomPainter {
  final double rotation;
  final Color color;

  RadarPainter({required this.rotation, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Grid circles
    final gridPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(center, radius * 0.4, gridPaint);
    canvas.drawCircle(center, radius * 0.7, gridPaint);
    canvas.drawCircle(center, radius, gridPaint);

    // Crosshair
    canvas.drawLine(
      Offset(center.dx - radius, center.dy),
      Offset(center.dx + radius, center.dy),
      gridPaint,
    );
    canvas.drawLine(
      Offset(center.dx, center.dy - radius),
      Offset(center.dx, center.dy + radius),
      gridPaint,
    );

    // Sweep line
    final sweepPaint = Paint()
      ..shader = SweepGradient(
        colors: [Colors.transparent, color.withOpacity(0.5)],
        stops: const [0.7, 1.0],
        transform: GradientRotation(rotation - math.pi / 2),
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      rotation - math.pi / 2,
      math.pi / 4,
      true,
      sweepPaint,
    );

    // Random "Blips"
    final blipPaint = Paint()..color = color;
    final random = math.Random(42);
    for (int i = 0; i < 3; i++) {
      final angle = random.nextDouble() * 2 * math.pi;
      final dist = radius * (0.3 + random.nextDouble() * 0.6);
      final x = center.dx + math.cos(angle) * dist;
      final y = center.dy + math.sin(angle) * dist;

      // Only show if sweep passed recently (simplified)
      canvas.drawCircle(
        Offset(x, y),
        2,
        Paint()..color = color.withOpacity(0.4),
      );
    }
  }

  @override
  bool shouldRepaint(RadarPainter oldDelegate) => true;
}
