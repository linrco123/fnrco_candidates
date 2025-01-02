import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType inputType;
  final String? hint;
  final int linesNum;
  final String? Function(BuildContext, String?) validate;
  final String? initialValue;
  final bool autovalidateMode;
  final bool enabled;
  const CustomInputField(
      {super.key,
      this.controller,
      this.inputType = TextInputType.text,
      this.hint,
      required this.validate,
      this.initialValue,
      this.linesNum = 1,
      this.enabled = true,
      this.autovalidateMode = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      // autovalidateMode:
      //     autovalidateMode ? AutovalidateMode.onUserInteraction : null,
      autofillHints: [
        AutofillHints.username,
      ],
      maxLines: linesNum,
      initialValue: initialValue,
      style: Theme.of(context).textTheme.labelMedium,
      controller: controller,
      validator: (value) => validate(context, value),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.labelMedium,
        filled: true,
        fillColor: AppColors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 25.0),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
      keyboardType: inputType,
    );
  }
}
