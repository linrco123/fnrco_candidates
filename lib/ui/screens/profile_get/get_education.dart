import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/logic/cubit/profile_get/about_me/about_me_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/empty_data_widget.dart';
import 'package:fnrco_candidates/ui/widgets/error_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/education_card.dart';

class GetEducationScreen extends StatefulWidget {
  const GetEducationScreen({super.key});

  @override
  State<GetEducationScreen> createState() => _GetPersonalDetailsScreenState();
}

class _GetPersonalDetailsScreenState extends State<GetEducationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AboutMeCubit>().getEducation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutMeCubit, AboutMeState>(
      builder: (context, state) {
        if (state is AboutMeGetEducationsLoadingState) {
          return AnimatedLoadingWidget();
        }
        if (state is AboutMeGetEducationsErrorState) {
          return FailureWidget(
              title: 'Error ocurred on getting Educations and qualifications',
              onTap: () {
                context.read<AboutMeCubit>().getEducation();
              });
        }
        if(state is AboutMeGetEducationsSuccessState){
        return state.educations.isEmpty
            ? EmptyDataWidget()
            : Container(
                height: double.infinity,
                width: double.infinity,
                child: ListView.separated(
                  itemCount: state.educations.length,
                  itemBuilder: (context, index) =>
                      EducationCard(education: state.educations[index]),
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
