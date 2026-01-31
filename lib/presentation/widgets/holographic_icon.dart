import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/settings/settings_bloc.dart';
import '../../blocs/settings/settings_state.dart';

class HolographicIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final double size;

  const HolographicIcon({
    super.key,
    required this.icon,
    required this.color,
    this.size = 80,
  });

  @override
  State<HolographicIcon> createState() => _HolographicIconState();
}

class _HolographicIconState extends State<HolographicIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
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
            final double rotation = state.reducedMotion
                ? 0.0
                : _controller.value * 2 * math.pi;
            final double scanProgress = (_controller.value * 2) % 1.0;

            // Random glitch logic
            bool isGlitching =
                !state.reducedMotion && _random.nextDouble() > 0.95;
            double glitchOffset = isGlitching
                ? (_random.nextDouble() - 0.5) * 4
                : 0;
            double glitchOpacity = isGlitching
                ? _random.nextDouble() * 0.5 + 0.5
                : 1.0;

            return Stack(
              alignment: Alignment.center,
              children: [
                // Floating particles / Dust
                if (!state.lowPowerMode)
                  ...List.generate(8, (index) {
                    final double particleAngle =
                        (_controller.value * 4 * math.pi) +
                        (index * math.pi / 4);
                    final double dist =
                        40.0 +
                        math.sin(_controller.value * 2 * math.pi + index) * 10;
                    return Transform.translate(
                      offset: Offset(
                        math.cos(particleAngle) * dist,
                        math.sin(particleAngle * 0.5) * dist * 0.3,
                      ),
                      child: Container(
                        width: 2,
                        height: 2,
                        decoration: BoxDecoration(
                          color: widget.color.withOpacity(0.3),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: widget.color.withOpacity(0.5),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                // 3D Rotating Projection
                Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.002)
                    ..rotateY(rotation)
                    ..translate(glitchOffset, 0, 0),
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: glitchOpacity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Back glow / Bloom
                        if (!state.lowPowerMode)
                          Icon(
                            widget.icon,
                            size: widget.size * 1.1,
                            color: widget.color.withOpacity(0.2),
                          ),
                        // Iridescent layers
                        _buildIridescentLayer(rotation, 0),
                        if (!state.lowPowerMode) ...[
                          _buildIridescentLayer(rotation + math.pi / 4, 120),
                          _buildIridescentLayer(rotation + math.pi / 2, 240),
                        ],

                        // Core Icon
                        Icon(
                          widget.icon,
                          size: widget.size,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ],
                    ),
                  ),
                ),

                // Vertical Scanline
                if (!state.reducedMotion)
                  Positioned.fill(
                    child: ClipRect(
                      child: Transform.translate(
                        offset: Offset(
                          0,
                          -widget.size + (scanProgress * widget.size * 2),
                        ),
                        child: Container(
                          height: 1.5,
                          decoration: BoxDecoration(
                            boxShadow: state.lowPowerMode
                                ? null
                                : [
                                    BoxShadow(
                                      color: widget.color.withOpacity(0.6),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                  ],
                            gradient: LinearGradient(
                              colors: [
                                widget.color.withOpacity(0),
                                widget.color.withOpacity(0.8),
                                widget.color.withOpacity(0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                // Base Shadow / Glow
                Transform.translate(
                  offset: Offset(0, widget.size * 0.6),
                  child: Container(
                    width: widget.size * 1.2,
                    height: 10,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: widget.color.withOpacity(0.2),
                          blurRadius: state.lowPowerMode ? 10 : 20,
                          spreadRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.elliptical(widget.size, 10),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildIridescentLayer(double rotation, double hueShift) {
    return Icon(
      widget.icon,
      size: widget.size,
      color: HSVColor.fromAHSV(
        0.4,
        (widget.color.computeLuminance() * 360 + hueShift) % 360,
        0.5,
        1.0,
      ).toColor(),
    );
  }
}
