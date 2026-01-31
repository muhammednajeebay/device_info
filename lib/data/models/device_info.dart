import 'package:equatable/equatable.dart';

class DeviceInfo extends Equatable {
  final String manufacturer;
  final String model;
  final String brand;
  final String device;
  final String? hardware;
  final String? androidId;
  final String? fingerprint;
  final String? buildId;
  final String? sdkVersion;
  final String? releaseVersion;
  final String? systemName;
  final String? systemVersion;
  final List<String>? supportedAbis;

  const DeviceInfo({
    required this.manufacturer,
    required this.model,
    required this.brand,
    required this.device,
    this.hardware,
    this.androidId,
    this.fingerprint,
    this.buildId,
    this.sdkVersion,
    this.releaseVersion,
    this.systemName,
    this.systemVersion,
    this.supportedAbis,
  });

  factory DeviceInfo.fromMap(Map<String, dynamic> map) {
    return DeviceInfo(
      manufacturer: map['manufacturer'] as String? ?? 'Unknown',
      model: map['model'] as String? ?? 'Unknown',
      brand: map['brand'] as String? ?? 'Unknown',
      device: map['device'] as String? ?? 'Unknown',
      hardware: map['hardware'] as String?,
      androidId: map['androidId'] as String?,
      fingerprint: map['fingerprint'] as String?,
      buildId: map['buildId'] as String?,
      sdkVersion: map['sdkVersion'] as String?,
      releaseVersion: map['releaseVersion'] as String?,
      systemName: map['systemName'] as String?,
      systemVersion: map['systemVersion'] as String?,
      supportedAbis: (map['supportedAbis'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'manufacturer': manufacturer,
      'model': model,
      'brand': brand,
      'device': device,
      'hardware': hardware,
      'androidId': androidId,
      'fingerprint': fingerprint,
      'buildId': buildId,
      'sdkVersion': sdkVersion,
      'releaseVersion': releaseVersion,
      'systemName': systemName,
      'systemVersion': systemVersion,
      'supportedAbis': supportedAbis,
    };
  }

  @override
  List<Object?> get props => [
    manufacturer,
    model,
    brand,
    device,
    hardware,
    androidId,
    fingerprint,
    buildId,
    sdkVersion,
    releaseVersion,
    systemName,
    systemVersion,
    supportedAbis,
  ];
}
