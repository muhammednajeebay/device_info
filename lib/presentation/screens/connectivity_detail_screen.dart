import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/connectivity/connectivity_bloc.dart';
import '../../utils/theme_constants.dart';
import '../../utils/text_styles.dart';
import '../widgets/info_tile.dart';

class ConnectivityDetailScreen extends StatelessWidget {
  const ConnectivityDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connectivity Information')),
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
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: AppSpacing.md),
                  Text(state.message),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ConnectivityBloc>().add(
                        LoadConnectivityInfo(),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ConnectivityLoaded) {
            final info = state.connectivityInfo;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ConnectivityBloc>().add(LoadConnectivityInfo());
              },
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  _buildSection('Status', [
                    InfoTile(
                      label: 'Connected',
                      value: info.isConnected ? 'Yes' : 'No',
                      icon: info.isConnected ? Icons.check_circle : Icons.error,
                      iconColor: info.isConnected ? Colors.green : Colors.red,
                    ),
                    InfoTile(
                      label: 'Type',
                      value: info.type.toUpperCase(),
                      icon: _getConnectionIcon(info.type),
                    ),
                  ]),
                  const SizedBox(height: AppSpacing.lg),
                  _buildSection('Network Details', [
                    InfoTile(
                      label: 'IP Address',
                      value: info.ipAddress ?? 'Unknown',
                      icon: Icons.lan,
                    ),
                    if (info.type == 'wifi')
                      InfoTile(
                        label: 'Wi-Fi SSID',
                        value: info.wifiSsid ?? 'Unknown',
                        icon: Icons.wifi,
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
              color: CategoryColors.connectivity,
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
