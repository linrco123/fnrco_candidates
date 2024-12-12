import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/logic/cubit/profile_get/about_me/about_me_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/empty_data_widget.dart';
import 'package:fnrco_candidates/ui/widgets/error_widget.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile_get/applied_job_card.dart';

class AppliedJobsScreen extends StatefulWidget {
  const AppliedJobsScreen({super.key});

  @override
  State<AppliedJobsScreen> createState() => _GetPersonalDetailsScreenState();
}

class _GetPersonalDetailsScreenState extends State<AppliedJobsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AboutMeCubit>().getAppliedJobs();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutMeCubit, AboutMeState>(
      builder: (context, state) {
        if (state is AboutMeGetAppliedJobsLoadingState) {
          return AnimatedLoadingWidget();
        }
        if (state is AboutMeGetAppliedJobsErrorState) {
          return FailureWidget(
              title: translateLang(context, "error_get_appl_jobs"),
              onTap: () {
                context.read<AboutMeCubit>().getAppliedJobs();
              });
        }

        if (state is AboutMeGetAppliedJobsSuccessState) {
          return state.appliedJobs.isEmpty
              ? EmptyDataWidget()
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: state.appliedJobs.length,
                    itemBuilder: (context, index) => AppliedJobCard(appliedJob:state.appliedJobs[index]),
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
