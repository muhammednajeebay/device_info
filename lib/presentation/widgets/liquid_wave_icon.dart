import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/settings/settings_bloc.dart';
import '../../blocs/settings/settings_state.dart';

class LiquidWaveIcon extends StatefulWidget {
  final double progress; // 0.0 to 1.0
  final bool isCharging;
  final Color color;
  final double? width;
  final double? height;

  const LiquidWaveIcon({
    super.key,
    required this.progress,
    required this.isCharging,
    required this.color,
    this.width,
    this.height,
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
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state.reducedMotion) {
          _controller.stop();
        } else if (!_controller.isAnimating) {
          _controller.repeat();
        }
      },
      builder: (context, state) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              size: Size(widget.width ?? 100, widget.height ?? 180),
              painter: BatteryLiquidPainter(
                progress: widget.progress,
                waveValue: state.reducedMotion ? 0.0 : _controller.value,
                color: widget.color,
                isCharging: widget.isCharging,
                lowPower: state.lowPowerMode,
                reducedMotion: state.reducedMotion,
              ),
            );
          },
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
  final bool lowPower;
  final bool reducedMotion;

  BatteryLiquidPainter({
    required this.progress,
    required this.waveValue,
    required this.color,
    required this.isCharging,
    this.lowPower = false,
    this.reducedMotion = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double shellWidth = size.width;
    final double shellHeight = size.height;
    final double tipHeight = shellHeight * 0.08;
    final double bodyHeight = shellHeight - tipHeight;

    // Battery Body RRect
    final RRect batteryBody = RRect.fromLTRBR(
      0,
      tipHeight,
      shellWidth,
      shellHeight,
      Radius.circular(shellWidth * 0.15),
    );

    // 1. Draw Glassy Background
    final backgroundPaint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(batteryBody, backgroundPaint);

    // 2. Low Battery Pulse
    if (progress <= 0.2 && !isCharging && !reducedMotion) {
      final double pulse = (math.sin(waveValue * 2 * math.pi) + 1) / 2;
      final pulsePaint = Paint()..color = Colors.red.withOpacity(0.2 * pulse);

      if (!lowPower) {
        pulsePaint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);
      }
      canvas.drawRRect(batteryBody, pulsePaint);
    }

    // 3. Draw Liquid with Waves
    canvas.save();
    canvas.clipRRect(batteryBody);

    final double fillLevel = shellHeight - (bodyHeight * progress);

    if (lowPower) {
      // Simple fill for low power
      _drawWave(canvas, size, fillLevel, 0.6, 0.6, math.pi, color);
    } else {
      // Draw three layers of waves for depth
      _drawWave(canvas, size, fillLevel, 1.0, 0.4, 0, color.withOpacity(0.3));
      _drawWave(
        canvas,
        size,
        fillLevel,
        0.8,
        0.5,
        math.pi / 2,
        color.withOpacity(0.5),
      );
      _drawWave(canvas, size, fillLevel, 0.6, 0.6, math.pi, color);
    }

    // 4. Bubbles
    if (!lowPower && !reducedMotion) {
      final bubblePaint = Paint()..color = Colors.white.withOpacity(0.4);
      final random = math.Random(42);
      for (int i = 0; i < 12; i++) {
        double bx = random.nextDouble() * size.width;
        // Bubbles rise
        double bubbleProgress = (waveValue + random.nextDouble()) % 1.0;
        double by =
            shellHeight - (bubbleProgress * (shellHeight - fillLevel + 20));

        // Only draw bubbles inside liquid
        if (by > fillLevel - 10) {
          double radius = 1 + random.nextDouble() * 3;
          // Side to side wobble
          bx += math.sin(waveValue * 2 * math.pi + random.nextDouble()) * 3;
          canvas.drawCircle(Offset(bx, by), radius, bubblePaint);
        }
      }
    }

    // 5. Charging Bolt with Glow
    if (isCharging) {
      final double boltScale = reducedMotion
          ? 1.0
          : 1.0 + (math.sin(waveValue * 2 * math.pi) * 0.1);
      final boltPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(size.width / 2, (shellHeight + fillLevel) / 2);
      canvas.scale(boltScale);
      canvas.translate(-size.width / 2, -(shellHeight + fillLevel) / 2);

      final boltPath = _getBoltPath(size, fillLevel);
      if (!lowPower) {
        final glowPaint = Paint()
          ..color = Colors.white.withOpacity(0.5)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
        canvas.drawPath(boltPath, glowPaint);
      }
      canvas.drawPath(boltPath, boltPaint);
      canvas.restore();
    }

    canvas.restore();

    // 6. Draw Shell Outline
    final shellPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    canvas.drawRRect(batteryBody, shellPaint);

    // Battery Tip
    final tipRRect = RRect.fromLTRBR(
      size.width * 0.35,
      0,
      size.width * 0.65,
      tipHeight,
      const Radius.circular(3),
    );
    canvas.drawRRect(tipRRect, shellPaint);
  }

  void _drawWave(
    Canvas canvas,
    Size size,
    double fillLevel,
    double frequency,
    double amplitudeMult,
    double phase,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = Path();
    final double waveHeight = reducedMotion ? 0.0 : 6.0 * amplitudeMult;

    path.moveTo(0, fillLevel);
    for (double x = 0; x <= size.width; x++) {
      final double y =
          fillLevel +
          math.sin(
                (waveValue * 2 * math.pi * frequency) +
                    (x / size.width * 2 * math.pi) +
                    phase,
              ) *
              waveHeight;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  Path _getBoltPath(Size size, double fillLevel) {
    final path = Path();
    final centerX = size.width * 0.5;
    final centerY = (size.height + fillLevel) * 0.5;
    final w = size.width * 0.3;
    final h = size.height * 0.25;

    path.moveTo(centerX + w * 0.1, centerY - h * 0.5);
    path.lineTo(centerX - w * 0.4, centerY + h * 0.1);
    path.lineTo(centerX + w * 0.1, centerY + h * 0.1);
    path.lineTo(centerX - w * 0.1, centerY + h * 0.5);
    path.lineTo(centerX + w * 0.4, centerY - h * 0.1);
    path.lineTo(centerX - w * 0.1, centerY - h * 0.1);
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(BatteryLiquidPainter oldDelegate) => true;
}
