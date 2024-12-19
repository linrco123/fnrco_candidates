import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/logic/cubit/medical_declare/medical_declare_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_drop_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/auth/name_email_phone_form_field.dart';
import 'package:fnrco_candidates/ui/widgets/auth/signup/signup_loading_widget.dart';

class PersonalInformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<MedicalDeclareCubit>(context);
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                NameEmailPhoneFormField(
                    controller: cubit.nameCntroller,
                    inputType: TextInputType.name,
                    prefixIcon: CupertinoIcons.person,
                    hint: translateLang(context, "full_name"),
                    validate: cubit.validateName),
                const SizedBox(
                  height: 16.0,
                ),
                NameEmailPhoneFormField(
                    controller: cubit.phone1Cntroller,
                    inputType: TextInputType.phone,
                    prefixIcon: CupertinoIcons.phone,
                    hint: translateLang(context, "phone_number"),
                    validate: cubit.validatePhone),
                const SizedBox(
                  height: 16.0,
                ),
                NameEmailPhoneFormField(
                    controller: cubit.identity1Cntroller,
                    inputType: TextInputType.number,
                    prefixIcon: CupertinoIcons.number,
                    hint: translateLang(context, "iqama_number"),
                    validate: cubit.validateIdentity),
                const SizedBox(
                  height: 16.0,
                ),
                cubit.countries.isEmpty
                    ? SignUpLoadingWidget()
                    : CustomDropDownSearch(
                        label: translateLang(context, 'select_country'),
                        items: cubit.countries
                            .map((country) => country.countryName!)
                            .toList(),
                        selectedItem: translateLang(context, 'country'),
                        onChanged: (value) => cubit.selectCountry(value!),
                      ),
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
                        onChanged: (value) => cubit.selectGender1(value!),
                      ),
                const SizedBox(
                  height: 16.0,
                ),
                cubit.maritalStatus.isEmpty
                    ? SignUpLoadingWidget()
                    : CustomDropDownSearch(
                        // widget: Image.asset(
                        //   AppImages.marital_status,
                        //   height: 20.0,
                        //   width: 20.0,
                        //   color: AppColors.grey,
                        // ),
                        label: translateLang(context, 'select_marital_status'),
                        items: cubit.maritalStatus
                            .map((marital) => marital.metaDataText!)
                            .toList(),
                        selectedItem: translateLang(context, 'marital_status'),
                        onChanged: (value) => cubit.selectMaritalStatus(value!),
                      ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
