import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fnrco_candidates/logic/cubit/home_page/home_page_cubit.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/core/localizations/app_localizations.dart';
import 'package:fnrco_candidates/ui/screens/category_details.dart';
import 'package:fnrco_candidates/ui/screens/home_page/home_tap.dart';
import 'package:fnrco_candidates/ui/screens/notifications.dart';
import 'package:fnrco_candidates/ui/screens/personal_data/profile.dart';
import 'package:fnrco_candidates/ui/screens/settings.dart';
import 'package:fnrco_candidates/ui/screens/test/test.dart';
import 'package:fnrco_candidates/ui/screens/unregistered_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../constants/app_colors.dart';
import '../medical_declare.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(),
      child: BlocConsumer<HomePageCubit, HomePageState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomePageCubit homePageCubit = BlocProvider.of<HomePageCubit>(context);
          return Scaffold(
            appBar: _buildAppBar(context, homePageCubit.selectedIndex),
            drawer: homePageCubit.selectedIndex != 0
                ? null
                : CacheHelper.userToken == null
                    ? SizedBox.shrink()
                    : Drawer(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            Material(
                              color: AppColors.primary.withOpacity(0.5),
                              child: InkWell(
                                onTap: () {
                                  /// Close Navigation drawer before
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileScreen()),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).padding.top,
                                      bottom: 24),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 55.0,
                                        backgroundColor: AppColors.white,
                                        child: CircleAvatar(
                                          radius: 52,
                                          backgroundImage:
                                              CacheHelper.getImage() == null
                                                  ? AssetImage(AppImages.User)
                                                  : FileImage(File(
                                                      CacheHelper.getImage()!)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        //'Muhammed Nady',
                                        CacheHelper.getName()!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge!
                                            .copyWith(color: AppColors.white),
                                      ),
                                      Text(
                                        CacheHelper.getEmail() ??
                                            '.....@gmail.com',
                                        //CacheHelper.sharedPreferences.getString('user_email')!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(color: AppColors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppPagesNames.PROFILE);
                              },
                              leading: SvgPicture.asset(
                                AppImages.PERSON,
                                // ignore: deprecated_member_use
                                color: AppColors.primary,
                              ),
                              title: Text(
                                AppLocalizations.of(context)!
                                    .translate('profile'),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context)
                                    .pushNamed(AppPagesNames.JOB_OFFER);
                              },
                              leading: SvgPicture.asset(
                                AppImages.FILE,
                                // ignore: deprecated_member_use
                                color: AppColors.primary,
                              ),
                              title: Text(
                                AppLocalizations.of(context)!
                                    .translate('job_offer'),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppPagesNames.HEALTH_CARE);
                              },
                              leading: SvgPicture.asset(
                                AppImages.HEALTH_CARE,
                                // ignore: deprecated_member_use
                                color: AppColors.primary,
                              ),
                              title: Text(
                                AppLocalizations.of(context)!
                                    .translate("health_declare"),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppPagesNames.RESUME);
                              },
                              leading: SvgPicture.asset(
                                AppImages.RESUME,
                                // ignore: deprecated_member_use
                                color: AppColors.primary,
                              ),
                              title: Text(
                                AppLocalizations.of(context)!
                                    .translate("resume"),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NotificationsScreen(),
                                ));
                              },
                              leading: SvgPicture.asset(
                                AppImages.NOTIFICATIONS,
                                // ignore: deprecated_member_use
                                color: AppColors.primary,
                              ),
                              title: Text(
                                AppLocalizations.of(context)!
                                    .translate("job_alert"),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            ListTile(
                              onTap: () {},
                              leading: SvgPicture.asset(
                                AppImages.SAVED,
                                // ignore: deprecated_member_use
                                color: AppColors.primary,
                              ),
                              title: Text(
                                AppLocalizations.of(context)!
                                    .translate("Saved Jobs"),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AppPagesNames.AUTH);
                              },
                              leading: SvgPicture.asset(
                                AppImages.LOGOUT,
                                // ignore: deprecated_member_use
                                color: AppColors.primary,
                              ),
                              title: Text(
                                AppLocalizations.of(context)!
                                    .translate("logout"),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => TestScreenh(),
                                ));
                              },
                              leading: SvgPicture.asset(
                                AppImages.CHECKED,
                                // ignore: deprecated_member_use
                                color: AppColors.primary,
                              ),
                              title: Text(
                                'Testing',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
            body: _buildBody(context, homePageCubit.selectedIndex),
            bottomNavigationBar: SalomonBottomBar(
                currentIndex: homePageCubit.selectedIndex,
                //selectedItemColor: const Color(0xff6200ee),
                unselectedItemColor: const Color(0xff757575),
                onTap: (index) {
                  homePageCubit.changeState(index);
                },
                items: homePageCubit.navBarItems),
          );
        },
      ),
    );
  }

  _buildAppBar(context, int index) {
    switch (index) {
      case 0:
        return AppBar(
          title: Text(
            translateLang(context, 'home_page'),
            style:
                TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppColors.primary,
          centerTitle: true,
          leading: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: AppColors.white,
                )),
          ),
        );
      case 1:
        return AppBar(
          title: Text(
            translateLang(context, 'favorites'),
            style:
                TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppColors.primary,
          centerTitle: true,
        );
      case 2:
        return AppBar(
          title: Text(
            translateLang(context, 'medical_declare'),
            style:
                TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppColors.primary,
          centerTitle: true,
        );
      case 3:
        return AppBar(
          title: Text(
            translateLang(context, 'settings'),
            style:
                TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: AppColors.primary,
          centerTitle: true,
        );
    }
  }

  _buildBody(context, int index) {
    switch (index) {
      case 0:
        return CacheHelper.userToken == null
            ? const UnregisteredScreen()
            : HomeTapScreen();
      case 1:
        return const CategoryDetailsScreen();
      case 2:
        return const MedicalDeclaration();
      case 3:
        return const SettingsScreen();
    }
  }
}
