import 'package:flutter/services.dart';
import '../../utils/constants.dart';
import '../../utils/log_helper.dart';

class BatteryChannel {
  static const MethodChannel _channel = MethodChannel(ChannelNames.battery);
  static const EventChannel _eventChannel = EventChannel(
    '${ChannelNames.battery}/stream',
  );

  // Get battery info once
  Future<Map<String, dynamic>> getBatteryInfo() async {
    try {
      final Map<dynamic, dynamic> result = await _channel.invokeMethod(
        MethodNames.getBatteryInfo,
      );
      final data = Map<String, dynamic>.from(result);
      LogHelper.nativeData('Battery (Single)', data);
      return data;
    } on PlatformException catch (e) {
      throw Exception('Failed to get battery info: ${e.message}');
    }
  }

  // Stream battery updates
  Stream<Map<String, dynamic>> get batteryStream {
    return _eventChannel.receiveBroadcastStream().map((event) {
      final data = Map<String, dynamic>.from(event as Map);
      LogHelper.nativeData('Battery (Stream)', data);
      return data;
    });
  }
}
