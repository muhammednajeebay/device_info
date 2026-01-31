import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/theme_constants.dart';
import '../../utils/text_styles.dart';
import '../../blocs/settings/settings_bloc.dart';
import '../../blocs/settings/settings_state.dart';

class DataMassVisualization extends StatefulWidget {
  final double usedPercentage;
  final String totalUsed;

  const DataMassVisualization({
    super.key,
    required this.usedPercentage,
    required this.totalUsed,
  });

  @override
  State<DataMassVisualization> createState() => _DataMassVisualizationState();
}

class _DataMassVisualizationState extends State<DataMassVisualization>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int? touchedIndex;

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
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state.reducedMotion) {
          _controller.stop();
        } else if (!_controller.isAnimating) {
          _controller.repeat();
        }
      },
      builder: (context, state) {
        final reducedMotion = state.reducedMotion;
        final lowPower = state.lowPowerMode;

        return SizedBox(
          height: 280,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Drifting background icons
              if (!lowPower)
                ...List.generate(12, (index) {
                  final double progress = reducedMotion
                      ? 0.0
                      : (_controller.value + index / 12) % 1.0;
                  final double angle = index * 2 * math.pi / 12;
                  final double dist =
                      110 + math.sin(progress * 2 * math.pi) * 15;

                  return Positioned(
                    left: 140 + math.cos(angle) * dist - 10,
                    top: 140 + math.sin(angle) * dist - 10,
                    child: Opacity(
                      opacity: (1.0 - progress) * 0.3,
                      child: Icon(
                        _getCategoryIcon(index % 4),
                        size: 16,
                        color: CategoryColors.storage.withOpacity(0.5),
                      ),
                    ),
                  );
                }),

              // The Donut Chart
              PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!
                            .touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 4,
                  centerSpaceRadius: 80,
                  sections: _buildSections(),
                ),
              ),

              // Central Info
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Used',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    widget.totalUsed,
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  List<PieChartSectionData> _buildSections() {
    // Mocking category breakdown for visual identity
    final double system = widget.usedPercentage * 0.25;
    final double apps = widget.usedPercentage * 0.45;
    final double media = widget.usedPercentage * 0.20;
    final double other = widget.usedPercentage * 0.10;
    final double free = 1.0 - widget.usedPercentage;

    return [
      _createSection(0, apps, 'Apps', Colors.orange, Icons.apps),
      _createSection(1, media, 'Media', Colors.blue, Icons.movie),
      _createSection(2, system, 'System', Colors.purple, Icons.settings),
      _createSection(3, other, 'Other', Colors.green, Icons.folder),
      PieChartSectionData(
        color: AppColors.glassSurface.withOpacity(0.1),
        value: free * 100,
        title: '',
        radius: touchedIndex == 4 ? 45 : 40,
        showTitle: false,
      ),
    ];
  }

  PieChartSectionData _createSection(
    int index,
    double value,
    String title,
    Color color,
    IconData icon,
  ) {
    final isTouched = touchedIndex == index;
    final double radius = isTouched ? 60.0 : 50.0;
    final double opacity = isTouched ? 1.0 : 0.8;

    return PieChartSectionData(
      color: color.withOpacity(opacity),
      value: value * 100,
      radius: radius,
      showTitle: isTouched,
      title: title,
      titleStyle: AppTextStyles.labelSmall.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      badgeWidget: isTouched
          ? null
          : Icon(icon, size: 16, color: Colors.white70),
      badgePositionPercentageOffset: .98,
    );
  }

  IconData _getCategoryIcon(int index) {
    switch (index) {
      case 0:
        return Icons.apps;
      case 1:
        return Icons.movie;
      case 2:
        return Icons.settings;
      default:
        return Icons.folder;
    }
  }
}
