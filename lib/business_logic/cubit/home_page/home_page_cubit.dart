import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/presentation/screens/home_page/home_tap.dart';
import 'package:fnrco_candidates/presentation/screens/profile.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());

  static HomePageCubit instance(context) => BlocProvider.of(context);

  int selectedIndex = 0;

  final navBarItems = [
    SalomonBottomBarItem(
      icon: const Icon(Icons.home),
      title: const Text("Home"),
      selectedColor: AppColors.primary,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.favorite_border),
      title: const Text("Likes"),
      selectedColor: Colors.pink,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.search),
      title: const Text("Search"),
      selectedColor: Colors.orange,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.person),
      title: const Text("Profile"),
      selectedColor: AppColors.purple,
    ),
  ];
  final taps = [
    const HomeTapScreen(),
    const SizedBox(),
    const SizedBox(),
    const ProfileScreen()
  ];

  void changeState(int index) {
    selectedIndex = index;
    emit(HomePageChangeState());
  }
}
