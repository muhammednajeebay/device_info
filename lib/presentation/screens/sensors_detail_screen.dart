import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info/blocs/sensors/sensors_bloc.dart';
import 'package:device_info/utils/theme_constants.dart';
import 'package:device_info/utils/text_styles.dart';
import 'package:device_info/presentation/widgets/app_card.dart';
import 'package:device_info/presentation/widgets/info_tile.dart';
import 'package:device_info/presentation/widgets/radar_sweep_icon.dart';

class SensorsDetailScreen extends StatelessWidget {
  const SensorsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sensors')),
      body: BlocBuilder<SensorsBloc, SensorsState>(
        builder: (context, state) {
          if (state is SensorsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SensorsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sensors_off,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('Detection Failed', style: AppTextStyles.titleLarge),
                  const SizedBox(height: AppSpacing.sm),
                  Text(state.message, style: AppTextStyles.bodySmall),
                ],
              ),
            );
          }

          if (state is SensorsLoaded) {
            final sensors = state.sensorsData.availableSensors;

            return RefreshIndicator(
              onRefresh: () async {
                context.read<SensorsBloc>().add(LoadSensorsInfo());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(AppSpacing.screenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Section: Radar Sweep
                    AppCard(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.xl,
                      ),
                      child: Center(
                        child: RadarSweepIcon(
                          color: CategoryColors.sensors,
                          sensorCount: sensors.length,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sectionSpacing),

                    // Sensor Analytics
                    Text(
                      'Atmospheric Scanners',
                      style: AppTextStyles.headlineSmall.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: sensors.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: AppSpacing.md),
                      itemBuilder: (context, index) {
                        final sensor = sensors[index];
                        return AppCard(
                          padding: EdgeInsets.zero,
                          child: ExpansionTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: CategoryColors.sensors.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _getSensorIcon(sensor.type),
                                color: CategoryColors.sensors,
                              ),
                            ),
                            title: Text(
                              sensor.name,
                              style: AppTextStyles.labelMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            subtitle: Text(
                              sensor.type,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            childrenPadding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.sm,
                            ),
                            children: [
                              InfoTile(
                                label: 'Manufacturer',
                                value: sensor.vendor,
                                icon: Icons.business,
                                iconColor: Colors.blue,
                              ),
                              InfoTile(
                                label: 'Power Consumption',
                                value: '${sensor.power.toStringAsFixed(3)} mA',
                                icon: Icons.electric_bolt,
                                iconColor: Colors.yellow,
                              ),
                              InfoTile(
                                label: 'Precision Matrix',
                                value: sensor.resolution.toString(),
                                icon: Icons.calculate,
                                iconColor: Colors.orange,
                              ),
                              InfoTile(
                                label: 'Field Magnitude',
                                value: sensor.maximumRange.toString(),
                                icon: Icons.straighten,
                                iconColor: Colors.purple,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  IconData _getSensorIcon(String type) {
    if (type.contains('Accelerometer')) return Icons.directions_run;
    if (type.contains('Gyroscope')) return Icons.screen_rotation;
    if (type.contains('Light')) return Icons.lightbulb_outline;
    if (type.contains('Proximity')) return Icons.settings_input_antenna;
    if (type.contains('Magnetic')) return Icons.explore;
    if (type.contains('Pressure')) return Icons.compress;
    if (type.contains('Temperature')) return Icons.thermostat;
    if (type.contains('Humidity')) return Icons.water_drop;
    if (type.contains('Heart')) return Icons.favorite;
    if (type.contains('Step')) return Icons.directions_walk;
    return Icons.sensors;
  }
}
