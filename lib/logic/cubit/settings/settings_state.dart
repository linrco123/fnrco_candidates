part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

class ShowBiometricSettingsState extends SettingsState{
  final bool status;

  ShowBiometricSettingsState({required this.status});
}
class ShowBrightnessModeSettingsState extends SettingsState{
  final bool status;

  ShowBrightnessModeSettingsState({required this.status});
}
class ToggleBiometricSettingsState extends SettingsState{
  final bool status;

  ToggleBiometricSettingsState({required this.status});
}


class ToggleBrightnessModeSettingsState extends SettingsState{
  final bool status;

  ToggleBrightnessModeSettingsState({required this.status});
}
