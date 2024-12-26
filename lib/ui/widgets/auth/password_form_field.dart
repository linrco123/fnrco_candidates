import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class PasswordFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final IconData? prefixIcon;
  final void Function() toggleObscureText;
  final Widget visibleIcon;
  final String? initialValue;
  final String? Function(BuildContext, String?) validate;
  const PasswordFormField(
      {super.key,
      required this.controller,
      required this.obscureText,
      this.prefixIcon,
      required this.toggleObscureText,
      required this.visibleIcon,
      required this.validate,
      required this.hint,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: TextFormField(
        autofillHints: [
          AutofillHints.password
        ],

        initialValue: initialValue,
        controller: controller,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: AppColors.greyDeep,fontWeight: FontWeight.w400),
        obscureText: obscureText,
        validator: (value) => validate(context, value),
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: Icon(prefixIcon,  size: 30,),
          prefixIconColor: AppColors.grey,
          suffixIcon: IconButton(onPressed: toggleObscureText, icon: visibleIcon),
          //alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.labelMedium!
              .copyWith(color: AppColors.greyDeep, fontWeight: FontWeight.w400),
          filled: true,
          fillColor: AppColors.white,
          label: Text(
            hint,
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
        keyboardType: TextInputType.visiblePassword,
      ),
    );
  }
}
