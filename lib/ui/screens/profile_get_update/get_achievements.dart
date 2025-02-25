import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/core/functions/animated_transition.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/ui/screens/profile_add_new/achievements.dart';
import 'package:toastification/toastification.dart';
import '../../../core/functions/translate.dart';
import '../../../logic/cubit/profile_get/about_me/about_me_cubit.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile_get/achievement_card.dart';

class GetAchievementsScreen extends StatefulWidget {
  const GetAchievementsScreen({super.key});

  @override
  State<GetAchievementsScreen> createState() =>
      _GetPersonalDetailsScreenState();
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
    return BlocConsumer<AboutMeCubit, AboutMeState>(
      buildWhen: (previous, current) =>
          current is AboutMeGetAchievementsLoadingState ||
          current is AboutMeGetAchievementsSuccessState ||
          current is AboutMeGetAchievementsErrorState ||
          current is AboutMeDeleteLoadingState,
      listener: (context, state) {
        if (state is AboutMeDeleteSuccessState) {
          showToast(context,
              title: translateLang(context, 'success'),
              desc: 'achievement is deleted successfully',
              type: ToastificationType.success);
          Navigator.of(context).pop();
        }
        if (state is AboutMeDeleteErrorState) {
          showToast(context,
              title: translateLang(context, 'error'),
              desc: 'achievement is not deleted yet !!!',
              type: ToastificationType.error);
          //  Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is AboutMeGetAchievementsLoadingState ||
            state is AboutMeDeleteLoadingState) {
          return const AnimatedLoadingWidget();
        }
        if (state is AboutMeGetAchievementsErrorState) {
          return FailureWidget(
              showImage: false,
              title:
                  '${translateLang(context, "error_get_achieves")}\n${state.message}',
              onTap: () {
                context.read<AboutMeCubit>().getAchievements();
              });
        }

        if (state is AboutMeGetAchievementsSuccessState) {
          return state.achievements.isEmpty
              ? const EmptyDataWidget(
                  message: "No achievements available Yet !!!",
                )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: state.achievements.length,
                    itemBuilder: (context, index) => Dismissible(
                      key: Key("$index"),
                      onDismissed: (direction) {
                        context.read<AboutMeCubit>().deleteSectionItem(
                            ACHIEVEMENTS, state.achievements[index].id!);
                      },
                      child: InkWell(
                          onTap: () {
                            animatedTransition(
                                context,
                                AchievementsSCreen(
                                  achievement: state.achievements[index],
                                ));
                          },
                          child: AchievementCard(
                              achievement: state.achievements[index])),
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 16.0,
                    ),
                  ),
                );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
