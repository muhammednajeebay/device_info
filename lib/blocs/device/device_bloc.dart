import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/device_repository.dart';
import '../../data/models/device_info.dart';
import 'package:equatable/equatable.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceRepository _repository;

  DeviceBloc(this._repository) : super(DeviceInitial()) {
    on<LoadDeviceInfo>(_onLoadDeviceInfo);
  }

  Future<void> _onLoadDeviceInfo(
    LoadDeviceInfo event,
    Emitter<DeviceState> emit,
  ) async {
    emit(DeviceLoading());
    try {
      final deviceInfo = await _repository.getDeviceInfo();
      emit(DeviceLoaded(deviceInfo));
    } catch (e) {
      emit(DeviceError(e.toString()));
    }
  }
}
