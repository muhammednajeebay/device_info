import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<ToggleReducedMotion>((event, emit) {
      emit(state.copyWith(reducedMotion: !state.reducedMotion));
    });

    on<ToggleLowPowerMode>((event, emit) {
      emit(state.copyWith(lowPowerMode: !state.lowPowerMode));
    });
  }
}
