import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/settings/settings_bloc.dart';
import '../../blocs/settings/settings_state.dart';

class SignalPropagationIcon extends StatefulWidget {
  final Color color;
  final double signalStrength; // 0.0 to 1.0
  final IconData icon;

  const SignalPropagationIcon({
    super.key,
    required this.color,
    this.signalStrength = 0.8,
    required this.icon,
  });

  @override
  State<SignalPropagationIcon> createState() => _SignalPropagationIconState();
}

class _SignalPropagationIconState extends State<SignalPropagationIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Speed depends on signal strength (stronger signal = faster propagation)
    final duration = Duration(
      milliseconds: (2000 - (widget.signalStrength * 1000)).toInt(),
    );
    _controller = AnimationController(duration: duration, vsync: this)
      ..repeat();
  }

  @override
  void didUpdateWidget(SignalPropagationIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.signalStrength != widget.signalStrength) {
      final duration = Duration(
        milliseconds: (2000 - (widget.signalStrength * 1000)).toInt(),
      );
      _controller.duration = duration;
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
                    painter: SignalPainter(
                      progress: state.reducedMotion ? 0.0 : _controller.value,
                      color: widget.color,
                      ringCount: state.lowPowerMode
                          ? 2
                          : (widget.signalStrength * 5).clamp(2, 5).toInt(),
                      lowPower: state.lowPowerMode,
                    ),
                  );
                },
              ),
              // Central Transmitter Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: widget.color.withOpacity(0.3)),
                  boxShadow: state.lowPowerMode
                      ? null
                      : [
                          BoxShadow(
                            color: widget.color.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                ),
                child: Icon(widget.icon, color: widget.color, size: 32),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SignalPainter extends CustomPainter {
  final double progress;
  final Color color;
  final int ringCount;
  final bool lowPower;

  SignalPainter({
    required this.progress,
    required this.color,
    required this.ringCount,
    this.lowPower = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    for (int i = 0; i < ringCount; i++) {
      final ringProgress = (progress + i / ringCount) % 1.0;
      final opacity = 1.0 - ringProgress;
      final radius = ringProgress * maxRadius;

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..color = color.withOpacity(opacity * 0.5);

      canvas.drawCircle(center, radius, paint);

      // Secondary glow ring
      if (!lowPower && opacity > 0.1) {
        canvas.drawCircle(
          center,
          radius,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.0
            ..color = color.withOpacity(opacity * 0.2)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
        );
      }
    }
  }

  @override
  bool shouldRepaint(SignalPainter oldDelegate) => true;
}
