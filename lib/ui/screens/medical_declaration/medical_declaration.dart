import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/medical_declare.dart';
import 'package:fnrco_candidates/logic/cubit/medical_declare/medical_declare_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/ui/screens/medical_declaration/family_data.dart';
import 'package:fnrco_candidates/ui/screens/medical_declaration/medical_questions.dart';
import 'package:fnrco_candidates/ui/screens/medical_declaration/personal_information.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/myStepper.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class MedicalDeclaration extends StatelessWidget {
  const MedicalDeclaration({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MedicalDeclareCubit(MedicalDeclareProvider())
          ..getCountries()
          ..getGenders()
          ..getClasifications()
          ..getMaritalStatus()
          ..getMedicalQuestions(),
        child: BlocConsumer<MedicalDeclareCubit, MedicalDeclareState>(
            listener: (context, state) {
          if (state is EnterOneFamilyMemberAtLeastState) {
            showToast(context,
                title: translateLang(context, 'warning'),
                desc: 'Please , enter one family member at least',
                type: ToastificationType.warning);
          }
          if (state is MedicalSubmitAnswerState) {
            showToast(context,
                title: translateLang(context, 'warning'),
                desc: 'Please , you should submit an answer',
                type: ToastificationType.warning);
          }
          if (state is SendMedicalDeclareSuccessState) {
            showToast(context,
                title: translateLang(context, 'success'),
                desc: 'Medical Declaration submitted successfully',
                type: ToastificationType.success);

            Navigator.of(context).pop();
          }
        }, builder: (context, state) {
          MedicalDeclareCubit medicalDeclareCubit =
              MedicalDeclareCubit.instance(context);
          return Scaffold(
              appBar: AppBar(
                title: Text(
                  translateLang(context, "medical_declare"),
                  style: TextStyle(color: AppColors.primary),
                ),
                backgroundColor: AppColors.white,
                leading: ReturnButton(),
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: MyStepper(
                        child: const ['1', '2', '3'],
                        titles: [
                          "Personal data",
                          "Declaration",
                          "Family",
                        ],
                        width: MediaQuery.of(context).size.width,
                        curStep: medicalDeclareCubit.currentStep,
                        color: AppColors.primary,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child:
                            _buildStepperBody(medicalDeclareCubit.currentStep),
                      ),
                    ),
                    state is SendMedicalDeclareSuccessState?
                    AnimatedLoadingWidget():
                    CustomElevatedButton(
                        fun: () {
                          medicalDeclareCubit.submit(context);
                        },
                        background: AppColors.primary,
                        text: translateLang(context, 'next')),
                    const SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ));
        }));
  }

  Widget _buildStepperBody(int step) {
    switch (step) {
      case 1:
        return PersonalInformationScreen();

      case 2:
        return MedicalQuestionsScreen();

      case 3:
        return FamilyDataScreen();

      default:
        return SizedBox();
    }
  }
}
