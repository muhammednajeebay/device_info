import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/location_info.dart';
import '../../data/repositories/location_repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _repository;

  LocationBloc(this._repository) : super(LocationInitial()) {
    on<LoadLocationInfo>(_onLoadLocationInfo);
  }

  Future<void> _onLoadLocationInfo(
    LoadLocationInfo event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());
    try {
      final locationInfo = await _repository.getCurrentLocation();
      emit(LocationLoaded(locationInfo));
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }
}
