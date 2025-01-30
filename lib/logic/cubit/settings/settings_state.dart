part of 'settings_cubit.dart';

@immutable
sealed   class  SettingsState {}

final   class  SettingsInitial extends SettingsState {}

final class  ShowBiometricSettingsState extends SettingsState{
  final bool status;

  ShowBiometricSettingsState({required this.status});
}
final class  ShowBrightnessModeSettingsState extends SettingsState{
  final bool status;

  ShowBrightnessModeSettingsState({required this.status});
}
final class  ToggleBiometricSettingsState extends SettingsState{
  final bool status;

  ToggleBiometricSettingsState({required this.status});
}


final class  ToggleBrightnessModeSettingsState extends SettingsState{
  final int status;

  ToggleBrightnessModeSettingsState({required this.status});
}

final class  SettingsChangeLanguageState extends SettingsState {
}