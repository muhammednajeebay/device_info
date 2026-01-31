import 'package:equatable/equatable.dart';

class BatteryInfo extends Equatable {
  final int level;
  final String status;
  final String? pluggedStatus;
  final String? health;
  final String? technology;
  final int? voltage;
  final int? temperature;
  final int? capacity;
  final bool? isPresent;

  const BatteryInfo({
    required this.level,
    required this.status,
    this.pluggedStatus,
    this.health,
    this.technology,
    this.voltage,
    this.temperature,
    this.capacity,
    this.isPresent,
  });

  bool get isCharging => status.toLowerCase() == 'charging';

  factory BatteryInfo.fromMap(Map<String, dynamic> map) {
    return BatteryInfo(
      level: map['level'] as int? ?? 0,
      status: map['status'] as String? ?? 'Unknown',
      pluggedStatus: map['pluggedStatus'] as String?,
      health: map['health'] as String?,
      technology: map['technology'] as String?,
      voltage: map['voltage'] as int?,
      temperature: map['temperature'] as int?,
      capacity: map['capacity'] as int?,
      isPresent: map['isPresent'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'level': level,
      'status': status,
      'pluggedStatus': pluggedStatus,
      'health': health,
      'technology': technology,
      'voltage': voltage,
      'temperature': temperature,
      'capacity': capacity,
      'isPresent': isPresent,
    };
  }

  @override
  List<Object?> get props => [
    level,
    status,
    pluggedStatus,
    health,
    technology,
    voltage,
    temperature,
    capacity,
    isPresent,
  ];
}
