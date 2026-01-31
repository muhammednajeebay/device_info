import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/settings/settings_bloc.dart';
import '../../blocs/settings/settings_state.dart';

class LocationPulseIcon extends StatefulWidget {
  final Color color;

  const LocationPulseIcon({super.key, required this.color});

  @override
  State<LocationPulseIcon> createState() => _LocationPulseIconState();
}

class _LocationPulseIconState extends State<LocationPulseIcon>
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
        return SizedBox(
          width: 120,
          height: 120,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: const Size(120, 120),
                painter: LocationPainter(
                  progress: state.reducedMotion ? 0.0 : _controller.value,
                  color: widget.color,
                  lowPower: state.lowPowerMode,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class LocationPainter extends CustomPainter {
  final double progress;
  final Color color;
  final bool lowPower;

  LocationPainter({
    required this.progress,
    required this.color,
    this.lowPower = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.7);
    final pinHeadCenter = Offset(size.width / 2, size.height * 0.4);
    final maxRadius = size.width / 2;

    // 1. Draw Ground Pulse Rings
    int ringCount = lowPower ? 2 : 4;
    for (int i = 0; i < ringCount; i++) {
      final ringProgress = (progress + (i / ringCount.toDouble())) % 1.0;
      final opacity = 1.0 - ringProgress;
      final radius = ringProgress * maxRadius;

      final ringPaint = Paint()
        ..color = color.withOpacity(opacity * 0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      // Draw elliptical rings for perspective
      canvas.drawOval(
        Rect.fromCenter(
          center: center,
          width: radius * 2,
          height: radius * 0.6,
        ),
        ringPaint,
      );

      if (!lowPower && opacity > 0.5) {
        canvas.drawOval(
          Rect.fromCenter(
            center: center,
            width: radius * 2,
            height: radius * 0.6,
          ),
          Paint()
            ..color = color.withOpacity(opacity * 0.1)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 4.0
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
        );
      }
    }

    // 2. Draw the Pin Path (Glassy look)
    final pinPath = Path();
    pinPath.moveTo(size.width * 0.5, size.height * 0.7); // Bottom tip

    // Left side curve to head
    pinPath.cubicTo(
      size.width * 0.45,
      size.height * 0.6,
      size.width * 0.3,
      size.height * 0.5,
      size.width * 0.3,
      pinHeadCenter.dy,
    );

    // Top circle arc
    pinPath.arcTo(
      Rect.fromCircle(center: pinHeadCenter, radius: size.width * 0.2),
      3.14,
      3.14,
      false,
    );

    // Right side curve back to tip
    pinPath.cubicTo(
      size.width * 0.7,
      size.height * 0.5,
      size.width * 0.55,
      size.height * 0.6,
      size.width * 0.5,
      size.height * 0.7,
    );
    pinPath.close();

    // Shadow
    if (!lowPower) {
      canvas.drawPath(
        pinPath.shift(const Offset(0, 4)),
        Paint()
          ..color = Colors.black.withOpacity(0.2)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
      );
    }

    // Pin Body Gradient
    final pinPaint = Paint();
    if (lowPower) {
      pinPaint.color = color;
    } else {
      pinPaint.shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color, color.withOpacity(0.7)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    }

    canvas.drawPath(pinPath, pinPaint);

    // Inner White Dot (Glow)
    if (!lowPower) {
      canvas.drawCircle(
        pinHeadCenter,
        size.width * 0.08,
        Paint()
          ..color = Colors.white
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
      );
    }

    canvas.drawCircle(
      pinHeadCenter,
      size.width * 0.05,
      Paint()..color = Colors.white,
    );

    // Leading edge shine
    if (!lowPower) {
      final shinePath = Path();
      shinePath.addArc(
        Rect.fromCircle(center: pinHeadCenter, radius: size.width * 0.15),
        -1.5,
        1.0,
      );
      canvas.drawPath(
        shinePath,
        Paint()
          ..color = Colors.white.withOpacity(0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(LocationPainter oldDelegate) => true;
}
