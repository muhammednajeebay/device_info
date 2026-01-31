part of 'system_bloc.dart';

abstract class SystemState extends Equatable {
  const SystemState();

  @override
  List<Object> get props => [];
}

class SystemInitial extends SystemState {}

class SystemLoading extends SystemState {}

class SystemLoaded extends SystemState {
  final SystemInfo systemInfo;

  const SystemLoaded(this.systemInfo);

  @override
  List<Object> get props => [systemInfo];
}

class SystemError extends SystemState {
  final String message;

  const SystemError(this.message);

  @override
  List<Object> get props => [message];
}
