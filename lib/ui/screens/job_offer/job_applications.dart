import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/translate.dart';
import '../../../data/api_provider/job_offer.dart';
import '../../../logic/cubit/job_offer/job_offer_cubit.dart';
import 'job_offer.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/job_application_card.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/return_btn.dart';

class JobApplicationScreen extends StatelessWidget {
  const JobApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    JobOfferProvider _jobOfferProvider = JobOfferProvider();
    JobOfferCubit jobOfferCubit = JobOfferCubit(_jobOfferProvider);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return BlocProvider(
      create: (context) => jobOfferCubit..getJobApplications(),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.white,
            centerTitle: true,
            title: Text(
              translateLang(context, 'job_applications'),
              style: TextStyle(
                color: AppColors.primary,
              ),
            ),
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            leading: ReturnButton(
              color: AppColors.primary,
            )),
        body: BlocConsumer<JobOfferCubit, JobOfferState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetJobOfferApplicationsLoadingState) {
              return AnimatedLoadingWidget(
                height: 150.0,
                width: 150.0,
              );
            }
            if (state is GetJobOfferApplicationsFailureState) {
              return FailureWidget(
                  title: state.message,
                  onTap: () {
                    context.read<JobOfferCubit>().getJobApplications();
                  });
            }

            if (state is GetJobOfferApplicationsSuccessState) {
              return state.applications.isEmpty
                  ? EmptyDataWidget(
                      message: "No job applications available Yet !!!",
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          right: 15.0, left: 15.0, top: 25.0),
                      child: ListView.separated(
                          itemCount: state.applications.length,
                          itemBuilder: (BuildContext context, int index) =>
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => BlocProvider.value(
                                      value: jobOfferCubit
                                        ..convertJobOfferToPdfFile(state
                                            .applications[index]
                                            .pipeline!
                                            .jobOfferPdf!),
                                      child: JobOfferScreen(
                                          applicationId:
                                              state.applications[index].id!),
                                    ),
                                  ));
                                },
                                child: JobApplicationCard(
                                    application: state.applications[index]),
                              ),
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                                height: 20.0,
                              )),
                    );
            }
            return AnimatedLoadingWidget(height: 150.0, width: 150.0);
          },
        ),
      ),
    );
  }
}
