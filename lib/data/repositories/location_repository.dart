import '../models/location_info.dart';
import '../../services/platform_channels/location_channel.dart';

class LocationRepository {
  final LocationChannel _channel;

  LocationRepository(this._channel);

  Future<LocationInfo> getCurrentLocation() async {
    try {
      final data = await _channel.getCurrentLocation();
      return LocationInfo.fromMap(data);
    } catch (e) {
      throw Exception('Failed to fetch location info: $e');
    }
  }
}
