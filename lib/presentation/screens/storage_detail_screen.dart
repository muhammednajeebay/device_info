import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info/blocs/storage/storage_bloc.dart';
import 'package:device_info/utils/theme_constants.dart';
import 'package:device_info/utils/text_styles.dart';
import 'package:device_info/presentation/widgets/app_card.dart';
import 'package:device_info/presentation/widgets/info_tile.dart';
import 'package:device_info/presentation/widgets/data_mass_visualization.dart';

class StorageDetailScreen extends StatelessWidget {
  const StorageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Storage')),
      body: BlocBuilder<StorageBloc, StorageState>(
        builder: (context, state) {
          if (state is StorageLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is StorageError) {
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
                    'Failed to load storage info',
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

          if (state is StorageLoaded) {
            final storage = state.storageInfo;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Section: Data Mass Visualization
                  AppCard(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.lg,
                    ),
                    child: DataMassVisualization(
                      usedPercentage: storage.usedPercentage,
                      totalUsed: _formatBytes(storage.usedSpace),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sectionSpacing),

                  // Storage Breakdown / Details
                  Text(
                    'Storage Analytics',
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
                          label: 'Total Capacity',
                          value: _formatBytes(storage.totalSpace),
                          icon: Icons.sd_storage,
                          iconColor: CategoryColors.storage,
                        ),
                        InfoTile(
                          label: 'Available Space',
                          value: _formatBytes(storage.freeSpace),
                          icon: Icons.folder_open,
                          iconColor: Colors.green,
                        ),
                        InfoTile(
                          label: 'Used Space',
                          value: _formatBytes(storage.usedSpace),
                          icon: Icons.folder,
                          iconColor: Colors.orange,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // External Storage
                  if (storage.externalTotalSpace != null &&
                      storage.externalTotalSpace! > 0) ...[
                    Text(
                      'External Storage',
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
                            label: 'SD Card Total',
                            value: _formatBytes(storage.externalTotalSpace!),
                            icon: Icons.sd_card,
                            iconColor: CategoryColors.storage,
                          ),
                          InfoTile(
                            label: 'SD Card Available',
                            value: _formatBytes(storage.externalFreeSpace!),
                            icon: Icons.folder_open,
                            iconColor: Colors.green,
                          ),
                        ],
                      ),
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

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
