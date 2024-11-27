import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String? hint;
  final int linesNum;
  final String? Function(BuildContext, String?) validate;
  final String? initialValue;
  const CustomInputField(
      {super.key,
      required this.controller,
      this.inputType = TextInputType.text,
      this.hint,
      required this.validate,
      this.initialValue,  this.linesNum = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: [
        AutofillHints.username,      
      ],
      maxLines: linesNum,
      initialValue: initialValue,
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(color: AppColors.secondary),
      controller: controller,
      validator: (value) => validate(context, value),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.headlineSmall,
        filled: true,
        fillColor: AppColors.blurRed,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20.0),
        border:  OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.black,width: 1),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
      keyboardType: inputType,
    );
  }
}