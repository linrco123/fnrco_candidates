import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';

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
            .headlineSmall!
            .copyWith(color: AppColors.secondary),
        obscureText: obscureText,
        validator: (value) => validate(context, value),
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          prefixIconColor: AppColors.grey,
          suffixIcon: IconButton(onPressed: toggleObscureText, icon: visibleIcon),
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.headlineSmall,
          filled: true,
          fillColor: AppColors.blurRed,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
        ),
        keyboardType: TextInputType.visiblePassword,
      ),
    );
  }
}


// TextFormField(
//                               controller: signUpCubit.passwordController,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headlineSmall!
//                                   .copyWith(color: AppColors.secondary),
//                               obscureText: signUpCubit.obscureText,
//                               validator: (value) => signUpCubit
//                                   .validatePassword(context, value!),
//                               decoration: InputDecoration(
//                                 prefixIcon: Icon(CupertinoIcons.lock),
//                                 prefixIconColor: AppColors.grey,
//                                 suffixIcon: IconButton(
//                                     onPressed: signUpCubit.toggleObscureText,
//                                     icon: signUpCubit.getIcon()),
//                                 hintText: translateLang(context, "password"),
//                                 hintStyle:
//                                     Theme.of(context).textTheme.headlineSmall,
//                                 filled: true,
//                                 fillColor: AppColors.blurRed,
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: 15, vertical: 0),
//                                 border: const OutlineInputBorder(
//                                   borderSide: BorderSide.none,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(50)),
//                                 ),
//                               ),
//                               keyboardType: TextInputType.visiblePassword,
//                             ),

///////////////////////////////login/////////////////////TODO:
///
///
//  TextFormField(
//  controller: logInCubit.passwordController,
//  obscureText: logInCubit.obscureText,
//   validator: (value) => logInCubit
//  .validatePassword(context, value!),
//  decoration: InputDecoration(
//   prefixIcon: Icon(CupertinoIcons.lock),
//                                       prefixIconColor: AppColors.grey,
//                                       suffixIcon: IconButton(
//                                           onPressed:
//                                               logInCubit.toggleObscureText,
//                                           icon: logInCubit.getIcon()),
//                                       hintText:
//                                           translateLang(context, "password"),
//                                       hintStyle: Theme.of(context)
//                                           .textTheme
//                                           .headlineMedium,
//                                       filled: true,
//                                       fillColor: AppColors.blurRed,
//                                       contentPadding:
//                                           const EdgeInsets.symmetric(
//                                               horizontal: 16.0 * 1.5,
//                                               vertical: 16.0),
//                                       border: const OutlineInputBorder(
//                                         borderSide: BorderSide.none,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(50)),
//                                       ),
//                                     ),
//                                     keyboardType: TextInputType.visiblePassword,
//                                   ),