import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/theme_constants.dart';
import '../../utils/text_styles.dart';
import '../../blocs/settings/settings_bloc.dart';
import '../../blocs/settings/settings_state.dart';

class SystemPulseFlow extends StatefulWidget {
  final double ramUsage; // 0.0 to 1.0
  final int cpuCores;

  const SystemPulseFlow({
    super.key,
    required this.ramUsage,
    required this.cpuCores,
  });

  @override
  State<SystemPulseFlow> createState() => _SystemPulseFlowState();
}

class _SystemPulseFlowState extends State<SystemPulseFlow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<double> _pulsePoints = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Initialize pulse points
    for (int i = 0; i < 50; i++) {
      _pulsePoints.add(0.5);
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
        return Column(
          children: [
            // RAM Pulse Line
            SizedBox(
              height: 100,
              width: double.infinity,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  if (!state.reducedMotion) {
                    // Update one point per frame-ish
                    _pulsePoints.removeAt(0);
                    double base = widget.ramUsage;
                    double variation = (_random.nextDouble() - 0.5) * 0.2;
                    _pulsePoints.add((base + variation).clamp(0.1, 0.9));
                  }

                  return CustomPaint(
                    painter: PulseLinePainter(
                      points: _pulsePoints,
                      color: CategoryColors.system,
                      progress: _controller.value,
                      lowPower: state.lowPowerMode,
                      reducedMotion: state.reducedMotion,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // CPU Flow Bars
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                state.lowPowerMode
                    ? widget.cpuCores.clamp(1, 4)
                    : widget.cpuCores.clamp(1, 8),
                (index) => _buildCpuCoreBar(
                  index,
                  state.lowPowerMode,
                  state.reducedMotion,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'CPU CORE ACTIVITY',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: 2,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCpuCoreBar(int index, bool lowPower, bool reducedMotion) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Individual core load variation
        double coreLoad = reducedMotion
            ? widget.ramUsage
            : widget.ramUsage +
                  math.sin(_controller.value * 2 * math.pi + index) * 0.2;
        coreLoad = coreLoad.clamp(0.1, 1.0);

        return Column(
          children: [
            Container(
              width: 12,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.glassSurface,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  color: AppColors.glassBorder.withOpacity(0.3),
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Flow fill
                  FractionallySizedBox(
                    heightFactor: coreLoad,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: lowPower
                            ? null
                            : LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  CategoryColors.system,
                                  CategoryColors.system.withOpacity(0.3),
                                ],
                              ),
                        color: lowPower ? CategoryColors.system : null,
                        borderRadius: BorderRadius.circular(1),
                        boxShadow: lowPower
                            ? null
                            : [
                                BoxShadow(
                                  color: CategoryColors.system.withOpacity(0.5),
                                  blurRadius: 4,
                                ),
                              ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'C$index',
              style: AppTextStyles.labelSmall.copyWith(fontSize: 8),
            ),
          ],
        );
      },
    );
  }
}

class PulseLinePainter extends CustomPainter {
  final List<double> points;
  final Color color;
  final double progress;
  final bool lowPower;
  final bool reducedMotion;

  PulseLinePainter({
    required this.points,
    required this.color,
    required this.progress,
    this.lowPower = false,
    this.reducedMotion = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final dx = size.width / (points.length - 1);

    for (int i = 0; i < points.length; i++) {
      double x = i * dx;
      double y = size.height * (1.0 - points[i]);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    if (!lowPower) {
      // Gradient shadow under the line
      final shadowPath = Path.from(path)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();

      final gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withOpacity(0.3), color.withOpacity(0)],
      );

      canvas.drawPath(
        shadowPath,
        Paint()
          ..shader = gradient.createShader(
            Rect.fromLTWH(0, 0, size.width, size.height),
          ),
      );
    }

    canvas.drawPath(path, paint);

    // Draw leading point glow
    if (points.isNotEmpty && !reducedMotion) {
      final lastPoint = Offset(size.width, size.height * (1.0 - points.last));
      if (!lowPower) {
        canvas.drawCircle(
          lastPoint,
          4,
          Paint()
            ..color = Colors.white
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
        );
      }
      canvas.drawCircle(lastPoint, 2, Paint()..color = Colors.white);
    }
  }

  @override
  bool shouldRepaint(PulseLinePainter oldDelegate) => true;
}
