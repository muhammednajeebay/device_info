import 'package:flutter/services.dart';
import '../../utils/constants.dart';
import '../../utils/log_helper.dart';

class ConnectivityChannel {
  static const MethodChannel _channel = MethodChannel(
    ChannelNames.connectivity,
  );

  Future<Map<String, dynamic>> getConnectivityInfo() async {
    try {
      final Map<dynamic, dynamic>? result = await _channel.invokeMethod(
        MethodNames.getConnectivityInfo,
      );
      final data = result != null
          ? Map<String, dynamic>.from(result)
          : <String, dynamic>{};
      LogHelper.nativeData('Connectivity', data);
      return data;
    } on PlatformException catch (e) {
      LogHelper.error(
        'Failed to get connectivity info: ${e.message}',
        'ConnectivityChannel',
      );
      throw Exception('Failed to get connectivity info: ${e.message}');
    }
  }
}
