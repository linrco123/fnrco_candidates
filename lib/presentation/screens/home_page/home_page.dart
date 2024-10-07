import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/business_logic/cubit/home_page/home_page_cubit.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../constants/app_colors.dart';

class HomePageScreen extends StatelessWidget {
   const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(),
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          HomePageCubit homePageCubit  = BlocProvider.of<HomePageCubit>(context);
          return Scaffold(
              appBar: AppBar(
                title:  Text('Home Screen' , style: TextStyle(color: AppColors.white , fontWeight: FontWeight.bold),),
                backgroundColor: AppColors.primary,
                centerTitle: true,
              ),
              body: homePageCubit.taps[homePageCubit.selectedIndex],
              bottomNavigationBar: SalomonBottomBar(
                  currentIndex:  homePageCubit.selectedIndex,
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
  

}

