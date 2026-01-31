import 'package:flutter/material.dart';

class SignalPropagationIcon extends StatefulWidget {
  final Color color;

  const SignalPropagationIcon({super.key, required this.color});

  @override
  State<SignalPropagationIcon> createState() => _SignalPropagationIconState();
}

class _SignalPropagationIconState extends State<SignalPropagationIcon>
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
          size: const Size(60, 60),
          painter: SignalPainter(
            progress: _controller.value,
            color: widget.color,
          ),
        );
      },
    );
  }
}

class SignalPainter extends CustomPainter {
  final double progress;
  final Color color;

  SignalPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Center icon placeholder
    canvas.drawCircle(center, 4, Paint()..color = color);

    for (int i = 0; i < 3; i++) {
      final p = (progress + i / 3.0) % 1.0;
      paint.color = color.withOpacity(1.0 - p);
      canvas.drawCircle(center, p * 30, paint);
    }
  }

  @override
  bool shouldRepaint(SignalPainter oldDelegate) => true;
}
