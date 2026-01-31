import 'package:equatable/equatable.dart';

class StorageInfo extends Equatable {
  final int totalSpace;
  final int freeSpace;
  final int usedSpace;
  final int? externalTotalSpace;
  final int? externalFreeSpace;
  final int? externalUsedSpace;
  final bool? hasExternalStorage;

  const StorageInfo({
    required this.totalSpace,
    required this.freeSpace,
    required this.usedSpace,
    this.externalTotalSpace,
    this.externalFreeSpace,
    this.externalUsedSpace,
    this.hasExternalStorage,
  });

  factory StorageInfo.fromMap(Map<String, dynamic> map) {
    return StorageInfo(
      totalSpace: map['totalSpace'] as int? ?? 0,
      freeSpace: map['freeSpace'] as int? ?? 0,
      usedSpace: map['usedSpace'] as int? ?? 0,
      externalTotalSpace: map['externalTotalSpace'] as int?,
      externalFreeSpace: map['externalFreeSpace'] as int?,
      externalUsedSpace: map['externalUsedSpace'] as int?,
      hasExternalStorage: map['hasExternalStorage'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalSpace': totalSpace,
      'freeSpace': freeSpace,
      'usedSpace': usedSpace,
      'externalTotalSpace': externalTotalSpace,
      'externalFreeSpace': externalFreeSpace,
      'externalUsedSpace': externalUsedSpace,
      'hasExternalStorage': hasExternalStorage,
    };
  }

  double get usedPercentage => totalSpace > 0 ? usedSpace / totalSpace : 0.0;
  double get freePercentage => totalSpace > 0 ? freeSpace / totalSpace : 0.0;

  @override
  List<Object?> get props => [
    totalSpace,
    freeSpace,
    usedSpace,
    externalTotalSpace,
    externalFreeSpace,
    externalUsedSpace,
    hasExternalStorage,
  ];
}
