import 'package:device_info/data/repositories/system_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:device_info/data/models/system_info.dart';

part 'system_event.dart';
part 'system_state.dart';

class SystemBloc extends Bloc<SystemEvent, SystemState> {
  final SystemRepository _repository;

  SystemBloc(this._repository) : super(SystemInitial()) {
    on<LoadSystemInfo>(_onLoadSystemInfo);
  }

  Future<void> _onLoadSystemInfo(
    LoadSystemInfo event,
    Emitter<SystemState> emit,
  ) async {
    emit(SystemLoading());
    try {
      final systemInfo = await _repository.getSystemInfo();
      emit(SystemLoaded(systemInfo));
    } catch (e) {
      emit(SystemError(e.toString()));
    }
  }
}
