import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info/blocs/device/device_bloc.dart';
import '../../utils/theme_constants.dart';
import '../../utils/text_styles.dart';
import '../widgets/info_tile.dart';
import '../widgets/app_card.dart';
import '../widgets/holographic_icon.dart';

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
                  // Hero Card: Holographic Identity
                  AppCard(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.xxl,
                      horizontal: AppSpacing.lg,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Left: Holographic Projection
                        Expanded(
                          flex: 2,
                          child: Hero(
                            tag: 'device_icon',
                            child: HolographicIcon(
                              icon: Icons.phone_android,
                              color: CategoryColors.device,
                              size: 100,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.lg),
                        // Right: Device Identity
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                device.manufacturer.toUpperCase(),
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.textSecondary,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                device.model,
                                style: AppTextStyles.displaySmall.copyWith(
                                  fontSize: 28,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.md),
                              _buildMetadataChip(
                                'Android ${device.releaseVersion ?? '?'}',
                                Icons.android,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sectionSpacing),

                  // Metadata Grid
                  Text(
                    'Hardware Metadata',
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
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
                          label: 'Brand',
                          value: device.brand,
                          icon: Icons.label,
                          iconColor: CategoryColors.device,
                        ),
                        InfoTile(
                          label: 'Board / Hardware',
                          value:
                              '${device.device} / ${device.hardware ?? 'Unknown'}',
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
                        InfoTile(
                          label: 'API Level',
                          value: device.sdkVersion ?? 'N/A',
                          icon: Icons.code,
                          iconColor: CategoryColors.device,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Supported ABIs as Chips
                  if (device.supportedAbis != null &&
                      device.supportedAbis!.isNotEmpty) ...[
                    Text(
                      'Supported Architectures',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: device.supportedAbis!
                          .map(
                            (abi) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.md,
                                vertical: AppSpacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.glassSurface,
                                borderRadius: BorderRadius.circular(
                                  AppRadius.chip,
                                ),
                                border: Border.all(
                                  color: AppColors.glassBorder,
                                ),
                              ),
                              child: Text(
                                abi,
                                style: AppTextStyles.monoMedium.copyWith(
                                  fontSize: 12,
                                  color: CategoryColors.device,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildMetadataChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: CategoryColors.device.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(color: CategoryColors.device.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: CategoryColors.device),
          const SizedBox(width: AppSpacing.sm),
          Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: CategoryColors.device,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
