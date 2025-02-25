import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/core/functions/animated_transition.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/ui/screens/profile_add_new/education_qualification.dart';
import 'package:toastification/toastification.dart';
import '../../../core/functions/translate.dart';
import '../../../logic/cubit/profile_get/about_me/about_me_cubit.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile_get/education_card.dart';

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
    return BlocConsumer<AboutMeCubit, AboutMeState>(
      buildWhen: (previous, current) =>
          current is AboutMeGetEducationsLoadingState ||
          current is AboutMeGetEducationsSuccessState ||
          current is AboutMeGetEducationsErrorState ||
          current is AboutMeDeleteLoadingState,
      listener: (context, state) {
        if (state is AboutMeDeleteSuccessState) {
          showToast(context,
              title: translateLang(context, 'success'),
              desc: 'Education is deleted successfully',
              type: ToastificationType.success);
          Navigator.of(context).pop();
        }
        if (state is AboutMeDeleteErrorState) {
          showToast(context,
              title: translateLang(context, 'error'),
              desc: 'Education is not deleted yet !!!',
              type: ToastificationType.error);
          //  Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is AboutMeGetEducationsLoadingState ||
            state is AboutMeDeleteLoadingState) {
          return const AnimatedLoadingWidget();
        }
        if (state is AboutMeGetEducationsErrorState) {
          return FailureWidget(
              showImage: false,
              title:
                  '${translateLang(context, "error_get_educations")}\n${state.message}',
              onTap: () {
                context.read<AboutMeCubit>().getEducation();
              });
        }
        if (state is AboutMeGetEducationsSuccessState) {
          return state.educations.isEmpty
              ? const EmptyDataWidget(
                  message: "No education available Yet !!!",
                )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: state.educations.length,
                    itemBuilder: (context, index) => Dismissible(
                      key: Key("$index"),
                      onDismissed: (direction) {
                        context.read<AboutMeCubit>().deleteSectionItem(
                            EDUCATIONS, state.educations[index].id!);
                      },
                      child: InkWell(
                          onTap: () => animatedTransition(
                              context,
                              EducationAndQualificationScreen(
                                education: state.educations[index],
                              )),
                          child: EducationCard(
                              education: state.educations[index])),
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
