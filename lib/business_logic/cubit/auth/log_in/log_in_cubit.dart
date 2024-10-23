import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/repositories/auth/log_in.dart';

import '../../../../constants/app_pages_names.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  final LogInRepository logInRepository;
  LogInCubit({required this.logInRepository}) : super(LogInInitialState());
 static LogInCubit instance(context)=> BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

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

  String? validatePhone(context,String? value) {
    final regExp = RegExp(
      'Constance.phoneRegExp',
      caseSensitive: false,
      multiLine: false,
    );
   

    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_phone" );
    } else if (!regExp.hasMatch(  value)) {
      return translateLang(context,  "msg_plz_enter_correct_phone");
    }
    return null;
  }

  String? validatePassword(context,String? value) {
 
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_password" );
    } else if (value.length < 6) {
      return translateLang(context, "msg_plz_enter_at_least_6_char");
    }
    return null;
  }
void logIn(context){
  if (formKey.currentState!.validate()) {
   Map data = {
    'phone':phoneController.text,
    'passowrd':passwordController.text
   };
    logInRepository.logInWebServices.postLogIn('').then((value){
      //CacheHelper.sharedPreferences.setString();
      emit(LogInSuccessState());
    }).catchError((error){
      emit(LogInErrorState(message: error));

    });
   
  }
   Navigator.of(context).pushReplacementNamed(AppPagesNames.HOMEPAGE);
}









}
