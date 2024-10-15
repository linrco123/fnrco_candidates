import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());
  final  formKey = GlobalKey<FormState>();

  final forgetPasswordController = TextEditingController();

  validatePhone(context, String value) {
    final regExp = RegExp(
      'Constance.phoneRegExp',
      caseSensitive: false,
      multiLine: false,
    );

    if (value.isEmpty) {
      return translateLang(context, "msg_plz_enter_phone");
    } else if (!regExp.hasMatch(value)) {
      return translateLang(context, "msg_plz_enter_correct_phone");
    }
    return null;
  }

  void verifyPhone(context) {
    emit(ForgetPasswordLoadingState());
    // if(forgetPasswordController.text.isNotEmpty){

    // // }
    // if ( formKey.currentState!.validate()) {
    //   // _formKey.currentState!.save();
     
    // }
     Navigator.of(context).pushReplacementNamed(AppPagesNames.OTP);
  }
}
