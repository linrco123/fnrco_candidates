import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/core/localizations/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColors.primary.withOpacity(0.1),
      //padding: const EdgeInsets.all(15.0),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 9,
            decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(20.0),
                    bottomStart: Radius.circular(20.0))),
          ),
          Padding(
            padding:   EdgeInsets.only(top:MediaQuery.of(context).size.height / 9+20),
            child: ListView(
              children: [
                _addSettingItem(context, AppImages.TRANSLATE,
                    AppLocalizations.of(context)!.translate('language'), () {}),
                _divider(),
            
                // Account Settings field
                _addSettingItem(context, AppImages.FAVORITE,
                    AppLocalizations.of(context)!.translate('favorite'), () {}),
                _divider(),
                _addSettingItem(
                    context,
                    AppImages.FILE_FILLED,
                    AppLocalizations.of(context)!.translate('terms_conditions'),
                    () {}),
            
                _divider(),
            
                // Blog field
                _addSettingItem(context, AppImages.FILE_FILLED,
                    AppLocalizations.of(context)!.translate('blogs'), () {}),
                _divider(),
            
                // Rate App field
                _addSettingItem(context, AppImages.RATE,
                    AppLocalizations.of(context)!.translate('rate'), () {}),
                _divider(),
           
                // About Us field
                _addSettingItem(
                    context,
                    AppImages.FILE,
                    AppLocalizations.of(context)!.translate('about_candidates'),
                    () {}),
                _divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _addSettingItem(
      BuildContext context, String image, String text, void Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15),
            child: Row(
              children: [
                SvgPicture.asset(
                  image,
                  color: AppColors.primary,
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
                    Icons.arrow_forward_ios,
                    color: AppColors.primary,
                    size: 15,
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
