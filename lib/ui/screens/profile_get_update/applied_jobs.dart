import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/functions/translate.dart';
import '../../../logic/cubit/profile_get/about_me/about_me_cubit.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile_get/applied_job_card.dart';

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
      buildWhen: (previous, current) =>
          current is AboutMeGetAppliedJobsLoadingState ||
          current is AboutMeGetAppliedJobsSuccessState ||
          current is AboutMeGetAppliedJobsErrorState,
      builder: (context, state) {
        if (state is AboutMeGetAppliedJobsLoadingState) {
          return const AnimatedLoadingWidget();
        }
        if (state is AboutMeGetAppliedJobsErrorState) {
          return FailureWidget(
              showImage: false,
              title: '${translateLang(context, "error_get_appl_jobs")}\n${state.message}',
              onTap: () {
                context.read<AboutMeCubit>().getAppliedJobs();
              });
        }

        if (state is AboutMeGetAppliedJobsSuccessState) {
          return state.appliedJobs.isEmpty
              ? const EmptyDataWidget(
                  message: "No jobs applied available Yet !!!",
                )
              : Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: ListView.separated(
                    itemCount: state.appliedJobs.length,
                    itemBuilder: (context, index) =>
                        AppliedJobCard(appliedJob: state.appliedJobs[index]),
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
