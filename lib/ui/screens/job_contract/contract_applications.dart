import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/translate.dart';
import '../../../data/api_provider/job_contract.dart';
import '../../../data/models/job_contract_model.dart';
import '../../../logic/cubit/contract/contract_cubit.dart';
import 'job_contract.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile_get/profile_item.dart';
import '../../widgets/return_btn.dart';

class ContractApplicationsScreen extends StatelessWidget {
  const ContractApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    JobContractProvider _jobContractProvider = JobContractProvider();
    JobContractCubit jobContractCubit = JobContractCubit(_jobContractProvider);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return BlocProvider(
      create: (context) => jobContractCubit..getJobApplications(),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.white,
            centerTitle: true,
            title: Text(
              translateLang(context, 'contract_applications'),
              style: TextStyle(
                color: AppColors.primary,
              ),
            ),
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            leading: ReturnButton(
              color: AppColors.primary,
            )),
        body: BlocConsumer<JobContractCubit, ContractState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetJobContractApplicationsLoadingState) {
              return AnimatedLoadingWidget(
                height: 150.0,
                width: 150.0,
              );
            }
            if (state is GetJobContractApplicationsFailureState) {
              return FailureWidget(
                  title: state.message,
                  onTap: () {
                    context.read<JobContractCubit>().getJobApplications();
                  });
            }

            if (state is GetJobContractApplicationsSuccessState) {
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
                                      value: jobContractCubit
                                        ..convertPdfData(state
                                            .applications[index]
                                            .pipeline!
                                            .contractPdf!),
                                      child: JobContractSCreen(
                                          applicationId:
                                              state.applications[index].id!),
                                    ),
                                  ));
                                },
                                child: ContractApplicationCard(
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

class ContractApplicationCard extends StatelessWidget {
  final ContractApplication application;
  const ContractApplicationCard({
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
