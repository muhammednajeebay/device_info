import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/battery/battery_bloc.dart';
import '../../blocs/device/device_bloc.dart';
import '../../blocs/storage/storage_bloc.dart';
import '../../blocs/system/system_bloc.dart';
import '../../blocs/connectivity/connectivity_bloc.dart';
import '../../blocs/sensors/sensors_bloc.dart';
import '../../blocs/location/location_bloc.dart';
import '../../blocs/settings/settings_bloc.dart';
import '../../blocs/settings/settings_state.dart';
import '../../blocs/settings/settings_event.dart';
import '../../utils/theme_constants.dart';
import '../../utils/text_styles.dart';
import '../widgets/category_card.dart';
import '../widgets/health_ring.dart';
import '../widgets/quick_stat_widget.dart';
import '../widgets/liquid_wave_icon.dart';
import '../widgets/holographic_icon.dart';
import '../widgets/audio_waveform_icon.dart';
import '../widgets/storage_bar_chart_icon.dart';
import '../widgets/signal_propagation_icon.dart';
import '../widgets/radar_sweep_icon.dart';
import '../widgets/location_pulse_icon.dart';
import '../widgets/page_transitions.dart';
import 'battery_detail_screen.dart';
import 'device_detail_screen.dart';
import 'storage_detail_screen.dart';
import 'system_detail_screen.dart';
import 'connectivity_detail_screen.dart';
import 'sensors_detail_screen.dart';
import 'location_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: CategoryColors.spaceGradient,
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Floating Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Colors.blue, Colors.purple, Colors.pink],
                            ).createShader(bounds),
                            child: Text(
                              'Device Info',
                              style: AppTextStyles.displaySmall.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          BlocBuilder<DeviceBloc, DeviceState>(
                            builder: (context, state) {
                              return Text(
                                state is DeviceLoaded
                                    ? state.deviceInfo.model
                                    : 'Loading...',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                  letterSpacing: 1.1,
                                ),
                              );
                            },
                          ),
                          Text(
                            'Premium Hardware Intelligence',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: Colors.white70,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.success.withOpacity(0.5),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: AppColors.success,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'LIVE',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.success,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: AppSpacing.md),
                          IconButton(
                            icon: const Icon(
                              Icons.tune_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () => _showSettingsModal(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Hero Health Ring
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
                  child: BlocBuilder<BatteryBloc, BatteryState>(
                    builder: (context, state) {
                      double batteryLevel = 0;
                      if (state is BatteryLoaded) {
                        batteryLevel = state.batteryInfo.level.toDouble();
                      }
                      return HealthRing(
                        value: batteryLevel,
                        label: 'SYSTEM HEALTH',
                      );
                    },
                  ),
                ),
              ),

              // Quick Stats 2x2 Grid
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSpacing.md,
                    crossAxisSpacing: AppSpacing.md,
                    childAspectRatio: 1.5,
                  ),
                  delegate: SliverChildListDelegate([
                    BlocBuilder<BatteryBloc, BatteryState>(
                      builder: (context, state) => QuickStatWidget(
                        icon: Icons.bolt_rounded,
                        label: 'BATTERY',
                        value: state is BatteryLoaded
                            ? '${state.batteryInfo.level}%'
                            : '...',
                        subLabel:
                            state is BatteryLoaded &&
                                state.batteryInfo.isCharging
                            ? 'Charging'
                            : 'Discharging',
                        color: CategoryColors.battery,
                      ),
                    ),
                    BlocBuilder<StorageBloc, StorageState>(
                      builder: (context, state) {
                        String value = '...';
                        String sub = 'Used';
                        if (state is StorageLoaded) {
                          value =
                              '${(state.storageInfo.usedSpace / (1024 * 1024 * 1024)).toStringAsFixed(1)}GB';
                        }
                        return QuickStatWidget(
                          icon: Icons.storage_rounded,
                          label: 'STORAGE',
                          value: value,
                          subLabel: sub,
                          color: CategoryColors.storage,
                        );
                      },
                    ),
                    BlocBuilder<SystemBloc, SystemState>(
                      builder: (context, state) {
                        String value = '...';
                        if (state is SystemLoaded) {
                          value = '${state.systemInfo.cpuCores} Cores';
                        }
                        return QuickStatWidget(
                          icon: Icons.memory_rounded,
                          label: 'MEMORY',
                          value: value,
                          subLabel: 'Available',
                          color: CategoryColors.system,
                        );
                      },
                    ),
                    BlocBuilder<SystemBloc, SystemState>(
                      builder: (context, state) => const QuickStatWidget(
                        icon: Icons.thermostat_rounded,
                        label: 'TEMP',
                        value: '35°C',
                        subLabel: 'Normal',
                        color: AppColors.warning,
                      ),
                    ),
                  ]),
                ),
              ),

              // Detailed Sections Title
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.xxl,
                    AppSpacing.lg,
                    AppSpacing.md,
                  ),
                  child: Text(
                    'DETAILED ANALYSIS',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ),

              // Detailed Sections
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    BlocBuilder<BatteryBloc, BatteryState>(
                      builder: (context, state) => CategoryCard(
                        title: 'Battery',
                        value: state is BatteryLoaded
                            ? '${state.batteryInfo.level}%'
                            : '...',
                        subtitle:
                            state is BatteryLoaded &&
                                state.batteryInfo.isCharging
                            ? 'Charging'
                            : 'Optimized',
                        icon: Icons.bolt_rounded,
                        color: CategoryColors.battery,
                        animationWidget: state is BatteryLoaded
                            ? LiquidWaveIcon(
                                progress: state.batteryInfo.level / 100,
                                isCharging: state.batteryInfo.isCharging,
                                color: CategoryColors.battery,
                              )
                            : null,
                        onTap: () => Navigator.push(
                          context,
                          ModernPageRoute(page: const BatteryDetailScreen()),
                        ),
                      ),
                    ),
                    BlocBuilder<DeviceBloc, DeviceState>(
                      builder: (context, state) => CategoryCard(
                        title: 'Device',
                        value: state is DeviceLoaded
                            ? state.deviceInfo.model
                            : '...',
                        subtitle: state is DeviceLoaded
                            ? state.deviceInfo.manufacturer
                            : 'Holographic',
                        icon: Icons.smartphone_rounded,
                        color: CategoryColors.device,
                        animationWidget: const HolographicIcon(
                          icon: Icons.smartphone_rounded,
                          color: CategoryColors.device,
                        ),
                        onTap: () => Navigator.push(
                          context,
                          ModernPageRoute(page: const DeviceDetailScreen()),
                        ),
                      ),
                    ),
                    BlocBuilder<StorageBloc, StorageState>(
                      builder: (context, state) => CategoryCard(
                        title: 'Storage',
                        value: state is StorageLoaded
                            ? '${(state.storageInfo.usedSpace / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB'
                            : '...',
                        subtitle: 'Rising Bar Chart',
                        icon: Icons.storage_rounded,
                        color: CategoryColors.storage,
                        animationWidget: const StorageBarChartIcon(
                          color: CategoryColors.storage,
                        ),
                        onTap: () => Navigator.push(
                          context,
                          ModernPageRoute(page: const StorageDetailScreen()),
                        ),
                      ),
                    ),
                    BlocBuilder<SystemBloc, SystemState>(
                      builder: (context, state) => CategoryCard(
                        title: 'Processor',
                        value: state is SystemLoaded
                            ? '${state.systemInfo.cpuCores} Cores'
                            : '...',
                        subtitle: 'Audio Waveform Active',
                        icon: Icons.memory_rounded,
                        color: CategoryColors.system,
                        animationWidget: const AudioWaveformIcon(
                          color: CategoryColors.system,
                        ),
                        onTap: () => Navigator.push(
                          context,
                          ModernPageRoute(page: const SystemDetailScreen()),
                        ),
                      ),
                    ),
                    BlocBuilder<ConnectivityBloc, ConnectivityState>(
                      builder: (context, state) => CategoryCard(
                        title: 'Network',
                        value: state is ConnectivityLoaded
                            ? state.connectivityInfo.type.toUpperCase()
                            : '...',
                        subtitle: 'Signal Propagation',
                        icon: Icons.wifi_rounded,
                        color: CategoryColors.connectivity,
                        animationWidget: const SignalPropagationIcon(
                          color: CategoryColors.connectivity,
                          icon: Icons.wifi_rounded,
                        ),
                        onTap: () => Navigator.push(
                          context,
                          ModernPageRoute(
                            page: const ConnectivityDetailScreen(),
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<SensorsBloc, SensorsState>(
                      builder: (context, state) => CategoryCard(
                        title: 'Sensors',
                        value: state is SensorsLoaded
                            ? '${state.sensorsData.availableSensors.length} Sensors'
                            : '...',
                        subtitle: 'Radar Sweep Active',
                        icon: Icons.sensors_rounded,
                        color: CategoryColors.sensors,
                        animationWidget: const RadarSweepIcon(
                          color: CategoryColors.sensors,
                          sensorCount: 8,
                        ),
                        onTap: () => Navigator.push(
                          context,
                          ModernPageRoute(page: const SensorsDetailScreen()),
                        ),
                      ),
                    ),
                    BlocBuilder<LocationBloc, LocationState>(
                      builder: (context, state) => CategoryCard(
                        title: 'Location',
                        value: state is LocationLoaded
                            ? '${state.locationInfo.latitude?.toStringAsFixed(2)}, ${state.locationInfo.longitude?.toStringAsFixed(2)}'
                            : '...',
                        subtitle: 'Animated Map Pulse',
                        icon: Icons.location_on_rounded,
                        color: CategoryColors.location,
                        animationWidget: const LocationPulseIcon(
                          color: CategoryColors.location,
                        ),
                        onTap: () => Navigator.push(
                          context,
                          ModernPageRoute(page: const LocationDetailScreen()),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSettingsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0E21).withOpacity(0.95),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
          border: Border.all(color: Colors.white12, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'System Configuration',
              style: AppTextStyles.titleLarge.copyWith(color: Colors.white),
            ),
            const SizedBox(height: AppSpacing.lg),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return Column(
                  children: [
                    _buildSettingToggle(
                      context,
                      title: 'Reduced Motion',
                      subtitle: 'Disable complex visual animations',
                      value: state.reducedMotion,
                      onChanged: (_) => context.read<SettingsBloc>().add(
                        ToggleReducedMotion(),
                      ),
                      icon: Icons.motion_photos_off_rounded,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildSettingToggle(
                      context,
                      title: 'Low Power mode',
                      subtitle: 'Optimize for battery life',
                      value: state.lowPowerMode,
                      onChanged: (_) => context.read<SettingsBloc>().add(
                        ToggleLowPowerMode(),
                      ),
                      icon: Icons.battery_saver_rounded,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingToggle(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(
          title,
          style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
        ),
        subtitle: Text(
          subtitle,
          style: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
