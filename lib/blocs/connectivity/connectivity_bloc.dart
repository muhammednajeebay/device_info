import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/connectivity_info.dart';
import '../../data/repositories/connectivity_repository.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityRepository _repository;

  ConnectivityBloc(this._repository) : super(ConnectivityInitial()) {
    on<LoadConnectivityInfo>(_onLoadConnectivityInfo);
  }

  Future<void> _onLoadConnectivityInfo(
    LoadConnectivityInfo event,
    Emitter<ConnectivityState> emit,
  ) async {
    emit(ConnectivityLoading());
    try {
      final connectivityInfo = await _repository.getConnectivityInfo();
      emit(ConnectivityLoaded(connectivityInfo));
    } catch (e) {
      emit(ConnectivityError(e.toString()));
    }
  }
}
