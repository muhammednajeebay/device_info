class ChannelNames {
  static const String battery = 'com.example.device_info/battery';
  static const String device = 'com.example.device_info/device';
  static const String connectivity = 'com.example.device_info/connectivity';
  static const String storage = 'com.example.device_info/storage';
  static const String sensors = 'com.example.device_info/sensors';
  static const String location = 'com.example.device_info/location';
  static const String system = 'com.example.device_info/system';
  static const String audio = 'com.example.device_info/audio';
  static const String camera = 'com.example.device_info/camera';
  static const String telephony = 'com.example.device_info/telephony';
}

class MethodNames {
  // Battery
  static const String getBatteryLevel = 'getBatteryLevel';
  static const String getBatteryInfo = 'getBatteryInfo';

  // Device
  static const String getDeviceInfo = 'getDeviceInfo';
  static const String getDeviceId = 'getDeviceId';

  // Connectivity
  static const String getConnectivityInfo = 'getConnectivityInfo';
  static const String getWifiInfo = 'getWifiInfo';
  static const String getCellularInfo = 'getCellularInfo';

  // Storage
  static const String getStorageInfo = 'getStorageInfo';
  static const String getExternalStorageInfo = 'getExternalStorageInfo';

  // Sensors
  static const String getAvailableSensors = 'getAvailableSensors';
  static const String getSensorData = 'getSensorData';

  // Location
  static const String getCurrentLocation = 'getCurrentLocation';
  static const String getLocationInfo = 'getLocationInfo';

  // System
  static const String getSystemInfo = 'getSystemInfo';
  static const String getCpuInfo = 'getCpuInfo';
  static const String getMemoryInfo = 'getMemoryInfo';

  // Audio
  static const String getAudioInfo = 'getAudioInfo';

  // Camera
  static const String getCameraInfo = 'getCameraInfo';

  // Telephony
  static const String getTelephonyInfo = 'getTelephonyInfo';
}
