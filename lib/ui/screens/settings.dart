import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/app_pages_names.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images_path.dart';
import '../../core/localizations/app_localizations.dart';
import '../../logic/cubit/settings/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColors.white,
      //padding: const EdgeInsets.all(15.0),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 14,
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(20.0),
                    bottomStart: Radius.circular(20.0))),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 9 + 20),
            child: BlocConsumer<SettingsCubit, SettingsState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                var settingsCubit = BlocProvider.of<SettingsCubit>(context);
                return ListView(
                  children: [
                    _addSettingItem(
                        context: context,
                        image: AppImages.TRANSLATE,
                        text:
                            AppLocalizations.of(context)!.translate('language'),
                        onTap: () {
                          //////language change
                          settingsCubit.showLanguageDialogue(context);
                        }),
                    _divider(),

                    // Account Settings field
                    _addSettingItem(
                        context: context,
                        image: AppImages.FAVORITE,
                        text:
                            AppLocalizations.of(context)!.translate('favorite'),
                        onTap: () {}),
                    _divider(),
                    _addSettingItem(
                        context: context,
                        image: AppImages.FILE_FILLED,
                        text: AppLocalizations.of(context)!
                            .translate('terms_conditions'),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppPagesNames.TERMS_CONDITIONS);
                        }),

                    _divider(),

                    // Blog field
                    _addSettingItem(
                        context: context,
                        image: AppImages.FILE_FILLED,
                        text: AppLocalizations.of(context)!.translate('blogs'),
                        onTap: () {}),
                    _divider(),

                    // Rate App field
                    _addSettingItem(
                        context: context,
                        image: AppImages.RATE,
                        text: AppLocalizations.of(context)!.translate('rate'),
                        onTap: () {}),
                    _divider(),

                    // About Us field
                    _addSettingItem(
                        context: context,
                        image: AppImages.FILE_FILLED,
                        text: AppLocalizations.of(context)!
                            .translate('about_candidates'),
                        onTap: () {}),
                    _divider(),

                    _addSettingItem(
                        context: context,
                        isSVG: false,
                        image: AppImages.fingerPrint1,
                        text: AppLocalizations.of(context)!
                            .translate('login_biometric'),
                        icon: settingsCubit.isBioMetricShown
                            ? Icons.keyboard_arrow_down
                            : Icons.arrow_forward_ios,
                        size: settingsCubit.isBioMetricShown ? 25 : 15,
                        onTap: () {
                          settingsCubit.showBiometric();
                        }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Visibility(
                        visible: settingsCubit.isBioMetricShown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Switch(
                                trackOutlineColor:
                                    WidgetStatePropertyAll(AppColors.primary),
                                value: settingsCubit.isbiometricOperating,
                                onChanged: (value) =>
                                    settingsCubit.toggleBioMetric(value)),
                            Text(
                              settingsCubit.isbiometricOperating ? 'ON' : 'OFF',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                      color: settingsCubit.isbiometricOperating
                                          ? AppColors.primary
                                          : AppColors.black),
                            )
                          ],
                        )),
                    _divider(),

                    // _addSettingItem(
                    //     context: context,
                    //     isSVG: false,
                    //     image: AppImages.brightness,
                    //     text: AppLocalizations.of(context)!
                    //         .translate('brightness_mode'),
                    //     icon: settingsCubit.isBrightnessShown
                    //         ? Icons.keyboard_arrow_down
                    //         : Icons.arrow_forward_ios,
                    //     size: settingsCubit.isBrightnessShown ? 25 : 15,
                    //     onTap: () {
                    //       settingsCubit.showBrightness();
                    //     }),
                    // const SizedBox(
                    //   height: 10.0,
                    // ),
                    // Visibility(
                    //     visible: settingsCubit.isBrightnessShown,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: [
                    //         Switch(
                    //             activeColor: AppColors.black,
                    //             inactiveThumbColor: AppColors.white,
                    //             trackOutlineColor:
                    //                 WidgetStatePropertyAll(AppColors.primary),
                    //             value: settingsCubit.brightnessMode == DARK_MODE
                    //                 ? true
                    //                 : false,
                    //             onChanged: (value) =>
                    //                 settingsCubit.toggleBrightness(
                    //                     value ? DARK_MODE : LIGTH_MODE)),
                    //         Text(
                    //           settingsCubit.brightnessMode == LIGTH_MODE
                    //               ? 'Bright Mode'
                    //               : 'Dark Mode',
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .headlineLarge!
                    //               .copyWith(
                    //                   color: settingsCubit.brightnessMode ==
                    //                           DARK_MODE
                    //                       ? AppColors.black
                    //                       : AppColors.white),
                    //         )
                    //       ],
                    //     )),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _addSettingItem(
      {required BuildContext context,
      bool isSVG = true,
      required String image,
      required String text,
      IconData icon = Icons.arrow_forward_ios,
      double size = 15.0,
      required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15),
            child: Row(
              children: [
                isSVG
                    ? SvgPicture.asset(
                        image,
                        color: AppColors.primary,
                      )
                    : Image.asset(
                        image,
                        color: AppColors.primary,
                        height: 25.0,
                        width: 25.0,
                      ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  text,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, right: 30),
                  child: Icon(
                    icon,
                    color: AppColors.primary,
                    size: size,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _divider() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
      child: Divider(
        color: AppColors.primary,
        thickness: 0.1,
      ),
    );
  }
}
