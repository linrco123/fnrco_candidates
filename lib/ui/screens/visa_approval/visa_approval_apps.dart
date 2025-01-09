import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/logic/cubit/joining_date/joining_date_cubit.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/translate.dart';
import '../../../data/api_provider/visa_approval.dart';
import '../../../data/models/visa_approval_model.dart';
import '../../../logic/cubit/visa_approval/visa_approval_cubit.dart';
import 'visa_approval.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile_get/profile_item.dart';
import '../../widgets/return_btn.dart';

class VisaApprovalAppsScreen extends StatelessWidget {
  const VisaApprovalAppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    VisaApprovalProvider _visaApprovalProvider = VisaApprovalProvider();
    VisaApprovalCubit visaApprovalCubit =
        VisaApprovalCubit(_visaApprovalProvider);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return BlocProvider(
      create: (context) => visaApprovalCubit..getVisadata(),
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
        body: BlocConsumer<VisaApprovalCubit, VisaApprovalState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = BlocProvider.of<VisaApprovalCubit>(context);
            if (state is GetVisaApprovalDataLoadingState) {
              return AnimatedLoadingWidget(
                height: 150.0,
                width: 150.0,
              );
            }
            if (state is GetVisaApprovalDataFailureState) {
              return FailureWidget(
                  title: state.message,
                  onTap: () {
                    context.read<VisaApprovalCubit>().getVisadata();
                  });
            }

            return cubit.visaApplications.isEmpty
                ? EmptyDataWidget(
                    message: "No job applications available Yet !!!",
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        right: 15.0, left: 15.0, top: 25.0),
                    child: ListView.separated(
                        itemCount: cubit.visaApplications.length,
                        itemBuilder: (BuildContext context, int index) =>
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: visaApprovalCubit,
                                    child: VisaApprovalScreen(
                                        visaApprovalApplication:
                                            cubit.visaApplications[index]),
                                  ),
                                ));
                                // visaApprovalCubit.candidate_app_id =
                                //     state.applications[index].id!;
                              },
                              child: VisaApprovalApplicationCard(
                                  application: cubit.visaApplications[index]),
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

class VisaApprovalApplicationCard extends StatelessWidget {
  final VisaApprovalApplication application;
  const VisaApprovalApplicationCard({
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
