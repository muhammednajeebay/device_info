import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/settings/settings_bloc.dart';
import '../../blocs/settings/settings_state.dart';

class StorageBarChartIcon extends StatefulWidget {
  final Color color;

  const StorageBarChartIcon({super.key, required this.color});

  @override
  State<StorageBarChartIcon> createState() => _StorageBarChartIconState();
}

class _StorageBarChartIconState extends State<StorageBarChartIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<double> _targetHeights;

  @override
  void initState() {
    super.initState();
    _targetHeights = [0.4, 0.7, 0.5, 0.9, 0.3];
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
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
          _controller.repeat(reverse: true);
        }
      },
      builder: (context, state) {
        return Container(
          width: 60,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(5, (index) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final progress = state.reducedMotion
                      ? 1.0
                      : _controller.value;
                  final height = 10.0 + (_targetHeights[index] * 40 * progress);
                  return Container(
                    width: 6,
                    height: height,
                    decoration: BoxDecoration(
                      gradient: state.lowPowerMode
                          ? null
                          : LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                widget.color,
                                widget.color.withOpacity(0.3),
                              ],
                            ),
                      color: state.lowPowerMode ? widget.color : null,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: state.lowPowerMode
                          ? null
                          : [
                              BoxShadow(
                                color: widget.color.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                    ),
                  );
                },
              );
            }),
          ),
        );
      },
    );
  }
}
