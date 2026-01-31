import '../models/battery_info.dart';
import '../../services/platform_channels/battery_channel.dart';

class BatteryRepository {
  final BatteryChannel _batteryChannel;

  BatteryRepository(this._batteryChannel);

  Future<BatteryInfo> getBatteryInfo() async {
    try {
      final data = await _batteryChannel.getBatteryInfo();
      return BatteryInfo.fromMap(data);
    } catch (e) {
      throw Exception('Failed to fetch battery info: $e');
    }
  }

  Stream<BatteryInfo> watchBatteryInfo() {
    return _batteryChannel.batteryStream.map((data) {
      return BatteryInfo.fromMap(data);
    });
  }
}
