import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info/blocs/storage/storage_bloc.dart';
import 'package:device_info/utils/theme_constants.dart';
import 'package:device_info/utils/text_styles.dart';
import 'package:device_info/presentation/widgets/app_card.dart';
import 'package:device_info/presentation/widgets/info_tile.dart';
import 'package:fl_chart/fl_chart.dart';

class StorageDetailScreen extends StatelessWidget {
  const StorageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Storage'), elevation: 0),
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
                  Icon(Icons.error_outline, size: 64, color: AppColors.error),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Error: ${state.message}',
                    style: AppTextStyles.bodyLarge,
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
                  // Internal Storage Chart
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.storage,
                              color: CategoryColors.storage,
                              size: AppIconSize.lg,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Text(
                              'Internal Storage',
                              style: AppTextStyles.titleLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        SizedBox(
                          height: 200,
                          child: PieChart(
                            PieChartData(
                              sectionsSpace: 2,
                              centerSpaceRadius: 60,
                              sections: [
                                PieChartSectionData(
                                  color: CategoryColors.storage,
                                  value: storage.usedPercentage,
                                  title:
                                      '${storage.usedPercentage.toStringAsFixed(1)}%',
                                  radius: 50,
                                  titleStyle: AppTextStyles.labelMedium
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                PieChartSectionData(
                                  color: AppColors.glassSurface,
                                  value: storage.freePercentage,
                                  title:
                                      '${storage.freePercentage.toStringAsFixed(1)}%',
                                  radius: 50,
                                  titleStyle: AppTextStyles.labelMedium
                                      .copyWith(
                                        color: AppColors.textSecondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildLegendItem('Used', CategoryColors.storage),
                            _buildLegendItem('Free', AppColors.glassSurface),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),

                  // Storage Details
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Storage Details',
                          style: AppTextStyles.titleMedium,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        InfoTile(
                          label: 'Total Space',
                          value: _formatBytes(storage.totalSpace),
                          icon: Icons.sd_storage,
                        ),
                        InfoTile(
                          label: 'Used Space',
                          value: _formatBytes(storage.usedSpace),
                          icon: Icons.folder,
                        ),
                        InfoTile(
                          label: 'Free Space',
                          value: _formatBytes(storage.freeSpace),
                          icon: Icons.folder_open,
                        ),
                      ],
                    ),
                  ),

                  // External Storage (if available)
                  if (storage.externalTotalSpace != null) ...[
                    const SizedBox(height: AppSpacing.lg),
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.sd_card,
                                color: CategoryColors.storage,
                                size: AppIconSize.lg,
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Text(
                                'External Storage',
                                style: AppTextStyles.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          InfoTile(
                            label: 'Total Space',
                            value: _formatBytes(storage.externalTotalSpace!),
                            icon: Icons.sd_storage,
                          ),
                          InfoTile(
                            label: 'Used Space',
                            value: _formatBytes(storage.externalUsedSpace!),
                            icon: Icons.folder,
                          ),
                          InfoTile(
                            label: 'Free Space',
                            value: _formatBytes(storage.externalFreeSpace!),
                            icon: Icons.folder_open,
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

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(label, style: AppTextStyles.labelMedium),
      ],
    );
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }
}
