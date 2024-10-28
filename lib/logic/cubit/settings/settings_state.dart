part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

class ShowBiometricSettingsState extends SettingsState{
  final bool status;

  ShowBiometricSettingsState({required this.status});
}

class ToggleBiometricSettingsState extends SettingsState{
  final bool status;

  ToggleBiometricSettingsState({required this.status});
}
