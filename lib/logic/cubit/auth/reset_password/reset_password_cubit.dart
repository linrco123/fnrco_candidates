import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/constances.dart';
import '../../../../core/functions/translate.dart';
import '../../../../data/api_provider/auth/reset_password.dart';

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
      size: 30.0,
    );
  }

  void toggleObscureText2() {
    obscureText2 = !obscureText2;
    emit(UpdatePasswordToggleObsecureText());
  }

  Icon getIcon2() {
    return Icon(
      obscureText2 ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye,
      color: AppColors.primary,size: 30.0,
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
        emit(ResetPasswordFailureState(
            message: error.failure.message.toString()));
      });
    }
  }
}
