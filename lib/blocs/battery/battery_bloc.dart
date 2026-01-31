import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/battery_repository.dart';
import '../../data/models/battery_info.dart';
import 'package:equatable/equatable.dart';

part 'battery_event.dart';
part 'battery_state.dart';

class BatteryBloc extends Bloc<BatteryEvent, BatteryState> {
  final BatteryRepository _repository;
  StreamSubscription? _batterySubscription;

  BatteryBloc(this._repository) : super(BatteryInitial()) {
    on<LoadBatteryInfo>(_onLoadBatteryInfo);
    on<BatteryInfoUpdated>(_onBatteryInfoUpdated);
  }

  Future<void> _onLoadBatteryInfo(
    LoadBatteryInfo event,
    Emitter<BatteryState> emit,
  ) async {
    emit(BatteryLoading());
    try {
      final batteryInfo = await _repository.getBatteryInfo();
      emit(BatteryLoaded(batteryInfo));

      // Subscribe to battery updates
      _batterySubscription?.cancel();
      _batterySubscription = _repository.watchBatteryInfo().listen((
        batteryInfo,
      ) {
        add(BatteryInfoUpdated(batteryInfo.toMap()));
      });
    } catch (e) {
      emit(BatteryError(e.toString()));
    }
  }

  void _onBatteryInfoUpdated(
    BatteryInfoUpdated event,
    Emitter<BatteryState> emit,
  ) {
    try {
      // Battery info will be updated via stream
      // The event contains the updated data
    } catch (e) {
      emit(BatteryError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _batterySubscription?.cancel();
    return super.close();
  }
}
