import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class ToggleReducedMotion extends SettingsEvent {}

class ToggleLowPowerMode extends SettingsEvent {}
