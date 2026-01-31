part of 'system_bloc.dart';

abstract class SystemEvent extends Equatable {
  const SystemEvent();

  @override
  List<Object> get props => [];
}

class LoadSystemInfo extends SystemEvent {}
