import '../models/connectivity_info.dart';
import '../../services/platform_channels/connectivity_channel.dart';

class ConnectivityRepository {
  final ConnectivityChannel _channel;

  ConnectivityRepository(this._channel);

  Future<ConnectivityInfo> getConnectivityInfo() async {
    try {
      final data = await _channel.getConnectivityInfo();
      return ConnectivityInfo.fromMap(data);
    } catch (e) {
      throw Exception('Failed to fetch connectivity info: $e');
    }
  }
}
