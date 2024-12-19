import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/logic/cubit/medical_declare/medical_declare_cubit.dart';
import 'package:fnrco_candidates/ui/widgets/auth/custom_drop_text_field.dart';
import 'package:fnrco_candidates/ui/widgets/auth/name_email_phone_form_field.dart';
import 'package:fnrco_candidates/ui/widgets/auth/signup/signup_loading_widget.dart';

class FamilyDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicalDeclareCubit>();
    return SingleChildScrollView(
      child: Column(
        children: [
          // "relation_classification_id": 1,
          // "dependent_name": "John Doe",
          // "dependent_gender": "male",
          // "dependent_dob": "1990-01-01",
          // "dependent_passport": "A12345678",
          // "dependent_phone": "+123456789",
          // "dependent_weight": 70,
          // "dependent_weight_unit": "kg",
          // "dependent_height": 180,
          // "dependent_height_unit": "cm"

          NameEmailPhoneFormField(
              controller: cubit.employeeCntroller,
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
                  onChanged: (value) => cubit.selectGender2(value!),
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
                  onChanged: (value) => cubit.selectGender2(value!),
                ),
          const SizedBox(
            height: 16.0,
          ),
          NameEmailPhoneFormField(
              controller: cubit.identity2Cntroller,
              inputType: TextInputType.number,
              prefixIcon: CupertinoIcons.number,
              hint: translateLang(context, "iqama_number"),
              validate: cubit.validateIdentity),
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
                    prefixIcon: CupertinoIcons.table,
                    hint: translateLang(context, "weight"),
                    validate: cubit.validateWeight),
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
          NameEmailPhoneFormField(
              controller: cubit.phone2Cntroller,
              inputType: TextInputType.phone,
              prefixIcon: CupertinoIcons.phone,
              hint: translateLang(context, "phone_number"),
              validate: cubit.validatePhone),
        ],
      ),
    );
  }
}
