import 'package:bloc/bloc.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  bool isBioMetricShown = false;
  bool isbiometricOperating = CacheHelper.getBiometricStatus();
  void showBiometric() {
    isBioMetricShown = !isBioMetricShown;
    emit(ShowBiometricSettingsState(status: isBioMetricShown));
  }

  void toggleBioMetric(bool status) {
    isbiometricOperating = status;
    print('storeBiometricStatus============ $status');
    CacheHelper.storeBiometricStatus(isbiometricOperating);
    emit(ToggleBiometricSettingsState(status: isbiometricOperating));
    print('get value is '+CacheHelper.getBiometricStatus().toString());
 
  }
  // bright mode = 1  , dark mode = 0;

    bool isBrightnessShown = false;
  int brightnessMode = CacheHelper.getBrightnessMode();
  void showBrightness() {
    isBrightnessShown = !isBrightnessShown;
    emit(ShowBiometricSettingsState(status: isBioMetricShown));
  }

  void toggleBrightness(int status) {
    brightnessMode = status;
    CacheHelper.storeBrightnessMode(brightnessMode);
    emit(ToggleBiometricSettingsState(status: isbiometricOperating));
 
  }
}
