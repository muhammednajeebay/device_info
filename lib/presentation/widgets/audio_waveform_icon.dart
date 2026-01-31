import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/settings/settings_bloc.dart';
import '../../blocs/settings/settings_state.dart';

class AudioWaveformIcon extends StatefulWidget {
  final Color color;

  const AudioWaveformIcon({super.key, required this.color});

  @override
  State<AudioWaveformIcon> createState() => _AudioWaveformIconState();
}

class _AudioWaveformIconState extends State<AudioWaveformIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final math.Random _random = math.Random();
  late List<double> _heights;

  @override
  void initState() {
    super.initState();
    _heights = List.generate(8, (_) => 0.5);
    _controller =
        AnimationController(
            duration: const Duration(milliseconds: 1000),
            vsync: this,
          )
          ..addListener(() {
            setState(() {
              for (int i = 0; i < _heights.length; i++) {
                _heights[i] = 0.3 + _random.nextDouble() * 0.7;
              }
            });
          })
          ..repeat();
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
          setState(() {
            _heights = List.generate(8, (_) => 0.5);
          });
        } else if (!_controller.isAnimating) {
          _controller.repeat();
        }
      },
      builder: (context, state) {
        return Container(
          width: 60,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(8, (index) {
              return AnimatedContainer(
                duration: state.lowPowerMode
                    ? const Duration(milliseconds: 300)
                    : const Duration(milliseconds: 150),
                width: 3,
                height: 10 + (_heights[index] * 40),
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(
                    0.5 + (_heights[index] * 0.5),
                  ),
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: state.lowPowerMode
                      ? null
                      : [
                          BoxShadow(
                            color: widget.color.withOpacity(0.3),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
