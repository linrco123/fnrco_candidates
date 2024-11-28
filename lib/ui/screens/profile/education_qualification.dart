import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_images_path.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/profile_update/education_qualification.dart';
import 'package:fnrco_candidates/logic/cubit/profile/education_qualification/education_and_qualification_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_drop_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile/custom_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/return_btn.dart';
import 'package:toastification/toastification.dart';

class EducationAndQualificationScreen extends StatelessWidget {
  const EducationAndQualificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EducationAndQualificationCubit(EducationAndQualificationProvider())
            ..getYears(),
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: AppColors.white,
          title: Text(
            translateLang(context, 'education_qualification'),
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.bold),
          ),
          leading: ReturnButton(),
          centerTitle: true,
        ),
        body: BlocConsumer<EducationAndQualificationCubit,
            EducationAndQualificationState>(
          listener: (context, state) {
            if (state is CheckEducationAndQualificationEmptyFieldsState) {
              showToast(context,
                  title: translateLang(context, 'warning'),
                  desc:
                      translateLang(context, "msg_plz_chse_experience_fields"),
                  type: ToastificationType.warning);
            }
            if (state is SubmitEducationAndQualificationSuccessState) {
               Navigator.of(context).pop();
              showToast(context,
                  title: translateLang(context, 'success'),
                  desc: translateLang(context, "msg_qual_add_success"),
                  type: ToastificationType.success);
                 
            }
            
            if (state is SubmitEducationAndQualificationFailureState) {
              showToast(context,
                  title: translateLang(context, 'error'),
                  desc: state.message,
                  type: ToastificationType.error);
            }
          },
          builder: (context, state) {
            EducationAndQualificationCubit cubit = BlocProvider.of(context);
            if (state is EducationGettingYearsLoadingState)
              return LoadingWidget();
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        controller: ScrollController(initialScrollOffset: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              translateLang(context, "degree"),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            CustomInputField(
                              controller: cubit.degreeCntroller,
                              validate: cubit.validateDegree,
                              hint: translateLang(context, "bach_scie"),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              translateLang(context, "specialization"),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            CustomInputField(
                              controller: cubit.spcCntroller,
                              validate: cubit.validateSpecialization,
                              hint: translateLang(context, "specialization"),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              translateLang(context, "education_years"),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                CounterButton(
                                    text: '+',
                                    onTap: () {
                                      cubit.increaseYearsNumber();
                                    }),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: SizedBox(
                                    height: 40.0,
                                    width: 45.0,
                                    child: TextFormField(
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: AppColors.greyDeep,
                                      ),
                                      controller: cubit.yearsNumCntroller,
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) =>
                                          cubit.onChanged(value),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        FilteringTextInputFormatter
                                            .singleLineFormatter
                                      ],
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                              left: 13.0,
                                              right: 13.0,
                                              bottom: 7.0),
                                          filled: true,
                                          fillColor:
                                              AppColors.grey.withOpacity(0.1)),
                                    ),
                                  ),
                                ),
                                CounterButton(
                                    text: '-',
                                    onTap: () {
                                      cubit.decreaseyearsNumber();
                                    }),
                              ],
                            ),

                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              translateLang(context, "pass_year"),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            CustomDropTextField(
                                items: cubit.years
                                    .map((year) => DropdownMenuItem<int>(
                                          //alignment: Alignment.center,
                                          child: Text('${year.metaDataText}'),
                                          value: year.id,
                                        ))
                                    .toList(),
                                text: translateLang(context, 'select_year'),
                                icon: Image.asset(
                                  AppImages.graduate,
                                  height: 30.0,
                                  width: 30.0,
                                  color: AppColors.grey,
                                ),
                                onChanged: (year) => cubit
                                    .selectYear(int.parse(year.toString()))),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              translateLang(context, "institution_name"),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            CustomInputField(
                              controller: cubit.instituteCntroller,
                              validate: cubit.validateInstitution,
                              hint: translateLang(context, "institution_name"),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              translateLang(context, "cert_name"),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            CustomInputField(
                              controller: cubit.certCntroller,
                              validate: cubit.validateCertification,
                              hint: translateLang(context, "cert_name"),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              translateLang(context, "cert_issue_date"),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                cubit.selectIssueDate(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                width: double.infinity,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16.0)),
                                child: Row(
                                  children: [
                                    Text(
                                      cubit.certIssueDate ??
                                          translateLang(
                                              context, "cert_issue_date"),
                                      style: TextStyle(
                                          color: cubit.certIssueDate == null
                                              ? AppColors.grey
                                              : AppColors.black),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      CupertinoIcons.calendar,
                                      size: 25.0,
                                      color: AppColors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              translateLang(context, "cert_expire_date"),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                cubit.selectExpiryDate(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                width: double.infinity,
                                height: 50.0,
                                decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16.0)),
                                child: Row(
                                  children: [
                                    Text(
                                      cubit.certExpireDate ??
                                          translateLang(
                                              context, "cert_expire_date"),
                                      style: TextStyle(
                                          color: cubit.certExpireDate == null
                                              ? AppColors.grey
                                              : AppColors.black),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      CupertinoIcons.calendar,
                                      size: 25.0,
                                      color: AppColors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: CustomElevatedButton(
                                  fun: () {
                                    cubit.addNewEducationAndQualification();
                                  },
                                  background: AppColors.black,
                                  text: translateLang(context, "add_new_qual")),
                            ),
                            //const Spacer(),

                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    state is SubmitEducationAndQualificationLoadingState
                        ? LoadingWidget()
                        : CustomElevatedButton(
                            fun: () {
                              cubit.SubmitEducationAndQualification();
                            },
                            background: AppColors.primary,
                            text: translateLang(context, 'submit')),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
