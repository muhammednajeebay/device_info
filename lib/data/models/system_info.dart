import 'package:equatable/equatable.dart';

class SystemInfo extends Equatable {
  final int? cpuCores;
  final String? cpuArchitecture;
  final int? totalRam;
  final int? availableRam;
  final int? freeRam;
  final String? screenResolution;
  final double? screenDensity;
  final int? screenRefreshRate;
  final String? kernelVersion;
  final int? systemUptime;
  final bool? isRooted;

  const SystemInfo({
    this.cpuCores,
    this.cpuArchitecture,
    this.totalRam,
    this.availableRam,
    this.freeRam,
    this.screenResolution,
    this.screenDensity,
    this.screenRefreshRate,
    this.kernelVersion,
    this.systemUptime,
    this.isRooted,
  });

  factory SystemInfo.fromMap(Map<String, dynamic> map) {
    return SystemInfo(
      cpuCores: map['cpuCores'] as int?,
      cpuArchitecture: map['cpuArchitecture'] as String?,
      totalRam: map['totalRam'] as int?,
      availableRam: map['availableRam'] as int?,
      freeRam: map['freeRam'] as int?,
      screenResolution: map['screenResolution'] as String?,
      screenDensity: map['screenDensity'] as double?,
      screenRefreshRate: map['screenRefreshRate'] as int?,
      kernelVersion: map['kernelVersion'] as String?,
      systemUptime: map['systemUptime'] as int?,
      isRooted: map['isRooted'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cpuCores': cpuCores,
      'cpuArchitecture': cpuArchitecture,
      'totalRam': totalRam,
      'availableRam': availableRam,
      'freeRam': freeRam,
      'screenResolution': screenResolution,
      'screenDensity': screenDensity,
      'screenRefreshRate': screenRefreshRate,
      'kernelVersion': kernelVersion,
      'systemUptime': systemUptime,
      'isRooted': isRooted,
    };
  }

  double? get ramUsedPercentage =>
      totalRam != null && availableRam != null && totalRam! > 0
      ? (totalRam! - availableRam!) / totalRam!
      : null;

  @override
  List<Object?> get props => [
    cpuCores,
    cpuArchitecture,
    totalRam,
    availableRam,
    freeRam,
    screenResolution,
    screenDensity,
    screenRefreshRate,
    kernelVersion,
    systemUptime,
    isRooted,
  ];
}
