class ConnectivityInfo {
  final bool isConnected;
  final String type; // wifi, mobile, none
  final String? ipAddress;
  final String? wifiSsid;
  final String? wifiBssid;
  final int? wifiSignalStrength;
  final String? mobileOperator;
  final String? networkGeneration; // 4G, 5G, etc.

  ConnectivityInfo({
    required this.isConnected,
    required this.type,
    this.ipAddress,
    this.wifiSsid,
    this.wifiBssid,
    this.wifiSignalStrength,
    this.mobileOperator,
    this.networkGeneration,
  });

  factory ConnectivityInfo.fromMap(Map<String, dynamic> map) {
    return ConnectivityInfo(
      isConnected: map['isConnected'] ?? false,
      type: map['type'] ?? 'none',
      ipAddress: map['ipAddress'],
      wifiSsid: map['wifiSsid'],
      wifiBssid: map['wifiBssid'],
      wifiSignalStrength: map['wifiSignalStrength'],
      mobileOperator: map['mobileOperator'],
      networkGeneration: map['networkGeneration'],
    );
  }
}
