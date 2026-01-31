import 'dart:math' as math;
import 'package:flutter/material.dart';

class LiquidWaveIcon extends StatefulWidget {
  final double progress; // 0.0 to 1.0
  final bool isCharging;
  final Color color;

  const LiquidWaveIcon({
    super.key,
    required this.progress,
    required this.isCharging,
    required this.color,
  });

  @override
  State<LiquidWaveIcon> createState() => _LiquidWaveIconState();
}

class _LiquidWaveIconState extends State<LiquidWaveIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
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
          size: const Size(40, 70),
          painter: BatteryLiquidPainter(
            progress: widget.progress,
            waveValue: _controller.value,
            color: widget.color,
            isCharging: widget.isCharging,
          ),
        );
      },
    );
  }
}

class BatteryLiquidPainter extends CustomPainter {
  final double progress;
  final double waveValue;
  final Color color;
  final bool isCharging;

  BatteryLiquidPainter({
    required this.progress,
    required this.waveValue,
    required this.color,
    required this.isCharging,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final double waveHeight = 5.0;
    final double fillHeight = size.height * (1 - progress);

    // Battery Shell
    final shellPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final RRect batteryBody = RRect.fromLTRBR(
      0,
      5,
      size.width,
      size.height,
      const Radius.circular(4),
    );
    canvas.drawRRect(batteryBody, shellPaint);

    // Battery Tip
    canvas.drawRRect(
      RRect.fromLTRBR(
        size.width * 0.3,
        0,
        size.width * 0.7,
        5,
        const Radius.circular(1),
      ),
      shellPaint,
    );

    // Liquid Path
    path.moveTo(0, fillHeight);
    for (double x = 0; x <= size.width; x++) {
      final double y =
          fillHeight +
          math.sin((waveValue * 2 * math.pi) + (x / size.width * 2 * math.pi)) *
              waveHeight;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Clipping to battery body
    canvas.save();
    canvas.clipRRect(batteryBody);
    canvas.drawPath(path, paint);

    // Bubbles
    final bubblePaint = Paint()..color = Colors.white.withOpacity(0.3);
    final random = math.Random(42);
    for (int i = 0; i < 5; i++) {
      double bx = random.nextDouble() * size.width;
      double by =
          size.height -
          ((waveValue + random.nextDouble()) % 1.0) *
              (size.height - fillHeight);
      if (by > fillHeight) {
        canvas.drawCircle(Offset(bx, by), 2, bubblePaint);
      }
    }

    // Charging Bolt
    if (isCharging) {
      final boltPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 5);

      final boltPath = Path();
      boltPath.moveTo(size.width * 0.5, size.height * 0.2);
      boltPath.lineTo(size.width * 0.3, size.height * 0.5);
      boltPath.lineTo(size.width * 0.5, size.height * 0.5);
      boltPath.lineTo(size.width * 0.4, size.height * 0.8);
      boltPath.lineTo(size.width * 0.7, size.height * 0.45);
      boltPath.lineTo(size.width * 0.5, size.height * 0.45);
      boltPath.close();

      canvas.drawPath(boltPath, boltPaint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(BatteryLiquidPainter oldDelegate) => true;
}
