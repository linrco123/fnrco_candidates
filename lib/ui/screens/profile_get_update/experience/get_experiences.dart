import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/ui/screens/profile_add_new/work_experience.dart';
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
    return BlocBuilder<AboutMeCubit, AboutMeState>(
      builder: (context, state) {
        if (state is AboutMeGetExperiencesLoadingState) {
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
                    itemBuilder: (context, index) => InkWell(
                        onTap: () {
                         
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ExperienceScreen(
                              experience: state.experiences[index],
                            ),
                          ));
                        },
                        child: ExperienceCard(
                            experience: state.experiences[index])),
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
