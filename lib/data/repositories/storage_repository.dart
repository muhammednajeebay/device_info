import 'package:device_info/data/models/storage_info.dart';
import 'package:device_info/services/platform_channels/storage_channel.dart';

class StorageRepository {
  final StorageChannel _channel;

  StorageRepository(this._channel);

  Future<StorageInfo> getStorageInfo() async {
    final data = await _channel.getStorageInfo();
    return StorageInfo.fromMap(data);
  }
}
