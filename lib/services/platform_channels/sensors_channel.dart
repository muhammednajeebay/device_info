import 'package:flutter/services.dart';
import '../../utils/constants.dart';
import '../../utils/log_helper.dart';

class SensorsChannel {
  static const MethodChannel _channel = MethodChannel(ChannelNames.sensors);

  Future<Map<String, dynamic>> getAvailableSensors() async {
    try {
      final Map<dynamic, dynamic>? result = await _channel.invokeMethod(
        MethodNames.getAvailableSensors,
      );
      final data = result != null
          ? Map<String, dynamic>.from(result)
          : <String, dynamic>{};
      LogHelper.nativeData('Sensors', data);
      return data;
    } on PlatformException catch (e) {
      LogHelper.error(
        'Failed to get available sensors: ${e.message}',
        'SensorsChannel',
      );
      throw Exception('Failed to get available sensors: ${e.message}');
    }
  }
}
