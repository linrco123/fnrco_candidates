import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());
  static ChangePasswordCubit instance(context)=> BlocProvider.of(context);
  final PasswordController = TextEditingController();
  final ConfirmPasswordController = TextEditingController();

  final formForgetKey = GlobalKey<FormState>();

  bool obscureText1 = true;
  bool obscureText2 = true;

  void toggleObscureText1() {
    obscureText1 = !obscureText1;
    emit(ChangePasswordToggleObsecureText());
  }

  Icon getIcon1() {
    return Icon(
      obscureText1 ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye,
      color: AppColors.primary,
    );
  }

  void toggleObscureText2() {
    obscureText2 = !obscureText2;
    emit(ChangePasswordToggleObsecureText());
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
    } else if (value != ConfirmPasswordController.text) {
      return translateLang(context, "msg_password_not_match");
    }
    return null;
  }

  void changePassword(context) {
    Navigator.of(context).pushNamed(AppPagesNames.LOGIN);
    emit(ChangePasswordLoadingState());

    if(formForgetKey.currentState!.validate()){
      
    }
    // if(c.text.isNotEmpty){

    // }
  }
}
