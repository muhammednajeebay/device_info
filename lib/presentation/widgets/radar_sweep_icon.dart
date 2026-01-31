import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/settings/settings_bloc.dart';
import '../../blocs/settings/settings_state.dart';

class RadarSweepIcon extends StatefulWidget {
  final Color color;
  final int sensorCount;

  const RadarSweepIcon({super.key, required this.color, this.sensorCount = 5});

  @override
  State<RadarSweepIcon> createState() => _RadarSweepIconState();
}

class _RadarSweepIconState extends State<RadarSweepIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final math.Random _random = math.Random(42);
  late List<Map<String, double>> _blips;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _generateBlips();
  }

  void _generateBlips() {
    _blips = List.generate(widget.sensorCount.clamp(3, 15), (index) {
      return {
        'angle': _random.nextDouble() * 2 * math.pi,
        'dist': 0.3 + _random.nextDouble() * 0.6,
        'size': 2.0 + _random.nextDouble() * 2.0,
      };
    });
  }

  @override
  void didUpdateWidget(RadarSweepIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sensorCount != widget.sensorCount) {
      _generateBlips();
    }
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
        return SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return CustomPaint(
                    size: const Size(120, 120),
                    painter: RadarPainter(
                      rotation: state.reducedMotion
                          ? 0.0
                          : _controller.value * 2 * math.pi,
                      color: widget.color,
                      blips: _blips,
                      lowPower: state.lowPowerMode,
                    ),
                  );
                },
              ),
              // Central Pulse
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: widget.color.withOpacity(0.2)),
                ),
                child: Icon(Icons.sensors, color: widget.color, size: 24),
              ),
            ],
          ),
        );
      },
    );
  }
}

class RadarPainter extends CustomPainter {
  final double rotation;
  final Color color;
  final List<Map<String, double>> blips;
  final bool lowPower;

  RadarPainter({
    required this.rotation,
    required this.color,
    required this.blips,
    this.lowPower = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background scanline/grid
    final gridPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawCircle(center, radius * 0.3, gridPaint);
    if (!lowPower) {
      canvas.drawCircle(center, radius * 0.6, gridPaint);
      canvas.drawCircle(center, radius * 0.9, gridPaint);
    }

    // Crosshairs
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

    // Sweep Gradient
    final sweepPaint = Paint()
      ..shader = SweepGradient(
        center: Alignment.center,
        startAngle: 0.0,
        endAngle: math.pi * 2,
        colors: [color.withOpacity(0.0), color.withOpacity(0.5)],
        stops: const [0.75, 1.0],
        transform: GradientRotation(rotation - math.pi / 2),
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, sweepPaint);

    // Sweep Line (Bright leading edge)
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final sweepX = center.dx + math.cos(rotation - math.pi / 2) * radius;
    final sweepY = center.dy + math.sin(rotation - math.pi / 2) * radius;
    canvas.drawLine(center, Offset(sweepX, sweepY), linePaint);

    // Blips (Echoes)
    int count = 0;
    for (var blip in blips) {
      if (lowPower && count++ > 3) break; // Optimization

      final blipAngle = blip['angle']!;
      final blipDist = blip['dist']! * radius;

      // Calculate angular distance from sweep line
      double diff = (rotation - math.pi / 2 - blipAngle) % (2 * math.pi);
      if (diff < 0) diff += 2 * math.pi;

      // Fade blip based on how long ago sweep passed it
      // Since sweep moves clockwise, we want small diff to be bright
      double intensity = 0.0;
      if (diff < math.pi / 2) {
        intensity = 1.0 - (diff / (math.pi / 2));
      }

      if (intensity > 0) {
        final bX = center.dx + math.cos(blipAngle) * blipDist;
        final bY = center.dy + math.sin(blipAngle) * blipDist;

        final blipPaint = Paint()..color = color.withOpacity(intensity);

        if (!lowPower) {
          blipPaint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
        }

        canvas.drawCircle(Offset(bX, bY), blip['size']!, blipPaint);

        canvas.drawCircle(
          Offset(bX, bY),
          blip['size']! * 0.5,
          Paint()..color = Colors.white.withOpacity(intensity),
        );
      }
    }
  }

  @override
  bool shouldRepaint(RadarPainter oldDelegate) => true;
}
