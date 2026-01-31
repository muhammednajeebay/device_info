import 'package:flutter/material.dart';

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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(60, 60),
          painter: LocationPainter(
            progress: _controller.value,
            color: widget.color,
          ),
        );
      },
    );
  }
}

class LocationPainter extends CustomPainter {
  final double progress;
  final Color color;

  LocationPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.7);
    final paint = Paint()..style = PaintingStyle.fill;

    // Pulse rings
    for (int i = 0; i < 3; i++) {
      final p = (progress + i / 3.0) % 1.0;
      final ringPaint = Paint()
        ..color = color.withOpacity(0.5 * (1 - p))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawCircle(center, p * 25, ringPaint);
    }

    // Pin shape
    final pinPath = Path();
    final pinCenter = Offset(size.width / 2, size.height * 0.4);

    pinPath.moveTo(size.width * 0.5, size.height * 0.7); // Bottom tip
    pinPath.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.5,
      size.width * 0.3,
      size.height * 0.4,
    );
    pinPath.arcToPoint(
      Offset(size.width * 0.7, size.height * 0.4),
      radius: const Radius.circular(12),
      clockwise: true,
    );
    pinPath.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.5,
      size.width * 0.5,
      size.height * 0.7,
    );
    pinPath.close();

    canvas.drawPath(pinPath, paint..color = color);
    canvas.drawCircle(pinCenter, 4, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(LocationPainter oldDelegate) => true;
}
