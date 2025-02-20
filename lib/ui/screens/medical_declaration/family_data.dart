import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/profile/custom_text_field.dart';
import '../../widgets/profile/title_text.dart';
import '../../../core/functions/translate.dart';
import '../../../logic/cubit/medical_declare/medical_declare_cubit.dart';
import '../../widgets/auth/custom_drop_text_field.dart';
import '../../widgets/auth/signup/signup_loading_widget.dart';
import '../../widgets/profile/date_picker_widget.dart';

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
            const CustomTitle(
              title: "employee_name",
            ),
            CustomInputField(
                controller: cubit.nameCntroller,
                validate: cubit.validateName,
                inputType: TextInputType.name,
                hint: translateLang(context, "employee_name")),
            const SizedBox(
              height: 16.0,
            ),
            cubit.genders.isEmpty
                ? const ItemLoadingWidget()
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
                ? const ItemLoadingWidget()
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
                text: cubit.date.isEmpty
                    ? translateLang(context, "date_birth")
                    : cubit.date),
            const SizedBox(
              height: 16.0,
            ),
            const CustomTitle(
              title: "phone_number",
            ),
            CustomInputField(
                controller: cubit.phoneCntroller,
                validate: cubit.validatePhone,
                inputType: TextInputType.phone,
                hint: translateLang(context, "phone_number")),
            const SizedBox(
              height: 16.0,
            ),
            const CustomTitle(
              title: "passport_number",
            ),
            CustomInputField(
                controller: cubit.passportCntroller,
                validate: cubit.validatePasport,
                inputType: TextInputType.name,
                hint: translateLang(context, "passport_number")),
            const SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    const CustomTitle(
                      title: "height",
                    ),
                    CustomInputField(
                      suffix: Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.only(right: 20),
              alignment: Alignment.center,
              child: Text(
                'cm',
                style: Theme.of(context).textTheme.headlineLarge,
              )),
                        controller: cubit.heightCntroller,
                        validate: cubit.validateHeight,
                        inputType: TextInputType.number,
                        hint: translateLang(context, "height")),
                  ],
                )),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    child: Column(
                  children: [
                    const CustomTitle(
                      title: "weight",
                    ),
                    CustomInputField(
                      controller: cubit.weightCntroller,
                      validate: cubit.validateWeight,
                      inputType: TextInputType.number,
                      hint: translateLang(context, "weight"),
                      suffix: Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.only(right: 20),
                          alignment: Alignment.center,
                          child: Text(
                            'kg',
                            style: Theme.of(context).textTheme.headlineLarge,
                          )),
                    ),
                  ],
                )),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width / 2,
            //   child: CustomElevatedButton(
            //       fun: () {
            //         cubit.addNewRelative(context);
            //       },
            //       background: AppColors.black,
            //       text: translateLang(context, "add_new_relative")),
            // ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
