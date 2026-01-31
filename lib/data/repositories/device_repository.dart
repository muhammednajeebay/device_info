import '../models/device_info.dart';
import '../../services/platform_channels/device_channel.dart';

class DeviceRepository {
  final DeviceChannel _deviceChannel;

  DeviceRepository(this._deviceChannel);

  Future<DeviceInfo> getDeviceInfo() async {
    try {
      final data = await _deviceChannel.getDeviceInfo();
      return DeviceInfo.fromMap(data);
    } catch (e) {
      throw Exception('Failed to fetch device info: $e');
    }
  }
}
