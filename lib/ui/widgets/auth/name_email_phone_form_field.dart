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
    return TextFormField(
      autofillHints: [
        AutofillHints.username,
        AutofillHints.email,
        AutofillHints.telephoneNumber

      ],
      initialValue: initialValue,
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(color: AppColors.secondary),
      controller: controller,
      validator: (value) => validate(context, value),
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        prefixIconColor: AppColors.grey,
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.headlineSmall,
        filled: true,
        fillColor: AppColors.blurGreen,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
      keyboardType: inputType,
    );
  }
}


                            // TextFormField(
                            //   controller: signUpCubit.phoneController,
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .headlineSmall!
                            //       .copyWith(color: AppColors.secondary),
                            //   validator: (value) =>
                            //       signUpCubit.validatePhone(context, value!),
                            //   decoration: InputDecoration(
                            //     prefixIcon: Icon(CupertinoIcons.phone),
                            //     prefixIconColor: AppColors.grey,
                            //     hintText:
                            //         translateLang(context, "phone_number"),
                            //     hintStyle:
                            //         Theme.of(context).textTheme.headlineSmall,
                            //     filled: true,
                            //     fillColor: AppColors.blurGreen,
                            //     contentPadding: const EdgeInsets.symmetric(
                            //         horizontal: 15, vertical: 0),
                            //     border: const OutlineInputBorder(
                            //       borderSide: BorderSide.none,
                            //       borderRadius:
                            //           BorderRadius.all(Radius.circular(50)),
                            //     ),
                            //   ),
                            //   keyboardType: TextInputType.phone,
                            //   // onSaved: (phone) {
                            //   //   // Save it
                            //   // },
                            // ),


                               // TextFormField(
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .headlineSmall!
                            //       .copyWith(color: AppColors.secondary),
                            //   controller: signUpCubit.nameController,
                            //   validator: (value) {
                            //     return signUpCubit.validateFullName(
                            //         context, value!);
                            //   },
                            //   decoration: InputDecoration(
                            //     prefixIcon: Icon(CupertinoIcons.person),
                            //     prefixIconColor: AppColors.grey,
                            //     hintText: translateLang(context, "full_name"),
                            //     hintStyle:
                            //         Theme.of(context).textTheme.headlineSmall,
                            //     filled: true,
                            //     fillColor: AppColors.blurGreen,
                            //     contentPadding: const EdgeInsets.symmetric(
                            //         horizontal: 15, vertical: 0),
                            //     border: const OutlineInputBorder(
                            //       borderSide: BorderSide.none,
                            //       borderRadius:
                            //           BorderRadius.all(Radius.circular(50)),
                            //     ),
                            //   ),
                            //   keyboardType: TextInputType.name,
                            // ),
                            /////////////////////TODO:LOGIN 
                            ///  TextFormField(
                                  //   controller: logInCubit.phoneController,
                                  //   validator: (value) => logInCubit
                                  //       .validatePhone(context, value!),
                                  //   decoration: InputDecoration(
                                  //     prefixIcon: Icon(CupertinoIcons.phone),
                                  //     prefixIconColor: AppColors.grey,
                                  //     hintText: translateLang(
                                  //         context, "phone_number"),
                                  //     hintStyle: Theme.of(context)
                                  //         .textTheme
                                  //         .headlineMedium,
                                  //     filled: true,
                                  //     fillColor: AppColors.blurGreen,
                                  //     contentPadding:
                                  //         const EdgeInsets.symmetric(
                                  //             horizontal: 16.0 * 1.5,
                                  //             vertical: 16.0),
                                  //     border: const OutlineInputBorder(
                                  //       borderSide: BorderSide.none,
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(50)),
                                  //     ),
                                  //   ),
                                  //   keyboardType: TextInputType.phone,
                                  //   // onSaved: (phone) {
                                  //   //   // Save it
                                  //   // },
                                  // ),