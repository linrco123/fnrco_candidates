import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/logic/cubit/profile_get/about_me/about_me_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/empty_data_widget.dart';
import 'package:fnrco_candidates/ui/widgets/error_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/skill_card.dart';

class GetSkillsScreen extends StatefulWidget {
  const GetSkillsScreen({super.key});

  @override
  State<GetSkillsScreen> createState() => _GetPersonalDetailsScreenState();
}

class _GetPersonalDetailsScreenState extends State<GetSkillsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AboutMeCubit>().getSkills();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutMeCubit, AboutMeState>(
      builder: (context, state) {
        if (state is AboutMeGetSkillsLoadingState) {
          return AnimatedLoadingWidget();
        }
        if (state is AboutMeGetSkillsErrorState) {
          return FailureWidget(
              title: 'Error ocurred on getting Skills',
              onTap: () {
                context.read<AboutMeCubit>().getSkills();
              });
        }
       if(state is AboutMeGetSkillsSuccessState){
 return state.skills.isEmpty
            ? EmptyDataWidget()
            : Container(
                height: double.infinity,
                width: double.infinity,
                child: ListView.separated(
                  itemCount: state.skills.length,
                  itemBuilder: (context, index) =>
                      SkillCard(skill: state.skills[index]),
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