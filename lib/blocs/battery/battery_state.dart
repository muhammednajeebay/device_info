part of 'battery_bloc.dart';

abstract class BatteryState extends Equatable {
  const BatteryState();

  @override
  List<Object> get props => [];
}

class BatteryInitial extends BatteryState {}

class BatteryLoading extends BatteryState {}

class BatteryLoaded extends BatteryState {
  final BatteryInfo batteryInfo;

  const BatteryLoaded(this.batteryInfo);

  @override
  List<Object> get props => [batteryInfo];
}

class BatteryError extends BatteryState {
  final String message;

  const BatteryError(this.message);

  @override
  List<Object> get props => [message];
}
