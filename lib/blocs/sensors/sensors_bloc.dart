import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/sensors_info.dart';
import '../../data/repositories/sensors_repository.dart';

part 'sensors_event.dart';
part 'sensors_state.dart';

class SensorsBloc extends Bloc<SensorsEvent, SensorsState> {
  final SensorsRepository _repository;

  SensorsBloc(this._repository) : super(SensorsInitial()) {
    on<LoadSensorsInfo>(_onLoadSensorsInfo);
  }

  Future<void> _onLoadSensorsInfo(
    LoadSensorsInfo event,
    Emitter<SensorsState> emit,
  ) async {
    emit(SensorsLoading());
    try {
      final sensorsData = await _repository.getAvailableSensors();
      emit(SensorsLoaded(sensorsData));
    } catch (e) {
      emit(SensorsError(e.toString()));
    }
  }
}
