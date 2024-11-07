import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/auth/forget_password.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordProvider forgetPasswordProvider;
  ForgetPasswordCubit({required this.forgetPasswordProvider})
      : super(ForgetPasswordInitial());
  final formKey = GlobalKey<FormState>();

  final forgetPasswordController = TextEditingController();

  String? validateEmail(context, String? value) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_email");
    } else if (!regex.hasMatch(value)) {
      return translateLang(context, "msg_plz_enter_correct_email");
    }
    return null;
  }

  void verifyEmail(context) {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      emit(ForgetPasswordLoadingState());
      Map data = {
        "provider": CANDIDATE_PROVIDER,
        "identifier": forgetPasswordController.text
      };
      forgetPasswordProvider.forgetPassword(data).then((value) {
        emit(ForgetPasswordSuccessState(code: value!));
      }).catchError((error) {

        emit(ForgetPasswordFailureState(message: error.failure.message.toString()));
      });
    }
  
  }
}
