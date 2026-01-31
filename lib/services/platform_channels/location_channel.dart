import 'package:flutter/services.dart';
import '../../utils/constants.dart';
import '../../utils/log_helper.dart';

class LocationChannel {
  static const MethodChannel _channel = MethodChannel(ChannelNames.location);

  Future<Map<String, dynamic>> getCurrentLocation() async {
    try {
      final Map<dynamic, dynamic>? result = await _channel.invokeMethod(
        MethodNames.getCurrentLocation,
      );
      final data = result != null
          ? Map<String, dynamic>.from(result)
          : <String, dynamic>{};
      LogHelper.nativeData('Location', data);
      return data;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        LogHelper.warning(
          'Location permission requested. Re-run action after granting.',
          'LocationChannel',
        );
        return <String, dynamic>{};
      }
      LogHelper.error(
        'Failed to get current location: ${e.message}',
        'LocationChannel',
      );
      throw Exception('Failed to get current location: ${e.message}');
    }
  }
}
