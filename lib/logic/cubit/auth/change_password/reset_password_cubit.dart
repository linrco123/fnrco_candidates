import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/auth/reset_password.dart';
import 'package:fnrco_candidates/main.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordprovider resetPasswordprovider;
  ResetPasswordCubit(this.resetPasswordprovider)
      : super(ResetPasswordInitial());
  static ResetPasswordCubit instance(context) => BlocProvider.of(context);
  final PasswordController = TextEditingController();
  final ConfirmPasswordController = TextEditingController();

  final formForgetKey = GlobalKey<FormState>();

  bool obscureText1 = true;
  bool obscureText2 = true;

  void toggleObscureText1() {
    obscureText1 = !obscureText1;
    emit(UpdatePasswordToggleObsecureText());
  }

  Icon getIcon1() {
    return Icon(
      obscureText1 ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye,
      color: AppColors.primary,
    );
  }

  void toggleObscureText2() {
    obscureText2 = !obscureText2;
    emit(UpdatePasswordToggleObsecureText());
  }

  Icon getIcon2() {
    return Icon(
      obscureText2 ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye,
      color: AppColors.primary,
    );
  }

  String? validatePassword(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_password");
    } else if (value.length < 6) {
      return translateLang(context, "msg_plz_enter_at_least_6_char");
    }
    return null;
  }

  String? validateConfirmPassword(context, String? value) {
    // if (containsArabicNumerals(value)) {
    //   value = normalizeArabicNumbers(value);
    //   txtConfirmPassword.text = value;
    // }
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_confirm_password");
    } else if (value.length < 6) {
      return translateLang(context, "msg_plz_enter_at_least_6_char");
    } else if (value != PasswordController.text) {
      return translateLang(context, "msg_password_not_match");
    }
    return null;
  }

  void resetPassword(context, String identifier) {
    if (formForgetKey.currentState!.validate()) {
      emit(ResetPasswordLoadingState());

      Map data = {
        "provider": CANDIDATE_PROVIDER,
        "identifier": identifier,
        "password": PasswordController.text,
        "password_confirmation": ConfirmPasswordController.text
      };

      resetPasswordprovider.resetPassword(data).then((value) {
        emit(ResetPasswordSuccessState());
      }).catchError((error) {
        emit(ResetPasswordFailureState());
      });
    }
    // if(c.text.isNotEmpty){

    // }
  }
}
