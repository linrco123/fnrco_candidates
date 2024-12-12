import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/logic/cubit/profile_get/about_me/about_me_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/empty_data_widget.dart';
import 'package:fnrco_candidates/ui/widgets/error_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/experience_card.dart';

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
          return AnimatedLoadingWidget();
        }
        if (state is AboutMeGetExperiencesErrorState) {
          return FailureWidget(
              title: translateLang(context, "error_get_experience"),
              onTap: () {
                context.read<AboutMeCubit>().getExperiences();
              });
        }
        if(state is AboutMeGetExperiencesSuccessState){
        return state.experiences.isEmpty
            ? EmptyDataWidget()
            : Container(
                height: double.infinity,
                width: double.infinity,
                child: ListView.separated(
                  itemCount: state.experiences.length,
                  itemBuilder: (context, index) =>
                      ExperienceCard(experience: state.experiences[index]),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 10.0,
                  ),
                ),
              );}
              return SizedBox.shrink();
      },
    );
  }
}
