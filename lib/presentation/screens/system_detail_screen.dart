import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info/blocs/system/system_bloc.dart';
import 'package:device_info/utils/theme_constants.dart';
import 'package:device_info/utils/text_styles.dart';
import 'package:device_info/presentation/widgets/app_card.dart';
import 'package:device_info/presentation/widgets/info_tile.dart';
import 'package:fl_chart/fl_chart.dart';

class SystemDetailScreen extends StatelessWidget {
  const SystemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('System'), elevation: 0),
      body: BlocBuilder<SystemBloc, SystemState>(
        builder: (context, state) {
          if (state is SystemLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SystemError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: AppColors.error),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Error: ${state.message}',
                    style: AppTextStyles.bodyLarge,
                  ),
                ],
              ),
            );
          }

          if (state is SystemLoaded) {
            final system = state.systemInfo;
            final totalRam = system.totalRam ?? 0;
            final availableRam = system.availableRam ?? 0;
            final usedRam = totalRam - availableRam;
            final ramUsagePercent = totalRam > 0
                ? (usedRam / totalRam * 100)
                : 0.0;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // RAM Usage Chart
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.memory,
                              color: CategoryColors.system,
                              size: AppIconSize.lg,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Text(
                              'Memory Usage',
                              style: AppTextStyles.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        SizedBox(
                          height: 200,
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              maxY: totalRam.toDouble(),
                              barTouchData: BarTouchData(enabled: false),
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      switch (value.toInt()) {
                                        case 0:
                                          return Text(
                                            'Used',
                                            style: AppTextStyles.labelSmall,
                                          );
                                        case 1:
                                          return Text(
                                            'Available',
                                            style: AppTextStyles.labelSmall,
                                          );
                                        default:
                                          return const SizedBox();
                                      }
                                    },
                                  ),
                                ),
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 50,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        _formatBytes(value.toInt()),
                                        style: AppTextStyles.labelSmall,
                                      );
                                    },
                                  ),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                horizontalInterval: totalRam > 0
                                    ? totalRam / 4
                                    : 1.0,
                              ),
                              borderData: FlBorderData(show: false),
                              barGroups: [
                                BarChartGroupData(
                                  x: 0,
                                  barRods: [
                                    BarChartRodData(
                                      toY: usedRam.toDouble(),
                                      color: CategoryColors.system,
                                      width: 40,
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(4),
                                      ),
                                    ),
                                  ],
                                ),
                                BarChartGroupData(
                                  x: 1,
                                  barRods: [
                                    BarChartRodData(
                                      toY: availableRam.toDouble(),
                                      color: AppColors.success,
                                      width: 40,
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(4),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Center(
                          child: Text(
                            '${ramUsagePercent.toStringAsFixed(1)}% Used',
                            style: AppTextStyles.titleMedium.copyWith(
                              color: CategoryColors.system,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Memory Details
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Memory Details',
                          style: AppTextStyles.titleMedium,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        InfoTile(
                          label: 'Total RAM',
                          value: _formatBytes(totalRam),
                          icon: Icons.memory,
                        ),
                        InfoTile(
                          label: 'Available RAM',
                          value: _formatBytes(availableRam),
                          icon: Icons.check_circle,
                        ),
                        InfoTile(
                          label: 'Used RAM',
                          value: _formatBytes(usedRam),
                          icon: Icons.pie_chart,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // CPU Details
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CPU Details', style: AppTextStyles.titleMedium),
                        const SizedBox(height: AppSpacing.md),
                        InfoTile(
                          label: 'CPU Cores',
                          value: (system.cpuCores ?? 0).toString(),
                          icon: Icons.developer_board,
                        ),
                        InfoTile(
                          label: 'Architecture',
                          value: system.cpuArchitecture ?? 'Unknown',
                          icon: Icons.architecture,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Display Details
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Display Details',
                          style: AppTextStyles.titleMedium,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        InfoTile(
                          label: 'Screen Resolution',
                          value: system.screenResolution ?? 'Unknown',
                          icon: Icons.screenshot,
                        ),
                        InfoTile(
                          label: 'Screen Density',
                          value:
                              '${(system.screenDensity ?? 1.0).toStringAsFixed(2)}x',
                          icon: Icons.grid_on,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }
}
