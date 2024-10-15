import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/presentation/screens/home_page/home_tap.dart';
import 'package:fnrco_candidates/presentation/screens/settings.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());

  static HomePageCubit instance(context) => BlocProvider.of(context);
  var searchController = TextEditingController();
  int selectedIndex = 0;

  final navBarItems = [
    SalomonBottomBarItem(
      icon: const Icon(Icons.home),
      title: const Text("Home"),
      selectedColor: AppColors.primary,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.favorite_border),
      title: const Text("Favorites"),
      selectedColor: Colors.pink,
    ),
    SalomonBottomBarItem(
      icon: Icon(Icons.medical_information_outlined),
      title: const Text("Medical Declare"),
      selectedColor: Colors.orange,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.settings),
      title: const Text("settings"),
      selectedColor: AppColors.purple,
    ),
  ];
  final taps = [
    const HomeTapScreen(),
    const SizedBox(),
    const SizedBox(),
    const SettingsScreen()
  ];

  void changeState(int index) {
    selectedIndex = index;
    emit(HomePageChangeState());
  }

  void searchAJob() {
    if (searchController.text.isNotEmpty) {
    } else {
      print('Please  , Enter a job you are searching for');
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
}
