import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info/blocs/battery/battery_bloc.dart';
import '../../utils/theme_constants.dart';
import '../../utils/text_styles.dart';
import '../widgets/info_tile.dart';
import '../widgets/app_card.dart';
import '../widgets/liquid_wave_icon.dart';

class BatteryDetailScreen extends StatelessWidget {
  const BatteryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Battery Information')),
      body: BlocBuilder<BatteryBloc, BatteryState>(
        builder: (context, state) {
          if (state is BatteryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BatteryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Failed to load battery info',
                    style: AppTextStyles.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    state.message,
                    style: AppTextStyles.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          if (state is BatteryLoaded) {
            final battery = state.batteryInfo;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Card: Liquid Energy System
                  AppCard(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Row(
                      children: [
                        // Left: Battery Container
                        Hero(
                          tag: 'battery_icon',
                          child: LiquidWaveIcon(
                            progress: battery.level / 100,
                            isCharging: battery.status.toLowerCase().contains(
                              'charging',
                            ),
                            color: CategoryColors.battery,
                            width: 100,
                            height: 180,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xxl),
                        // Right: Primary Stats
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Battery Level',
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                '${battery.level}%',
                                style: AppTextStyles.displayLarge.copyWith(
                                  fontSize: 48,
                                  color: CategoryColors.battery,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.md),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.md,
                                  vertical: AppSpacing.sm,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      (battery.status.toLowerCase().contains(
                                                'charging',
                                              )
                                              ? CategoryColors.battery
                                              : AppColors.glassSurface)
                                          .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(
                                    AppRadius.chip,
                                  ),
                                  border: Border.all(
                                    color:
                                        (battery.status.toLowerCase().contains(
                                                  'charging',
                                                )
                                                ? CategoryColors.battery
                                                : AppColors.glassBorder)
                                            .withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      battery.status.toLowerCase().contains(
                                            'charging',
                                          )
                                          ? Icons.bolt
                                          : Icons.battery_std,
                                      size: 16,
                                      color:
                                          battery.status.toLowerCase().contains(
                                            'charging',
                                          )
                                          ? CategoryColors.battery
                                          : AppColors.textSecondary,
                                    ),
                                    const SizedBox(width: AppSpacing.xs),
                                    Text(
                                      battery.status,
                                      style: AppTextStyles.labelLarge.copyWith(
                                        color:
                                            battery.status
                                                .toLowerCase()
                                                .contains('charging')
                                            ? CategoryColors.battery
                                            : AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sectionSpacing),

                  // Secondary Metrics Grid
                  Text(
                    'Technical Specs',
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSpacing.md,
                    crossAxisSpacing: AppSpacing.md,
                    childAspectRatio: 1.5,
                    children: [
                      _buildMetricCard(
                        'Voltage',
                        '${battery.voltage} mV',
                        Icons.bolt,
                        Colors.blue,
                      ),
                      _buildMetricCard(
                        'Temperature',
                        '${(battery.temperature! / 10).toStringAsFixed(1)}°C',
                        Icons.thermostat,
                        Colors.orange,
                      ),
                      _buildMetricCard(
                        'Health',
                        battery.health ?? 'Unknown',
                        Icons.favorite,
                        Colors.red,
                      ),
                      _buildMetricCard(
                        'Technology',
                        battery.technology ?? 'N/A',
                        Icons.science,
                        Colors.purple,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Additional Info in Glass Tiles
                  if (battery.capacity != null || battery.pluggedStatus != null)
                    Column(
                      children: [
                        if (battery.capacity != null)
                          InfoTile(
                            label: 'Capacity',
                            value: '${battery.capacity} mAh',
                            icon: Icons.battery_saver,
                            iconColor: CategoryColors.battery,
                          ),
                        if (battery.pluggedStatus != null)
                          InfoTile(
                            label: 'Power Source',
                            value: battery.pluggedStatus!,
                            icon: Icons.power,
                            iconColor: CategoryColors.battery,
                          ),
                      ],
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

  Widget _buildMetricCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.textPrimary,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
