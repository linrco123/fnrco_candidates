import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/medical_declare.dart';
import 'package:fnrco_candidates/logic/cubit/management_content/polls/polls_cubit.dart';
import 'package:fnrco_candidates/logic/cubit/medical_declare/medical_declare_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/ui/screens/medical_declaration/family_data.dart';
import 'package:fnrco_candidates/ui/screens/medical_declaration/medical_questions.dart';
import 'package:fnrco_candidates/ui/screens/medical_declaration/personal_information.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/myStepper.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';

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
              if(state is ChooseAnswerState){

              }
              if(state is MedicalSubmitAnswerState){

              }
               if(state is Change){
                
              }
            },
            builder: (context, state) {
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
                            child: _buildStepperBody(
                                medicalDeclareCubit.currentStep),
                          ),
                        ),
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
