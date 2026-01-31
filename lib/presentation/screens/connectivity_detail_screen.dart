import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_info/blocs/connectivity/connectivity_bloc.dart';
import 'package:device_info/utils/theme_constants.dart';
import 'package:device_info/utils/text_styles.dart';
import 'package:device_info/presentation/widgets/app_card.dart';
import 'package:device_info/presentation/widgets/info_tile.dart';
import 'package:device_info/presentation/widgets/signal_propagation_icon.dart';

class ConnectivityDetailScreen extends StatelessWidget {
  const ConnectivityDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connectivity')),
      body: BlocBuilder<ConnectivityBloc, ConnectivityState>(
        builder: (context, state) {
          if (state is ConnectivityLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ConnectivityError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('Connection Error', style: AppTextStyles.titleLarge),
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

          if (state is ConnectivityLoaded) {
            final info = state.connectivityInfo;
            final strengthStr = info.wifiSignalStrength;

            // Normalize dBm to 0.0 - 1.0 (Typical -100 to -30)
            double normalizedStrength = 0.5;
            if (strengthStr != null) {
              normalizedStrength = ((strengthStr + 100) / 70).clamp(0.1, 1.0);
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ConnectivityBloc>().add(LoadConnectivityInfo());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(AppSpacing.screenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Section: Signal Propagation
                    AppCard(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.xl,
                      ),
                      child: Center(
                        child: SignalPropagationIcon(
                          color: CategoryColors.connectivity,
                          signalStrength: info.isConnected
                              ? normalizedStrength
                              : 0.0,
                          icon: _getConnectionIcon(info.type),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sectionSpacing),

                    // Network Metrics
                    Text(
                      'Transmission Details',
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
                            label: 'Connection State',
                            value: info.isConnected ? 'ACTIVE' : 'DISCONNECTED',
                            icon: info.isConnected
                                ? Icons.check_circle
                                : Icons.error,
                            iconColor: info.isConnected
                                ? AppColors.success
                                : AppColors.error,
                          ),
                          InfoTile(
                            label: 'Network Type',
                            value: info.type.toUpperCase(),
                            icon: Icons.category,
                            iconColor: Colors.blue,
                          ),
                          if (info.ipAddress != null)
                            InfoTile(
                              label: 'IP Protocol',
                              value: info.ipAddress!,
                              icon: Icons.lan,
                              iconColor: Colors.purple,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    if (info.type == 'wifi' && info.wifiSsid != null) ...[
                      Text(
                        'Wireless Protocol',
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
                              label: 'SSID Identity',
                              value: info.wifiSsid!,
                              icon: Icons.wifi,
                              iconColor: Colors.cyan,
                            ),
                            if (info.wifiBssid != null)
                              InfoTile(
                                label: 'BSSID Signature',
                                value: info.wifiBssid!,
                                icon: Icons.router,
                                iconColor: Colors.orange,
                              ),
                            if (info.wifiSignalStrength != null)
                              InfoTile(
                                label: 'Signal Magnitude',
                                value: '${info.wifiSignalStrength} dBm',
                                icon: Icons.equalizer,
                                iconColor: Colors.green,
                              ),
                          ],
                        ),
                      ),
                    ],

                    if (info.type == 'mobile') ...[
                      Text(
                        'Cellular Link',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      AppCard(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            if (info.mobileOperator != null)
                              InfoTile(
                                label: 'Carrier Network',
                                value: info.mobileOperator!,
                                icon: Icons.business,
                                iconColor: Colors.blue,
                              ),
                            if (info.networkGeneration != null)
                              InfoTile(
                                label: 'Standard Generation',
                                value: info.networkGeneration!,
                                icon: Icons.four_g_mobiledata,
                                iconColor: Colors.orange,
                              ),
                          ],
                        ),
                      ),
                    ],
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

  IconData _getConnectionIcon(String type) {
    switch (type.toLowerCase()) {
      case 'wifi':
        return Icons.wifi;
      case 'mobile':
        return Icons.signal_cellular_alt;
      case 'ethernet':
        return Icons.settings_ethernet;
      default:
        return Icons.help_outline;
    }
  }
}
