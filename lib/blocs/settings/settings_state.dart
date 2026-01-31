import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final bool reducedMotion;
  final bool lowPowerMode;

  const SettingsState({this.reducedMotion = false, this.lowPowerMode = false});

  SettingsState copyWith({bool? reducedMotion, bool? lowPowerMode}) {
    return SettingsState(
      reducedMotion: reducedMotion ?? this.reducedMotion,
      lowPowerMode: lowPowerMode ?? this.lowPowerMode,
    );
  }

  @override
  List<Object> get props => [reducedMotion, lowPowerMode];
}
