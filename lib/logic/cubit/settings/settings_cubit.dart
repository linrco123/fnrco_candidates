import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images_path.dart';
import '../../../core/classes/cache_helper.dart';
import '../../../core/functions/translate.dart';
import '../../../ui/widgets/custom_divider.dart';

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
    print('get value is ' + CacheHelper.getBiometricStatus().toString());
  }
  // bright mode = 1  , dark mode = 0;

  bool isBrightnessShown = false;
  int brightnessMode = CacheHelper.getBrightnessMode();
  void showBrightness() {
    isBrightnessShown = !isBrightnessShown;
    emit(ShowBrightnessModeSettingsState(status: isBrightnessShown));
  }

  void toggleBrightness(int status) {
    brightnessMode = status;
    print('========stsuatus brightness mode ========== $status');
    CacheHelper.storeBrightnessMode(brightnessMode);
    emit(ToggleBrightnessModeSettingsState(status: brightnessMode));
  }

  void showLanguageDialogue(context) {
    showCupertinoModalPopup(
      // constraints: BoxConstraints(maxHeight: ),
      context: context,
      builder: (context) => Container(
        height: 195.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius:
              BorderRadiusDirectional.vertical(top: Radius.circular(16.0)),
        ),
        child: SizedBox(
          height: 195.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    translateLang(context, 'language'),
                    style: TextStyle(
                        fontSize: 16.0,
                        color: AppColors.primary,
                        decoration: TextDecoration.none),
                  ),
                ),
                SizedBox(
                  height: 120.0,
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () {
                          CacheHelper.storeLang('ar');
                          emit(SettingsChangeLanguageState());
                          // Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              AppImages.arabic,
                              height: 40.0,
                              width: 40.0,
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              translateLang(
                                context,
                                'arabic',
                              ),
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColors.black,
                                  decoration: TextDecoration.none),
                            ),
                            const Spacer(),
                            CacheHelper.getLang() == 'ar'
                                ? SvgPicture.asset(
                                    AppImages.checked,
                                    height: 25.0,
                                    width: 25.0,
                                    color: AppColors.primary,
                                  )
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
                      CustomDivider(),
                      GestureDetector(
                        onTap: () {
                          CacheHelper.storeLang('en');
                          emit(SettingsChangeLanguageState());
                          //Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              AppImages.english,
                              height: 40.0,
                              width: 40.0,

                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              translateLang(
                                context,
                                'english',
                              ),
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColors.black,
                                  decoration: TextDecoration.none),
                            ),
                            const Spacer(),
                            CacheHelper.getLang() == 'en'
                                ? SvgPicture.asset(
                                    AppImages.checked,
                                    height: 25.0,
                                    width: 25.0,
                                   color: AppColors.primary,

                                  )
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //  InkWell(
                //   onTap: (){

                //   },
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Image.asset(AppImages.arabic , height: 30.0,width: 30.0,),
                //       const SizedBox(width: 20.0,),
                //       Text(translateLang(context, 'arabic')),

                //   ],),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
