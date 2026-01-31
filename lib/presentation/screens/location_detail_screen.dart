import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/location/location_bloc.dart';
import '../../utils/theme_constants.dart';
import '../../utils/text_styles.dart';
import '../widgets/info_tile.dart';

class LocationDetailScreen extends StatelessWidget {
  const LocationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Information')),
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
                  const Icon(Icons.location_off, size: 48, color: Colors.grey),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<LocationBloc>().add(LoadLocationInfo());
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
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
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  _buildSection('Coordinates', [
                    InfoTile(
                      label: 'Latitude',
                      value: (info.latitude ?? 0.0).toStringAsFixed(6),
                      icon: Icons.location_on,
                    ),
                    InfoTile(
                      label: 'Longitude',
                      value: (info.longitude ?? 0.0).toStringAsFixed(6),
                      icon: Icons.location_on,
                    ),
                  ]),
                  const SizedBox(height: AppSpacing.lg),
                  _buildSection('Environment', [
                    InfoTile(
                      label: 'Altitude',
                      value: '${(info.altitude ?? 0.0).toStringAsFixed(2)} m',
                      icon: Icons.height,
                    ),
                    InfoTile(
                      label: 'Heading',
                      value: '${(info.heading ?? 0.0).toStringAsFixed(2)}°',
                      icon: Icons.explore,
                    ),
                    InfoTile(
                      label: 'Speed',
                      value: '${(info.speed ?? 0.0).toStringAsFixed(2)} m/s',
                      icon: Icons.speed,
                    ),
                  ]),
                  const SizedBox(height: AppSpacing.lg),
                  _buildSection('Precision', [
                    InfoTile(
                      label: 'Accuracy',
                      value: '${(info.accuracy ?? 0.0).toStringAsFixed(1)} m',
                      icon: Icons.gps_fixed,
                    ),
                    InfoTile(
                      label: 'Provider',
                      value: (info.provider ?? 'Unknown').toUpperCase(),
                      icon: Icons.satellite_alt,
                    ),
                    InfoTile(
                      label: 'Mock Location',
                      value: info.isMock ? 'Yes' : 'No',
                      icon: Icons.security,
                    ),
                  ]),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.md,
            bottom: AppSpacing.sm,
          ),
          child: Text(
            title,
            style: AppTextStyles.titleMedium.copyWith(
              color: CategoryColors.location,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          elevation: 0,
          color: Colors.grey.withAlpha(13),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}
