import '../models/sensors_info.dart';
import '../../services/platform_channels/sensors_channel.dart';

class SensorsRepository {
  final SensorsChannel _channel;

  SensorsRepository(this._channel);

  Future<SensorsData> getAvailableSensors() async {
    try {
      final data = await _channel.getAvailableSensors();
      return SensorsData.fromMap(data);
    } catch (e) {
      throw Exception('Failed to fetch sensors info: $e');
    }
  }
}
