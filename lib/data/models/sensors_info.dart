class SensorInfo {
  final String name;
  final String type;
  final String vendor;
  final int version;
  final double power;
  final double resolution;
  final double maximumRange;

  SensorInfo({
    required this.name,
    required this.type,
    required this.vendor,
    required this.version,
    required this.power,
    required this.resolution,
    required this.maximumRange,
  });

  factory SensorInfo.fromMap(Map<String, dynamic> map) {
    return SensorInfo(
      name: map['name'] ?? 'Unknown',
      type: map['type'] ?? 'Unknown',
      vendor: map['vendor'] ?? 'Unknown',
      version: map['version'] ?? 0,
      power: (map['power'] ?? 0.0).toDouble(),
      resolution: (map['resolution'] ?? 0.0).toDouble(),
      maximumRange: (map['maximumRange'] ?? 0.0).toDouble(),
    );
  }
}

class SensorsData {
  final List<SensorInfo> availableSensors;

  SensorsData({required this.availableSensors});

  factory SensorsData.fromMap(Map<String, dynamic> map) {
    final sensors =
        (map['availableSensors'] as List?)
            ?.map(
              (s) => SensorInfo.fromMap(Map<String, dynamic>.from(s as Map)),
            )
            .toList() ??
        [];
    return SensorsData(availableSensors: sensors);
  }
}
