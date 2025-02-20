import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/api_provider/shared_documents.dart';
import '../../../data/models/job_offer_model.dart';
import '../../../logic/cubit/shared_documents/shared_documents_cubit.dart';
import 'shared_documents.dart';
import 'package:page_transition/page_transition.dart';
import '../../widgets/profile_get/profile_item.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/translate.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/return_btn.dart';

class SharedDocsAppsScreen extends StatelessWidget {
  const SharedDocsAppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SharedDocumentsProvider _sharedDocs = SharedDocumentsProvider();
    SharedDocumentsCubit sharedDocumentsCubit =
        SharedDocumentsCubit(_sharedDocs);
    return BlocProvider(
      create: (context) => sharedDocumentsCubit..getJobApplications(),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.white,
            centerTitle: true,
            title: Text(
              translateLang(context, 'shared_documents'),
              style: TextStyle(
                color: AppColors.primary,
              ),
            ),
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            leading: ReturnButton(
              color: AppColors.primary,
            )),
        body: BlocConsumer<SharedDocumentsCubit, SharedDocumentsState>(
          listener: (context, state) {},
          builder: (context, state) {
            // final cubit = BlocProvider.of<SharedDocumentsCubit>(context);
            if (state is GetJobApplicationsLoadingState) {
              return const AnimatedLoadingWidget(
                height: 150.0,
                width: 150.0,
              );
            }

            if (state is GetJobApplicationsFailureState) {
              return FailureWidget(
                  showImage: true,
                  title: state.message,
                  onTap: () {
                    context.read<SharedDocumentsCubit>().getJobApplications();
                  });
            }

            return sharedDocumentsCubit.jobApplications.isEmpty
                ? const EmptyDataWidget(
                    message: "No applications available Yet !!!",
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        right: 15.0, left: 15.0, top: 25.0),
                    child: ListView.separated(
                        itemCount: sharedDocumentsCubit.jobApplications.length,
                        itemBuilder: (BuildContext context, int index) =>
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageTransition(
                                    child: BlocProvider.value(
                                      value: sharedDocumentsCubit
                                        ..getAppDocs(sharedDocumentsCubit
                                            .jobApplications[index].id!),
                                      child: SharedDocumentsScreen(
                                          appId: sharedDocumentsCubit
                                              .jobApplications[index].id!),
                                    ),
                                    type: PageTransitionType.fade,
                                    alignment: Alignment.centerLeft,
                                    duration: const Duration(seconds: 1)));
                              },
                              child: SharedDocsAppCard(
                                  application: sharedDocumentsCubit
                                      .jobApplications[index]),
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

class SharedDocsAppCard extends StatelessWidget {
  final JobApplication application;
  const SharedDocsAppCard({
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
              offset: const Offset(0, 1))
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
