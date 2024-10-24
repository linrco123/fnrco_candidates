import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_colors.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/auth/signup_provider.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/countries_model.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpProvider signUpProvider;
  SignUpCubit(this.signUpProvider) : super(SignUpInitialState());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final countryController = TextEditingController();
  final emailController = TextEditingController();
  int countryId = 0;

  void selectCountry(int value) {
    countryId = value;
    print(
        'Country is as follows ========================>>>>>>>>>>>>>> $value');
    emit(SignUpChoosingCountryState());
  }

  bool obscureText = true;
  void toggleObscureText() {
    obscureText = !obscureText;
    emit(SignUpChangingObsecureTextState());
  }

  Icon getIcon() {
    return Icon(
      obscureText ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye,
      color: AppColors.primary,
    );
  }

  String? validateFullName(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_full_name");
    } else if (value.length < 6) {
      return translateLang(context, "msg_plz_name_should_be_more_than_6_char");
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

  String? validatePhone(context, String? value) {
    final regExp = RegExp(
      'Constance.phoneRegExp',
      caseSensitive: false,
      multiLine: false,
    );

    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_phone");
    } else if (!regExp.hasMatch(value)) {
      return translateLang(context, "msg_plz_enter_correct_phone");
    }
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

  void signUp() {
    if (formKey.currentState!.validate() && countryId != 0) {}
  }

 var countries = List<Country>.empty(growable: true);
  void getCountries() {
    emit(SignUpGettingCountriesLoadingState());
    countries.clear();
    signUpProvider.getCountries().then((value) {
      for (var country in value.data as List) countries.add(country);
      emit(SignUpGettingCountriesSuccessState(countries: countries));
    }).catchError((error) {
      emit(SignUpGettingCountriesFailureState());
    });
  }

// only for demo
  // List<DropdownMenuItem<String>>? countries = [
  //   "Bangladesh",
  //   "Switzerland",
  //   'Canada',
  //   'Japan',
  //   'Germany',
  //   'Australia',
  //   'Sweden',
  // ].map<DropdownMenuItem<String>>((String value) {
  //   return DropdownMenuItem<String>(value: value, child: Text(value));
  // }).toList();
}
