part of 'connectivity_bloc.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivityLoading extends ConnectivityState {}

class ConnectivityLoaded extends ConnectivityState {
  final ConnectivityInfo connectivityInfo;

  const ConnectivityLoaded(this.connectivityInfo);

  @override
  List<Object> get props => [connectivityInfo];
}

class ConnectivityError extends ConnectivityState {
  final String message;

  const ConnectivityError(this.message);

  @override
  List<Object> get props => [message];
}
