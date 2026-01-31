import 'package:flutter/services.dart';
import '../../utils/constants.dart';
import '../../utils/log_helper.dart';

class StorageChannel {
  static const MethodChannel _channel = MethodChannel(ChannelNames.storage);

  Future<Map<String, dynamic>> getStorageInfo() async {
    try {
      final Map<dynamic, dynamic> result = await _channel.invokeMethod(
        MethodNames.getStorageInfo,
      );
      final data = Map<String, dynamic>.from(result);
      LogHelper.nativeData('Storage', data);
      return data;
    } on PlatformException catch (e) {
      throw Exception('Failed to get storage info: ${e.message}');
    }
  }
}
