import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/sensors/sensors_bloc.dart';
import '../../utils/theme_constants.dart';
import '../../utils/text_styles.dart';

class SensorsDetailScreen extends StatelessWidget {
  const SensorsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sensors Information')),
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
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: AppSpacing.md),
                  Text(state.message),
                  ElevatedButton(
                    onPressed: () {
                      context.read<SensorsBloc>().add(LoadSensorsInfo());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is SensorsLoaded) {
            final sensors = state.sensorsData.availableSensors;
            if (sensors.isEmpty) {
              return const Center(
                child: Text('No sensors found on this device.'),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<SensorsBloc>().add(LoadSensorsInfo());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: sensors.length,
                itemBuilder: (context, index) {
                  final sensor = sensors[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                    elevation: 0,
                    color: Colors.grey.withAlpha(13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: ExpansionTile(
                      leading: Icon(
                        _getSensorIcon(sensor.type),
                        color: Colors.blueAccent,
                      ),
                      title: Text(
                        sensor.name,
                        style: AppTextStyles.labelMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(sensor.type),
                      childrenPadding: const EdgeInsets.all(AppSpacing.md),
                      children: [
                        _buildDetail('Vendor', sensor.vendor),
                        _buildDetail('Version', sensor.version.toString()),
                        _buildDetail('Power', '${sensor.power} mA'),
                        _buildDetail(
                          'Resolution',
                          sensor.resolution.toString(),
                        ),
                        _buildDetail(
                          'Maximum Range',
                          sensor.maximumRange.toString(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
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
