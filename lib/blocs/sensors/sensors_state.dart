part of 'sensors_bloc.dart';

abstract class SensorsState extends Equatable {
  const SensorsState();

  @override
  List<Object> get props => [];
}

class SensorsInitial extends SensorsState {}

class SensorsLoading extends SensorsState {}

class SensorsLoaded extends SensorsState {
  final SensorsData sensorsData;

  const SensorsLoaded(this.sensorsData);

  @override
  List<Object> get props => [sensorsData];
}

class SensorsError extends SensorsState {
  final String message;

  const SensorsError(this.message);

  @override
  List<Object> get props => [message];
}
