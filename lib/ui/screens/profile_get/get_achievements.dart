import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/functions/translate.dart';
import '../../../logic/cubit/profile_get/about_me/about_me_cubit.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile_get/achievement_card.dart';

class GetAchievementsScreen extends StatefulWidget {
  const GetAchievementsScreen({super.key});

  @override
  State<GetAchievementsScreen> createState() => _GetPersonalDetailsScreenState();
}

class _GetPersonalDetailsScreenState extends State<GetAchievementsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AboutMeCubit>().getAchievements();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AboutMeCubit, AboutMeState>(
      builder: (context, state) {
        if (state is AboutMeGetAchievementsLoadingState) {
          return AnimatedLoadingWidget();
        }
        if (state is AboutMeGetAchievementsErrorState) {
          return FailureWidget(showImage: false,
              title: translateLang(context, "error_get_achieves"),
              onTap: () {
                context.read<AboutMeCubit>().getAchievements();
              });
        }
       
       if(state is AboutMeGetAchievementsSuccessState){
         return state .achievements.isEmpty
            ? EmptyDataWidget()
            : Container(
                height: double.infinity,
                width: double.infinity,
                child: ListView.separated(
                  itemCount: state.achievements.length,
                  itemBuilder: (context, index) =>
                      AchievementCard(achievement: state.achievements[index]),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 16.0,
                  ),
                ),
              );
       }
       return SizedBox.shrink();
      },
    );
  }
}