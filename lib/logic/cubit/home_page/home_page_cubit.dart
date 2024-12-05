import 'package:fancy_bottom_navigation_plus/fancy_bottom_navigation_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/ui/screens/category_details.dart';
import 'package:fnrco_candidates/ui/screens/home_page/home_tap.dart';
import 'package:fnrco_candidates/ui/screens/settings.dart';
part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());

  static HomePageCubit instance(context) => BlocProvider.of(context);
  var searchController = TextEditingController();
  int selectedIndex = 0;

  final navBarItems = [
    TabData(
      icon:  Icon(Icons.home ,),
      title: "Home",
     // selectedColor: AppColors.primary,

    ),
    TabData(
      icon:  Icon(Icons.favorite_border),
      title: "Favorites",
     // selectedColor: AppColors.primary,
    ),
    TabData(
      icon: Icon(Icons.medical_information_outlined),
      title: "Medical Declare",
      ///selectedColor: AppColors.primary,
    ),
    TabData(
      icon: const Icon(Icons.settings),
      title: "settings",
      //selectedColor: AppColors.primary,
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

  void logout(context) {
    emit(LogoutLoadingState());
    CacheHelper.removeAll().then((value) {
   emit(LogoutSuccessState());
    }).catchError((error) {
      emit(LogoutFailureState(error: error));
    });
  }
}
