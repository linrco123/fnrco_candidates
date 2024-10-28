import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/logic/cubit/medical_declare/medical_declare_cubit.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/localizations/app_localizations.dart';
import 'package:fnrco_candidates/presentation/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/presentation/widgets/onboarding/current_page_indictor.dart';

class MedicalDeclaration extends StatelessWidget {
  const MedicalDeclaration({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicalDeclareCubit(),
      child: BlocConsumer<MedicalDeclareCubit, MedicalDeclareState>(
        listener: (context, state) {},
        builder: (context, state) {
          MedicalDeclareCubit medicalDeclareCubit =
              MedicalDeclareCubit.instance(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Medical Declaration',
                style: TextStyle(color: AppColors.primary),
              ),
              backgroundColor: AppColors.blurGreen,
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              color: AppColors.blurGreen,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        'Do you have any symptoms of craziness ?',
                        style:
                            TextStyle(fontSize: 18.0, color: AppColors.white),
                      )),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          RadioListTile(
                              activeColor: AppColors.primary,
                              title: Text('yes'),
                              value: 1,
                              groupValue: medicalDeclareCubit.chosenRadioItem,
                              onChanged: (c) {
                                medicalDeclareCubit.changeRadioItem(c!);
                              }),
                          RadioListTile(
                              activeColor: AppColors.primary,
                              title: Text('No'),
                              value: 2,
                              groupValue: medicalDeclareCubit.chosenRadioItem,
                              onChanged: (c) {
                                medicalDeclareCubit.changeRadioItem(c!);
                              }),
                          RadioListTile(
                              activeColor: AppColors.primary,
                              title: Text('agree'),
                              value: 3,
                              groupValue: medicalDeclareCubit.chosenRadioItem,
                              onChanged: (c) {
                                medicalDeclareCubit.changeRadioItem(c!);
                              }),
                          RadioListTile(
                              activeColor: AppColors.primary,
                              title: Text('don\'t agree'),
                              value: 4,
                              groupValue: medicalDeclareCubit.chosenRadioItem,
                              onChanged: (c) {
                                medicalDeclareCubit.changeRadioItem(c!);
                              }),
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CurrentPageIndicator(
                              color: AppColors.primary,
                              currentPage: medicalDeclareCubit.chosenRadioItem,
                              list: list,
                              alignment: MainAxisAlignment.start),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CustomElevatedButton(
                              fun: () {},
                              background: AppColors.primary,
                              text: AppLocalizations.of(context)!
                                  .translate('next'))
                        ],
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

List<dynamic> list = ['1', '2', '3', '4'];
