import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info/blocs/system/system_bloc.dart';
import 'package:device_info/utils/theme_constants.dart';
import 'package:device_info/utils/text_styles.dart';
import 'package:device_info/presentation/widgets/app_card.dart';
import 'package:device_info/presentation/widgets/info_tile.dart';
import 'package:device_info/presentation/widgets/system_pulse_flow.dart';

class SystemDetailScreen extends StatelessWidget {
  const SystemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('System')),
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
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Failed to load system info',
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

          if (state is SystemLoaded) {
            final system = state.systemInfo;
            final double ramUsage = system.ramUsedPercentage ?? 0.0;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Card: System Performance (Pulse & Flow)
                  AppCard(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.xl,
                      horizontal: AppSpacing.lg,
                    ),
                    child: SystemPulseFlow(
                      ramUsage: ramUsage,
                      cpuCores: system.cpuCores ?? 1,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sectionSpacing),

                  // Resources Grid
                  Text(
                    'Resource Analytics',
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
                          label: 'Total Memory',
                          value: _formatBytes(system.totalRam ?? 0),
                          icon: Icons.memory,
                          iconColor: CategoryColors.system,
                        ),
                        InfoTile(
                          label: 'Available Memory',
                          value: _formatBytes(system.availableRam ?? 0),
                          icon: Icons.check_circle_outline,
                          iconColor: AppColors.success,
                        ),
                        InfoTile(
                          label: 'CPU Engine',
                          value:
                              '${system.cpuCores} Cores @ ${system.cpuArchitecture}',
                          icon: Icons.developer_board,
                          iconColor: Colors.orange,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Display Info
                  Text(
                    'Environment Info',
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
                          label: 'Display Matrix',
                          value: system.screenResolution ?? 'Unknown',
                          icon: Icons.display_settings,
                          iconColor: Colors.blue,
                        ),
                        InfoTile(
                          label: 'Pixel Density',
                          value:
                              '${system.screenDensity?.toStringAsFixed(2)}x (DPI)',
                          icon: Icons.grid_4x4,
                          iconColor: Colors.cyan,
                        ),
                        if (system.kernelVersion != null)
                          InfoTile(
                            label: 'Kernel Architecture',
                            value: system.kernelVersion!,
                            icon: Icons.terminal,
                            iconColor: Colors.green,
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
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
