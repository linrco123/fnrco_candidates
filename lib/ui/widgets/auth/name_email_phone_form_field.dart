import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';

class NameEmailPhoneFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final IconData? prefixIcon;
  final String? hint;
  final String? Function(BuildContext, String?) validate;
  final String? initialValue;
  const NameEmailPhoneFormField(
      {super.key,
      required this.controller,
      required this.inputType,
      this.prefixIcon,
      this.hint,
      required this.validate,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: TextFormField(
        autofillHints: [
          AutofillHints.username,
          AutofillHints.email,
          AutofillHints.telephoneNumber
        ],
        cursorColor: AppColors.primary,
        initialValue: initialValue,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: AppColors.greyDeep, fontWeight: FontWeight.w400),
        controller: controller,
        validator: (value) => validate(context, value),
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            size: 30,
          ),
          prefixIconColor:AppColors.grey,
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.labelMedium!
              .copyWith(color: AppColors.greyDeep, fontWeight: FontWeight.w400),
          filled: true,
          fillColor: AppColors.white,
          //alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          label: Text(
            hint!,
          ),
          labelStyle: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: AppColors.greyDeep, fontWeight: FontWeight.w400),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30.0, vertical:25.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary),
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
        ),
        keyboardType: inputType,
      ),
    );
  }
}

