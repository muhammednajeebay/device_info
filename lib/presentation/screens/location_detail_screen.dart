import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info/blocs/location/location_bloc.dart';
import 'package:device_info/utils/theme_constants.dart';
import 'package:device_info/utils/text_styles.dart';
import 'package:device_info/presentation/widgets/app_card.dart';
import 'package:device_info/presentation/widgets/info_tile.dart';
import 'package:device_info/presentation/widgets/location_pulse_icon.dart';

class LocationDetailScreen extends StatelessWidget {
  const LocationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location')),
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LocationError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_off_rounded,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('Positioning Offline', style: AppTextStyles.titleLarge),
                  const SizedBox(height: AppSpacing.sm),
                  Text(state.message, style: AppTextStyles.bodySmall),
                ],
              ),
            );
          }

          if (state is LocationLoaded) {
            final info = state.locationInfo;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<LocationBloc>().add(LoadLocationInfo());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(AppSpacing.screenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Section: Map Pulse
                    AppCard(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.xl,
                      ),
                      child: Center(
                        child: LocationPulseIcon(
                          color: CategoryColors.location,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sectionSpacing),

                    // Geographical Identity
                    Text(
                      'Geographical Matrix',
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
                            label: 'Latitude Vector',
                            value: (info.latitude ?? 0.0).toStringAsFixed(6),
                            icon: Icons.north,
                            iconColor: Colors.blue,
                          ),
                          InfoTile(
                            label: 'Longitude Vector',
                            value: (info.longitude ?? 0.0).toStringAsFixed(6),
                            icon: Icons.east,
                            iconColor: Colors.green,
                          ),
                          InfoTile(
                            label: 'Positioning Source',
                            value: (info.provider ?? 'Unknown').toUpperCase(),
                            icon: Icons.satellite_alt,
                            iconColor: Colors.purple,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Environmental Data
                    Text(
                      'Atmospheric Stats',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    AppCard(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          InfoTile(
                            label: 'Elevation Depth',
                            value:
                                '${(info.altitude ?? 0.0).toStringAsFixed(2)} m',
                            icon: Icons.height,
                            iconColor: Colors.cyan,
                          ),
                          InfoTile(
                            label: 'Kinetic Velocity',
                            value:
                                '${(info.speed ?? 0.0).toStringAsFixed(2)} m/s',
                            icon: Icons.speed,
                            iconColor: Colors.orange,
                          ),
                          InfoTile(
                            label: 'Navigation Heading',
                            value:
                                '${(info.heading ?? 0.0).toStringAsFixed(2)}°',
                            icon: Icons.explore,
                            iconColor: Colors.red,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Integrity Metrics
                    Text(
                      'Link Integrity',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    AppCard(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          InfoTile(
                            label: 'Precision Margin',
                            value:
                                '${(info.accuracy ?? 0.0).toStringAsFixed(1)} m',
                            icon: Icons.gps_fixed,
                            iconColor: Colors.teal,
                          ),
                          InfoTile(
                            label: 'Mock Verification',
                            value: info.isMock ? 'SECURED / FAKE' : 'AUTHENTIC',
                            icon: info.isMock ? Icons.security : Icons.verified,
                            iconColor: info.isMock
                                ? AppColors.warning
                                : AppColors.success,
                          ),
                        ],
                      ),
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
}
