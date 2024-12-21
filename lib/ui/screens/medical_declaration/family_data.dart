import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/logic/cubit/medical_declare/medical_declare_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_drop_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_elevated_btn.dart';
import 'package:fnrco_candidates/ui/widgets/auth/name_email_phone_form_field.dart';
import 'package:fnrco_candidates/ui/widgets/auth/signup/signup_loading_widget.dart';
import 'package:fnrco_candidates/ui/widgets/profile/date_picker_widget.dart';

class FamilyDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicalDeclareCubit>();
    return SingleChildScrollView(
      child: Form(
        key: cubit.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            NameEmailPhoneFormField(
                controller: cubit.nameCntroller,
                inputType: TextInputType.name,
                prefixIcon: CupertinoIcons.person,
                hint: translateLang(context, "employee_name"),
                validate: cubit.validateName),
            const SizedBox(
              height: 16.0,
            ),
            cubit.genders.isEmpty
                ? SignUpLoadingWidget()
                : CustomDropDownSearch(
                    isSearchEnabled: false,
                    label: translateLang(context, 'select_gender'),
                    items: cubit.genders
                        .map((gender) => gender.metaDataText!)
                        .toList(),
                    selectedItem: translateLang(context, 'gender'),
                    onChanged: (value) => cubit.selectGender(value!),
                  ),
            const SizedBox(
              height: 16.0,
            ),
            cubit.classifications.isEmpty
                ? SignUpLoadingWidget()
                : CustomDropDownSearch(
                    // isSearchEnabled: false,
                    label: translateLang(context, 'select_relation'),
                    items: cubit.classifications
                        .map((classif) => classif.metaDataText!)
                        .toList(),
                    selectedItem: translateLang(context, 'relation'),
                    onChanged: (value) => cubit.selectRelation(value!),
                  ),
            const SizedBox(
              height: 16.0,
            ),
            CustomDatePicker(
                onTap: () {
                  cubit.selectDate(context);
                },
                text: cubit.date.isEmpty ? 'Date of Birth' : cubit.date),
            const SizedBox(
              height: 16.0,
            ),
            NameEmailPhoneFormField(
                controller: cubit.phoneCntroller,
                inputType: TextInputType.phone,
                prefixIcon: CupertinoIcons.phone,
                hint: translateLang(context, "phone_number"),
                validate: cubit.validatePhone),
            const SizedBox(
              height: 16.0,
            ),
            NameEmailPhoneFormField(
                controller: cubit.passportCntroller,
                inputType: TextInputType.number,
                prefixIcon: CupertinoIcons.number,
                hint: translateLang(context, "passport_number"),
                validate: cubit.validatePasport),
            const SizedBox(
              height: 16.0,
            ),
        
            Row(
              children: [
                Expanded(
                  child: NameEmailPhoneFormField(
                      controller: cubit.heightCntroller,
                      inputType: TextInputType.number,
                      prefixIcon: CupertinoIcons.hifispeaker,
                      hint: translateLang(context, "height"),
                      validate: cubit.validateHeight),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: NameEmailPhoneFormField(
                      controller: cubit.weightCntroller,
                      inputType: TextInputType.number,
                      prefixIcon: CupertinoIcons.hifispeaker,
                      hint: translateLang(context, "weight"),
                      validate: cubit.validateWeight),
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: CustomElevatedButton(
                  fun: () {
                    cubit.addNewRelative(context);
                  },
                  background: AppColors.black,
                  text: translateLang(context, "add_new_relative")),
            ),
             const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
