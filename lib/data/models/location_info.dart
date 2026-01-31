class LocationInfo {
  final double? latitude;
  final double? longitude;
  final double? altitude;
  final double? accuracy;
  final double? speed;
  final double? heading;
  final String? provider;
  final bool isMock;

  LocationInfo({
    this.latitude,
    this.longitude,
    this.altitude,
    this.accuracy,
    this.speed,
    this.heading,
    this.provider,
    required this.isMock,
  });

  factory LocationInfo.fromMap(Map<String, dynamic> map) {
    return LocationInfo(
      latitude: (map['latitude'] as num?)?.toDouble(),
      longitude: (map['longitude'] as num?)?.toDouble(),
      altitude: (map['altitude'] as num?)?.toDouble(),
      accuracy: (map['accuracy'] as num?)?.toDouble(),
      speed: (map['speed'] as num?)?.toDouble(),
      heading: (map['heading'] as num?)?.toDouble(),
      provider: map['provider'],
      isMock: map['isMock'] ?? false,
    );
  }
}
