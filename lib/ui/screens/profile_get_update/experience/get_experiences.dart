import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/core/functions/animated_transition.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/ui/screens/profile_add_new/work_experience.dart';
import 'package:toastification/toastification.dart';
import '../../../../core/functions/translate.dart';
import '../../../../logic/cubit/profile_get/about_me/about_me_cubit.dart';
import '../../../widgets/empty_data_widget.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/profile_get/experience_card.dart';

class GetExperiencesScreen extends StatefulWidget {
  const GetExperiencesScreen({super.key});

  @override
  State<GetExperiencesScreen> createState() => _GetPersonalDetailsScreenState();
}

class _GetPersonalDetailsScreenState extends State<GetExperiencesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AboutMeCubit>().getExperiences();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AboutMeCubit, AboutMeState>(
      buildWhen: (previous, current) =>
          current is AboutMeGetExperiencesLoadingState ||
          current is AboutMeGetExperiencesSuccessState ||
          current is AboutMeGetExperiencesErrorState ||
          current is AboutMeDeleteLoadingState,
      listener: (context, state) {
        if (state is AboutMeDeleteSuccessState ) {
          showToast(context,
              title: translateLang(context, 'success'),
              desc: 'experience is deleted successfully',
              type: ToastificationType.success);
          Navigator.of(context).pop();
        }
        if (state is AboutMeDeleteErrorState) {
          showToast(context,
              title: translateLang(context, 'error'),
              desc: 'experience is not deleted yet !!!',
              type: ToastificationType.error);
          //  Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is AboutMeGetExperiencesLoadingState ||
            state is AboutMeDeleteLoadingState) {
          return const AnimatedLoadingWidget();
        }
        if (state is AboutMeGetExperiencesErrorState) {
          return FailureWidget(
              showImage: false,
              title: translateLang(context, "error_get_experience"),
              onTap: () {
                context.read<AboutMeCubit>().getExperiences();
              });
        }
        if (state is AboutMeGetExperiencesSuccessState) {
          return state.experiences.isEmpty
              ? const EmptyDataWidget(
                  message: "No experiences available Yet !!!",
                )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: state.experiences.length,
                    itemBuilder: (context, index) => Dismissible(
                      key: Key("$index"),
                      onDismissed: (direction) {
                        context.read<AboutMeCubit>().deleteSectionItem(
                            EXPERIENCES, state.experiences[index].id!);
                      },
                      child: InkWell(
                          onTap: () {
                            animatedTransition(
                                context,
                                ExperienceScreen(
                                  experience: state.experiences[index],
                                ));
                          },
                          child: ExperienceCard(
                              experience: state.experiences[index])),
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
