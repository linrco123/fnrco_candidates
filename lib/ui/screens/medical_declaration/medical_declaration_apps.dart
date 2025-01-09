import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/data/api_provider/medical_declare.dart';
import 'package:fnrco_candidates/data/models/medical_declaration_app_model.dart';
import 'package:fnrco_candidates/logic/cubit/medical_declare/medical_declare_cubit.dart';
import 'package:fnrco_candidates/ui/screens/medical_declaration/medical_declaration.dart';
import '../../../constants/app_colors.dart';
import '../../../core/functions/translate.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/profile_get/profile_item.dart';
import '../../widgets/return_btn.dart';

class MedicalDeclarationAppsScreen extends StatelessWidget {
  const MedicalDeclarationAppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MedicalDeclareProvider _medicalDeclareProvider = MedicalDeclareProvider();
    MedicalDeclareCubit medicalDeclareCubit =
        MedicalDeclareCubit(_medicalDeclareProvider);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return BlocProvider(
      create: (context) => medicalDeclareCubit..getMedicalApplications(),
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
        body: BlocConsumer<MedicalDeclareCubit, MedicalDeclareState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = BlocProvider.of<MedicalDeclareCubit>(context);
            if (state is GetMedicalApplicationsLoadingState) {
              return AnimatedLoadingWidget(
                height: 150.0,
                width: 150.0,
              );
            }
            if (state is GetMedicalApplicationsFailureState) {
              return FailureWidget(
                showImage: true,
                  title: state.message,
                  onTap: () {
                    context
                        .read<MedicalDeclareCubit>()
                        .getMedicalApplications();
                  });
            }

            return cubit.medicalApplications.isEmpty
                ? EmptyDataWidget(
                    message: "No job applications available Yet !!!",
                  )
                : Padding(
                    padding: const EdgeInsets.only(
                        right: 15.0, left: 15.0, top: 25.0),
                    child: ListView.separated(
                        itemCount: cubit.medicalApplications.length,
                        itemBuilder: (BuildContext context, int index) =>
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: medicalDeclareCubit
                                      ..getClasifications()
                                      ..getGenders()
                                      ..getMedicalQuestions(),
                                    child: MedicalDeclarationScreen(),
                                  ),
                                ));
                                medicalDeclareCubit.storeHDF(cubit
                                    .medicalApplications[index]
                                    .pipeline!
                                    .candidateApplicationHdfId);
                              },
                              child: MedicalDeclarationAppCard(
                                  application:
                                      cubit.medicalApplications[index]),
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

class MedicalDeclarationAppCard extends StatelessWidget {
  final MedicalDeclarationApp application;
  const MedicalDeclarationAppCard({
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
