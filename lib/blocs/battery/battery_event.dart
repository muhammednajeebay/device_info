part of 'battery_bloc.dart';


abstract class BatteryEvent extends Equatable {
  const BatteryEvent();

  @override
  List<Object> get props => [];
}

class LoadBatteryInfo extends BatteryEvent {}

class BatteryInfoUpdated extends BatteryEvent {
  final Map<String, dynamic> batteryData;

  const BatteryInfoUpdated(this.batteryData);

  @override
  List<Object> get props => [batteryData];
}
