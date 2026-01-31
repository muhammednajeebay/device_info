import 'dart:math' as math;
import 'package:flutter/material.dart';

class HolographicIcon extends StatefulWidget {
  final IconData icon;
  final Color color;

  const HolographicIcon({super.key, required this.icon, required this.color});

  @override
  State<HolographicIcon> createState() => _HolographicIconState();
}

class _HolographicIconState extends State<HolographicIcon>
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
        final hue = (_controller.value * 360).toDouble();
        return Stack(
          alignment: Alignment.center,
          children: [
            // Floating particles
            ...List.generate(5, (index) {
              final angle =
                  (_controller.value * 2 * math.pi) + (index * 2 * math.pi / 5);
              return Transform.translate(
                offset: Offset(math.cos(angle) * 30, math.sin(angle) * 10),
                child: Container(
                  width: 3,
                  height: 3,
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),

            // Holographic Shimmer layers
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_controller.value * 2 * math.pi),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Icon(
                    widget.icon,
                    size: 42,
                    color: HSVColor.fromAHSV(
                      0.3,
                      (hue + 180) % 360,
                      0.5,
                      1.0,
                    ).toColor(),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Icon(widget.icon, size: 40, color: widget.color),
                    ),
                  ),
                ],
              ),
            ),

            // Scanline effect
            Positioned.fill(
              child: ClipRect(
                child: Transform.translate(
                  offset: Offset(0, -40 + (_controller.value * 80)),
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          widget.color.withOpacity(0.4),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
