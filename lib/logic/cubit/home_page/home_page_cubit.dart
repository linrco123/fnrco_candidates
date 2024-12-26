// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/data/models/home/jobs_model.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';

import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/home/home_tap_provider.dart';
import 'package:fnrco_candidates/ui/screens/category_details.dart';
import 'package:fnrco_candidates/ui/screens/home_page/home_tap.dart';
import 'package:fnrco_candidates/ui/screens/settings.dart';
import 'package:fnrco_candidates/data/models/profile_get/get_jobs_model.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageProvider homePageProvider;
  HomePageCubit(
    this.homePageProvider,
  ) : super(HomePageInitial());

  static HomePageCubit instance(context) => BlocProvider.of(context);
  var searchController = TextEditingController();
  int selectedIndex = 0;

  final navBarItems = [
    BottomBarItem(
      selectedColor: AppColors.primary,
      unSelectedColor: AppColors.grey,
      icon: Icon(
        Icons.home,
      ),
      title: Text("Home"),
      //backgroundColor: Colors.red,
      selectedIcon: const Icon(Icons.read_more),
    ),
    BottomBarItem(
      selectedColor: AppColors.primary,
      unSelectedColor: AppColors.grey,

      icon: Icon(Icons.favorite_border),
      title: Text("Favorites"),
      // backgroundColor: Colors.orange,
    ),
    BottomBarItem(
      selectedColor: AppColors.primary,
      unSelectedColor: AppColors.grey,

      icon: Icon(Icons.medical_information_outlined),
      title: Text("Medical Declare"),
      // backgroundColor: Colors.purple,
    ),
    BottomBarItem(
      selectedColor: AppColors.primary,
      unSelectedColor: AppColors.grey,

      icon: const Icon(Icons.settings),
      title: Text("settings"),
      // backgroundColor: Colors.purple,
    ),
  ];

  final taps = [
    const HomeTapScreen(),
    const CategoryDetailsScreen(),
    const SizedBox(),
    const SettingsScreen()
  ];

  void changeState(int index) {
    selectedIndex = index;
    emit(HomePageChangeState());
  }

  var searchedJobs = List<Job>.empty(growable: true);

  void searchAJob(String value) {
    if (value.isNotEmpty) {
      searchedJobs = jobs
          .where((job) => job.position!
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
      emit(GetJobsSuccessState(jobs: searchedJobs));
    } else {
      searchedJobs = [];
      emit(GetJobsSuccessState(jobs: searchedJobs));
    }
  }

  String greetings(context) {
    DateTime greeting = DateTime.now();
    if (greeting.isAfter(desiredTime(hour: 16, minutes: 59)) ||
        // greeting.isBefore(desiredTime(hour: 23, minutes: 59)) ||
        greeting.isAtSameMomentAs(desiredTime(hour: 23, minutes: 59))) {
      return translateLang(context, 'good_evening');
    } else if (greeting.isBefore(desiredTime(hour: 11, minutes: 59)) ||
        greeting.isAtSameMomentAs(desiredTime(hour: 11, minutes: 59))) {
      return translateLang(context, 'good_morning');
    } else if (greeting.isAfter(desiredTime(hour: 11, minutes: 59)) ||
        greeting.isBefore(desiredTime(hour: 16, minutes: 59)) ||
        greeting.isAtSameMomentAs(desiredTime(hour: 16, minutes: 59))) {
      return translateLang(context, 'good_afternoon');
    } else {
      return translateLang(context, 'good_morning');
    }
  }

  DateTime desiredTime({int hour = 1, int minutes = 1}) {
    return DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        hour,
        minutes,
        DateTime.now().second,
        DateTime.now().millisecond,
        DateTime.now().microsecond);
  }

  void logout(context) {
    emit(LogoutLoadingState());
    CacheHelper.removeAll().then((value) {
      emit(LogoutSuccessState());
    }).catchError((error) {
      emit(LogoutFailureState(error: error));
    });
  }

  var jobs = List<Job>.empty(growable: true);

  getJobs() {
    emit(GetJobsLoadingState());
    homePageProvider.getJobs().then((value) {
      jobs.addAll(value.jobs!);
      emit(GetJobsSuccessState(jobs: value.jobs!));
    }).catchError((error) {
      emit(GetJobsFailureState(message: error.failure.message));
    });
  }

  var appliedJobs = List<GetJob>.empty(growable: true);
  getAppliedJobs() {
   // emit(HomePageGetAppliedJobsLoadingState());
    homePageProvider.getAppliedJobs().then((value) {
      appliedJobs.addAll(value.data!);
    ///  emit(HomePageGetAppliedJobsSuccessState());
    }).catchError((error) {
      // emit(HomePageGetAppliedJobsFailureState(
      //     message: error.message.toString()));
    });
  }
}
