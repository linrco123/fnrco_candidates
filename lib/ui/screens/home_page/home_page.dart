import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fnrco_candidates/ui/screens/medical_declaration/medical_declaration_apps.dart';
import '../../../core/functions/show_toast.dart';
import '../../../data/api_provider/home/home_tap_provider.dart';
import '../../../logic/cubit/home_page/home_page_cubit.dart';
import '../../../constants/app_images_path.dart';
import '../../../constants/app_pages_names.dart';
import '../../../core/classes/cache_helper.dart';
import '../../../core/functions/translate.dart';
import '../../../core/localizations/app_localizations.dart';
import '../category_details.dart';
import 'home_tap.dart';
import '../settings.dart';
import '../unregistered_screen.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:toastification/toastification.dart';
import '../../../constants/app_colors.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(HomePageProvider())
        ..getJobs()
        ..getAppliedJobs(),
      child: BlocConsumer<HomePageCubit, HomePageState>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(AppPagesNames.WELCOME, (p) => false);
            showToast(context,
                title: translateLang(context, 'success'),
                desc: translateLang(context, "msg_logout_success"),
                type: ToastificationType.success);
          }
          if (state is LogoutFailureState) {
            showToast(context,
                title: translateLang(context, 'error'),
                desc: translateLang(context, "msg_request_failure"),
                type: ToastificationType.success);
          }
        },
        builder: (context, state) {
          HomePageCubit homePageCubit = BlocProvider.of<HomePageCubit>(context);
          return Scaffold(
            appBar: _buildAppBar(context, homePageCubit.selectedIndex),
            drawer: homePageCubit.selectedIndex != 0
                ? null
                : CacheHelper.userToken == null
                    ? null
                    : Drawer(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            Material(
                              color: AppColors.primary,
                              child: InkWell(
                                onTap: () {
                                  /// Close Navigation drawer before
                                  // Navigator.pop(context);
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => ProfileScreen()),
                                  // );
                                  Navigator.of(context)
                                      .popAndPushNamed(AppPagesNames.PROFILE);
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
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              CacheHelper.getName() ??
                                                  translateLang(
                                                      context, "guest"),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineLarge!
                                                  .copyWith(
                                                      color: AppColors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              CacheHelper.getEmail() ??
                                                  '.....@gmail.com',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .copyWith(
                                                      color: AppColors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: AppColors.white,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // ListTile(
                                    //   onTap: () {
                                    //     Navigator.of(context)
                                    //         .push(MaterialPageRoute(
                                    //       builder: (context) => TestScreen(),
                                    //     ));
                                    //   },
                                    //   leading: Padding(
                                    //     padding:
                                    //         const EdgeInsets.only(left: 5.0),
                                    //     child: Icon(Icons.work_sharp)
                                    //   ),
                                    //   title: Text(
                                    //     'Test',
                                    //     style: Theme.of(context)
                                    //         .textTheme
                                    //         .titleSmall,
                                    //   ),
                                    // ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).popAndPushNamed(
                                            AppPagesNames.PROFILE);
                                      },
                                      leading: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: SvgPicture.asset(
                                          AppImages.PERSON,
                                          width: 27.0, height: 27.0,
                                          // ignore: deprecated_member_use
                                          color: AppColors.black,
                                        ),
                                      ),
                                      title: Text(
                                        AppLocalizations.of(context)!
                                            .translate('profile'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).popAndPushNamed(
                                            AppPagesNames.JOB_OFFER,
                                            arguments: {'data': "Muhammed"});
                                      },
                                      leading: SvgPicture.asset(
                                        AppImages.offer,
                                        width: 27.0, height: 27.0,
                                        // ignore: deprecated_member_use
                                        color: AppColors.black,
                                      ),
                                      title: Text(
                                        AppLocalizations.of(context)!
                                            .translate('job_offer'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).popAndPushNamed(
                                            AppPagesNames.JOB_CONTRACTS);
                                      },
                                      leading: SvgPicture.asset(
                                        AppImages.contract,
                                        width: 27.0, height: 27.0,
                                        // ignore: deprecated_member_use
                                        color: AppColors.black,
                                      ),
                                      title: Text(
                                        translateLang(context, "job_contract"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).popAndPushNamed(
                                            AppPagesNames.VISA_APPROVAL);
                                      },
                                      leading: SvgPicture.asset(
                                        AppImages.visa,
                                        width: 27.0, height: 27.0,
                                        // ignore: deprecated_member_use
                                        color: AppColors.black,
                                      ),
                                      title: Text(
                                        translateLang(context, "visa_approval"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).popAndPushNamed(
                                            AppPagesNames.MEDICAL_DECLARATION);
                                      },
                                      leading: SvgPicture.asset(
                                        AppImages.HEALTH_CARE,
                                        // ignore: deprecated_member_use
                                        width: 27.0, height: 27.0,
                                        color: AppColors.black,
                                      ),
                                      title: Text(
                                        AppLocalizations.of(context)!
                                            .translate("health_declare"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    //local-process
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).popAndPushNamed(
                                            AppPagesNames.LOCAL_PROCESS);
                                      },
                                      leading: SvgPicture.asset(
                                        AppImages.local_process,
                                        width: 27.0, height: 27.0,
                                        // ignore: deprecated_member_use
                                        color: AppColors.black,
                                      ),
                                      title: Text(
                                        AppLocalizations.of(context)!
                                            .translate("local_process"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).popAndPushNamed(
                                            AppPagesNames.JOINING_DATE);
                                      },
                                      leading: Icon(
                                        CupertinoIcons.calendar,
                                        size: 27.0,
                                      ),
                                      title: Text(
                                        translateLang(context, "joining_date"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).popAndPushNamed(
                                            AppPagesNames.AIR_TICKET);
                                      },
                                      leading: SvgPicture.asset(
                                        AppImages.air_ticket,
                                        width: 27.0, height: 27.0,
                                        // ignore: deprecated_member_use
                                        color: AppColors.black,
                                      ),
                                      title: Text(
                                        translateLang(context, "air_ticket"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).popAndPushNamed(
                                            AppPagesNames.RESUME);
                                      },
                                      leading: SvgPicture.asset(
                                        AppImages.RESUME,
                                        width: 27.0, height: 27.0,
                                        // ignore: deprecated_member_use
                                        color: AppColors.black,
                                      ),
                                      title: Text(
                                        AppLocalizations.of(context)!
                                            .translate("resume"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).popAndPushNamed(
                                            AppPagesNames.NOTIFICATION);
                                        // Navigator.of(context).push(MaterialPageRoute(
                                        //   builder: (context) => NotificationsScreen(),
                                        // ));
                                      },
                                      leading: SvgPicture.asset(
                                        AppImages.NOTIFICATIONS,
                                        width: 27.0, height: 27.0,
                                        // ignore: deprecated_member_use
                                        color: AppColors.black,
                                      ),
                                      title: Text(
                                        AppLocalizations.of(context)!
                                            .translate("job_alert"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    // ListTile(
                                    //   onTap: () {},
                                    //   leading: SvgPicture.asset(
                                    //     AppImages.SAVED,
                                    //     color: AppColors.primary,
                                    //   ),
                                    //   title: Text(
                                    //     AppLocalizations.of(context)!
                                    //         .translate("saved_jobs"),
                                    //     style:
                                    //         Theme.of(context).textTheme.displayMedium,
                                    //   ),
                                    // ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).popAndPushNamed(
                                            AppPagesNames.TICKETS);
                                      },
                                      leading: SvgPicture.asset(
                                        AppImages.ticket,
                                        // ignore: deprecated_member_use
                                        color: AppColors.black,
                                        width: 27.0, height: 27.0,
                                      ),
                                      title: Text(
                                        AppLocalizations.of(context)!
                                            .translate("tickets"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).popAndPushNamed(
                                            AppPagesNames.SURVIES);
                                      },
                                      leading: SvgPicture.asset(
                                        AppImages.survey,
                                        width: 27.0, height: 27.0,
                                        // ignore: deprecated_member_use
                                        color: AppColors.black,
                                      ),
                                      title: Text(
                                        AppLocalizations.of(context)!
                                            .translate("surveys"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).popAndPushNamed(
                                            AppPagesNames.POLLS);
                                      },
                                      leading: SvgPicture.asset(
                                        AppImages.poll,
                                        width: 27.0, height: 27.0,
                                        // ignore: deprecated_member_use
                                        color: AppColors.black,
                                      ),
                                      title: Text(
                                        AppLocalizations.of(context)!
                                            .translate("polls"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).popAndPushNamed(
                                            AppPagesNames.FAQS);
                                      },
                                      leading: SvgPicture.asset(
                                        AppImages.faqs,
                                        color: AppColors.black,
                                        width: 27.0,
                                        height: 27.0,
                                      ),
                                      title: Text(
                                        "FAQs",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).popAndPushNamed(
                                            AppPagesNames.TUTORIAL);
                                      },
                                      leading: SvgPicture.asset(
                                        AppImages.tutorial,
                                        color: AppColors.black,
                                        width: 27.0,
                                        height: 27.0,
                                      ),
                                      title: Text(
                                        translateLang(context, "tutorials"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).popAndPushNamed(
                                            AppPagesNames.ANNOUNCEMENT);
                                      },
                                      leading: SvgPicture.asset(
                                        AppImages.announcement,
                                        color: AppColors.black,
                                        width: 27.0,
                                        height: 27.0,
                                      ),
                                      title: Text(
                                        translateLang(
                                            context, "annnouncements"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context).popAndPushNamed(
                                            AppPagesNames.CONTENTS);
                                      },
                                      leading: SvgPicture.asset(
                                        AppImages.content,
                                        color: AppColors.black,
                                        height: 30.0,
                                        width: 30.0,
                                      ),
                                      title: Text(
                                        translateLang(context, "contents"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),

                                    ListTile(
                                      onTap: () {
                                        homePageCubit.logout(context);
                                      },
                                      leading: SvgPicture.asset(
                                        AppImages.LOGOUT,
                                        // ignore: deprecated_member_use
                                        color: AppColors.black,
                                      ),
                                      title: Text(
                                        AppLocalizations.of(context)!
                                            .translate("logout"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
            body: _buildBody(context, homePageCubit.selectedIndex),
            bottomNavigationBar: StylishBottomBar(
              borderRadius: BorderRadius.circular(16.0),
              backgroundColor: AppColors.white,
              option: AnimatedBarOptions(
                iconSize: 27,
                barAnimation: BarAnimation.fade,
                iconStyle: IconStyle.animated,
                opacity: 0.9,
              ),
              items: homePageCubit.navBarItems,
              fabLocation: StylishBarFabLocation.center,
              hasNotch: true,
              currentIndex: homePageCubit.selectedIndex,
              onTap: (index) => homePageCubit.changeState(index),
            ),
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
            builder: (context) => CacheHelper.userToken == null
                ? SizedBox.shrink()
                : IconButton(
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
        return const MedicalDeclarationAppsScreen();
      case 3:
        return const SettingsScreen();
    }
  }
}
