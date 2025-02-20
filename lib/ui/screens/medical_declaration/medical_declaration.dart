import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'optional_file_screen.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/functions/translate.dart';
import '../../../logic/cubit/medical_declare/medical_declare_cubit.dart';
import '../../../constants/app_colors.dart';
import 'family_data.dart';
import 'medical_questions.dart';
import 'personal_information.dart';
import '../../widgets/auth/custom_elevated_btn.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/myStepper.dart';
import '../../widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class MedicalDeclarationScreen extends StatelessWidget {
  const MedicalDeclarationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //  Map data = ModalRoute.settingsOf(context)!.arguments as Map;
    // int appId = data["app_id"];
    return BlocConsumer<MedicalDeclareCubit, MedicalDeclareState>(
        listener: (context, state) {
      // if (state is EnterOneFamilyMemberAtLeastState) {
      //   showToast(context,
      //       title: translateLang(context, 'warning'),
      //       desc: 'Please , enter one family member at least',
      //       type: ToastificationType.warning);
      // }
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
        Navigator.of(context).pop();
      }
      if (state is SendMedicalDeclareFailureState) {
        showToast(context,
            title: translateLang(context, 'error'),
            desc: state.message,
            type: ToastificationType.error);
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
          floatingActionButton: medicalDeclareCubit.currentStep == 3
              ? Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.08),
                  child: FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<MedicalDeclareCubit>(context)
                          .addNewRelative(context);
                    },
                    child: const Icon(CupertinoIcons.add),
                  ),
                )
              : const SizedBox.shrink(),
          body: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: MyStepper(
                    child: const ['1', '2', '3', '4'],
                    titles: ["Personal", "Declaration", "Family", "File"],
                    width: MediaQuery.of(context).size.width,
                    curStep: medicalDeclareCubit.currentStep,
                    color: AppColors.primary,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: _buildStepperBody(medicalDeclareCubit.currentStep),
                  ),
                ),
                state is SendMedicalDeclareLoadingState
                    ? const AnimatedLoadingWidget()
                    : CustomElevatedButton(
                        fun: () {
                          medicalDeclareCubit.submit(context, 10);
                        },
                        background: AppColors.primary,
                        text: medicalDeclareCubit.currentStep != 4
                            ? translateLang(context, 'next')
                            : translateLang(context, 'submit')),
                const SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ));
    });
  }

  Widget _buildStepperBody(int step) {
    switch (step) {
      case 1:
        return PersonalInformationScreen();

      case 2:
        return MedicalQuestionsScreen();

      case 3:
        return FamilyDataScreen();
      case 4:
        return const OptionalFileScreen();
      default:
        return const SizedBox();
    }
  }
}
