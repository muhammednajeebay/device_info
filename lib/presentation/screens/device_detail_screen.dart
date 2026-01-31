import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info/blocs/device/device_bloc.dart';
import '../../utils/theme_constants.dart';
import '../../utils/text_styles.dart';
import '../widgets/info_tile.dart';
import '../widgets/app_card.dart';

class DeviceDetailScreen extends StatelessWidget {
  const DeviceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Device Information')),
      body: BlocBuilder<DeviceBloc, DeviceState>(
        builder: (context, state) {
          if (state is DeviceLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DeviceError) {
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
                    'Failed to load device info',
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

          if (state is DeviceLoaded) {
            final device = state.deviceInfo;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Device Header Card
                  AppCard(
                    child: Column(
                      children: [
                        Icon(
                          Icons.phone_android,
                          size: 64,
                          color: CategoryColors.device,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          device.model,
                          style: AppTextStyles.headlineLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          device.manufacturer,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sectionSpacing),

                  // Device Details
                  Text('Details', style: AppTextStyles.headlineSmall),
                  const SizedBox(height: AppSpacing.md),

                  AppCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        InfoTile(
                          label: 'Manufacturer',
                          value: device.manufacturer,
                          icon: Icons.business,
                          iconColor: CategoryColors.device,
                        ),
                        InfoTile(
                          label: 'Model',
                          value: device.model,
                          icon: Icons.phone_android,
                          iconColor: CategoryColors.device,
                        ),
                        InfoTile(
                          label: 'Brand',
                          value: device.brand,
                          icon: Icons.label,
                          iconColor: CategoryColors.device,
                        ),
                        InfoTile(
                          label: 'Device',
                          value: device.device,
                          icon: Icons.devices,
                          iconColor: CategoryColors.device,
                        ),
                        if (device.hardware != null)
                          InfoTile(
                            label: 'Hardware',
                            value: device.hardware!,
                            icon: Icons.memory,
                            iconColor: CategoryColors.device,
                          ),
                        if (device.androidId != null)
                          InfoTile(
                            label: 'Android ID',
                            value: device.androidId!,
                            icon: Icons.fingerprint,
                            iconColor: CategoryColors.device,
                          ),
                        if (device.sdkVersion != null)
                          InfoTile(
                            label: 'SDK Version',
                            value: device.sdkVersion!,
                            icon: Icons.android,
                            iconColor: CategoryColors.device,
                          ),
                        if (device.releaseVersion != null)
                          InfoTile(
                            label: 'Android Version',
                            value: device.releaseVersion!,
                            icon: Icons.system_update,
                            iconColor: CategoryColors.device,
                          ),
                        if (device.systemName != null)
                          InfoTile(
                            label: 'System Name',
                            value: device.systemName!,
                            icon: Icons.info,
                            iconColor: CategoryColors.device,
                          ),
                        if (device.systemVersion != null)
                          InfoTile(
                            label: 'System Version',
                            value: device.systemVersion!,
                            icon: Icons.info,
                            iconColor: CategoryColors.device,
                          ),
                        if (device.supportedAbis != null &&
                            device.supportedAbis!.isNotEmpty)
                          InfoTile(
                            label: 'Supported ABIs',
                            value: device.supportedAbis!.join(', '),
                            icon: Icons.architecture,
                            iconColor: CategoryColors.device,
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
