import 'package:device_info/data/models/system_info.dart';
import 'package:device_info/services/platform_channels/system_channel.dart';

class SystemRepository {
  final SystemChannel _channel;

  SystemRepository(this._channel);

  Future<SystemInfo> getSystemInfo() async {
    final data = await _channel.getSystemInfo();
    return SystemInfo.fromMap(data);
  }
}
