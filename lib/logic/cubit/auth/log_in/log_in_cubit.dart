import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/auth/login_provider.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  final LoginProvider logInProvider;
  LogInCubit({required this.logInProvider}) : super(LogInInitialState());
  static LogInCubit instance(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
 // final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  bool obscureText = true;
  void toggleObscureText() {
    obscureText = !obscureText;
    emit(LogInChangingObsecureTextState());
  }

  Icon getIcon() {
    return Icon(
      obscureText ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye,
      color: AppColors.primary,
    );
  }

  String? validatePhone(context, String? value) {
    final regExp = RegExp(
      'Constance.phoneRegExp',
      caseSensitive: false,
      multiLine: false,
    );

    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_phone");
      }
    // } else if (!regExp.hasMatch(value)) {
    //   return translateLang(context, "msg_plz_enter_correct_phone");
    // }
    return null;
  }

  String? validatePassword(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_password");
    } else if (value.length < 6) {
      return translateLang(context, "msg_plz_enter_at_least_6_char");
    }
    return null;
  }

    String? validateEmail(context, String? value) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_email");
    } else if (!regex.hasMatch(value)) {
      return translateLang(context, "msg_plz_enter_correct_email");
    }
    return null;
  }

  void logIn() {
    if (formKey.currentState!.validate()) {
      emit(LogInLoadingState());
      Map data = {
        'email': emailController.text,
        'password': passwordController.text
      };
      logInProvider.logIn(data).then((value) {
        CacheHelper.storeUserData(userLData: value);
        emit(LogInSuccessState());
      }).catchError((error) {
         emit(LogInErrorState(message: error.failure.message.toString()));
      });
    }
  }
}
