import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/data/api_provider/required_documents.dart';
import 'package:fnrco_candidates/data/models/job_offer_model.dart';
import 'package:fnrco_candidates/logic/cubit/required_documents/required_documents_cubit.dart';
import 'package:fnrco_candidates/logic/cubit/required_documents/required_documents_state.dart';
import 'package:fnrco_candidates/ui/screens/required_documents/required_documents.dart';
import 'package:page_transition/page_transition.dart';
import '../../widgets/profile_get/profile_item.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/translate.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/return_btn.dart';

class RequiredDocumentsApplicationsScreen extends StatelessWidget {
  const RequiredDocumentsApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RequiredDocumentsProvider _requiredDocumentsProvider =
        RequiredDocumentsProvider();
    RequiredDocumentsCubit requiredDocumentsCubit =
        RequiredDocumentsCubit(_requiredDocumentsProvider);

    return BlocProvider(
      create: (context) => requiredDocumentsCubit..getJobApplications(),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.white,
            centerTitle: true,
            title: Text(
              translateLang(context, 'applications'),
              style: TextStyle(
                color: AppColors.primary,
              ),
            ),
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            leading: ReturnButton(
              color: AppColors.primary,
            )),
        body: BlocConsumer<RequiredDocumentsCubit, RequiredDocumentsState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = BlocProvider.of<RequiredDocumentsCubit>(context);
            if (state is GetRequiredDocumentsAppsLoadingState) {
              return AnimatedLoadingWidget(
                height: 150.0,
                width: 150.0,
              );
            }

            if (state is GetRequiredDocumentsAppsFailureState) {
              return FailureWidget(
                  showImage: true,
                  title: '',
                  onTap: () {
                    context.read<RequiredDocumentsCubit>().getJobApplications();
                  });
            }

            return cubit.jobApplications.isEmpty
                ? EmptyDataWidget(
                    message: "No job applications available Yet !!!",
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        right: 15.0, left: 15.0, top: 25.0),
                    child: ListView.separated(
                        itemCount: cubit.jobApplications.length,
                        itemBuilder: (BuildContext context, int index) =>
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageTransition(
                                    child: BlocProvider.value(
                                      value: requiredDocumentsCubit
                                        ..getRequiredDocumentsData(
                                            cubit.jobApplications[index].id!),
                                      child: RequiredDocumentsScreen(),
                                    ),
                                    type: PageTransitionType.fade,
                                    alignment: Alignment.centerLeft,
                                    duration: const Duration(seconds: 1)));

                                context
                                    .read<RequiredDocumentsCubit>()
                                    .passAppID(
                                        cubit.jobApplications[index].id!);
                              },
                              child: RequiredDocumentApplicationCard(
                                  application: cubit.jobApplications[index]),
                            ),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                              height: 20.0,
                            )),
                  );
          },
        ),
      ),
    );
  }
}

class RequiredDocumentApplicationCard extends StatelessWidget {
  final JobApplication application;
  const RequiredDocumentApplicationCard({
    Key? key,
    required this.application,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: AppColors.grey,
              blurRadius: 5.0,
              spreadRadius: 5.0,
              blurStyle: BlurStyle.outer,
              offset: Offset(0, 1))
        ],
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileItem(
              kkey: "candidate_name",
              value: application.candidateName.toString()),
          ProfileItem(
              kkey: "nationality",
              value: application.candidateNationality!.toString()),
          ProfileItem(kkey: "position", value: application.position.toString()),
          ProfileItem(
              kkey: "client_name", value: application.clientName.toString()),
        ],
      ),
    );
  }
}
