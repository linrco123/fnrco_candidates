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
}
