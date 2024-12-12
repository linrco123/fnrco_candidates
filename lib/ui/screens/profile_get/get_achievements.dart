import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/logic/cubit/profile_get/about_me/about_me_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/empty_data_widget.dart';
import 'package:fnrco_candidates/ui/widgets/error_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/achievement_card.dart';

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
          return FailureWidget(
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
                    height: 10.0,
                  ),
                ),
              );
       }
       return SizedBox.shrink();
      },
    );
  }
}