import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info/blocs/battery/battery_bloc.dart';
import '../../utils/theme_constants.dart';
import '../../utils/text_styles.dart';
import '../widgets/info_tile.dart';
import '../widgets/app_card.dart';

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
                  // Battery Level Card
                  AppCard(
                    child: Column(
                      children: [
                        Icon(
                          Icons.battery_charging_full,
                          size: 64,
                          color: CategoryColors.battery,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          '${battery.level}%',
                          style: AppTextStyles.displayLarge.copyWith(
                            color: CategoryColors.battery,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          battery.status,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sectionSpacing),

                  // Battery Details
                  Text('Details', style: AppTextStyles.headlineSmall),
                  const SizedBox(height: AppSpacing.md),

                  AppCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        InfoTile(
                          label: 'Status',
                          value: battery.status,
                          icon: Icons.info_outline,
                          iconColor: CategoryColors.battery,
                        ),
                        if (battery.pluggedStatus != null)
                          InfoTile(
                            label: 'Plugged',
                            value: battery.pluggedStatus!,
                            icon: Icons.power,
                            iconColor: CategoryColors.battery,
                          ),
                        if (battery.health != null)
                          InfoTile(
                            label: 'Health',
                            value: battery.health!,
                            icon: Icons.favorite,
                            iconColor: CategoryColors.battery,
                          ),
                        if (battery.technology != null)
                          InfoTile(
                            label: 'Technology',
                            value: battery.technology!,
                            icon: Icons.science,
                            iconColor: CategoryColors.battery,
                          ),
                        if (battery.voltage != null)
                          InfoTile(
                            label: 'Voltage',
                            value: '${battery.voltage} mV',
                            icon: Icons.bolt,
                            iconColor: CategoryColors.battery,
                          ),
                        if (battery.temperature != null)
                          InfoTile(
                            label: 'Temperature',
                            value:
                                '${(battery.temperature! / 10).toStringAsFixed(1)}°C',
                            icon: Icons.thermostat,
                            iconColor: CategoryColors.battery,
                          ),
                        if (battery.capacity != null)
                          InfoTile(
                            label: 'Capacity',
                            value: '${battery.capacity} mAh',
                            icon: Icons.battery_std,
                            iconColor: CategoryColors.battery,
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
}
