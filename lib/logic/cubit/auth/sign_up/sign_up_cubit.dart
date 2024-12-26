import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/constances.dart';
import '../../../../core/classes/cache_helper.dart';
import '../../../../core/functions/show_toast.dart';
import '../../../../core/functions/translate.dart';
import '../../../../data/api_provider/auth/signup_provider.dart';
import '../../../../data/models/auth/sign_up/countries_model.dart';
import '../../../../data/models/auth/sign_up/gender_model.dart';
import '../../../../data/models/auth/sign_up/marital_status_model.dart';
import '../../../../data/models/auth/sign_up/positions_model.dart';
import '../../../../data/models/auth/sign_up/religion_model.dart';
import 'package:toastification/toastification.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpProvider signUpProvider;
  SignUpCubit(this.signUpProvider) : super(SignUpInitialState());

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final countryController = TextEditingController();
  final emailController = TextEditingController();
  final majorController = TextEditingController();

  String countryId = '';
  String genderId = '';
  String religionId = '';
  String maritalStatusId = '';

  void selectCountry(String value) {
    countryId = value;
    print(value);

    emit(SignUpChoosingCountryState());
  }

  void selectGender(String value) {
    genderId = value;
    print(value);

    emit(SignUpChoosingGenderState());
  }

  void selectReligion(String value) {
    religionId = value;
    print(value);

    emit(SignUpChoosingReligionState());
  }

  void selectMaritalStatus(String value) {
    maritalStatusId = value;
    print(value);

    emit(SignUpChoosingReligionState());
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
      size: 30.0,
    );
  }

  String? validateFirstName(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_first_name");
    }
    return null;
  }

  String? validateSecondName(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_second_name");
    }
    return null;
  }

  String? validateLastName(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_last_name");
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

  String? validateMajor(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_major");
    }
    return null;
  }

  void signUp(context) {
    if (countryId == '') {
      showToast(context,
          title: translateLang(context, 'warning'),
          desc: translateLang(context, "choose_country"),
          type: ToastificationType.warning);
    } else if (genderId == '') {
      showToast(context,
          title: translateLang(context, 'warning'),
          desc: translateLang(context, "choose_gender"),
          type: ToastificationType.warning);
    } else if (religionId == '') {
      showToast(context,
          title: translateLang(context, 'warning'),
          desc: translateLang(context, "choose_religion"),
          type: ToastificationType.warning);
    } else if (maritalStatusId == '') {
      showToast(context,
          title: translateLang(context, 'warning'),
          desc: translateLang(context, "choose_marital"),
          type: ToastificationType.warning);
    } else {
      if (formKey.currentState!.validate()) {
        emit(SignUpLoadingState());
        Map data = {
          "first_name": firstNameController.text,
          "second_name": secondNameController.text,
          "third_name": lastNameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
          "password": passwordController.text,
          "religion_id": religions
              .where((religion) => religion.religionName == religionId)
              .toList()
              .single
              .id!,
          "position": majorController.text,
          "nationality": countries
              .where((country) => country.countryName == countryId)
              .toList()
              .first
              .id,
          "gender": genderId,
          "martial_status": maritalStatusId
        };
        print('======================Data===================================');
        print(data);
        signUpProvider.signUp(data).then((value) {
          CacheHelper.storeUserData(userRData: value);
          emit(SignUpSuccessState());
        }).catchError((error) {
          emit(SignUpErrorState(message: error.failure.message));
        });
      }
    }
  }

  void getOTP() {
    emit(SignUpOTPLoadingState());
    Map data = {
      PROVIDER_KEYWORD: CANDIDATE_PROVIDER,
      IDENTIFIER_KEYWORD: emailController.text
    };
    signUpProvider.getOTP(data).then((value) {
      emit(SignUpOTPSuccessState(code: value!));
    }).catchError((error) {
      emit(SignUpOTPFailureState(message: error.failure.message.toString()));
    });
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

  var positions = List<Position>.empty(growable: true);
  void getPositions() {
    emit(SignUpGettingPositionsLoadingState());
    positions.clear();
    signUpProvider.getPositions().then((value) {
      for (var position in value.positions as List) positions.add(position);
      print(
          '=========================positions===============================');
      print(positions.length);
      emit(SignUpGettingPositionsSuccessState(countries: positions));
    }).catchError((error) {
      emit(SignUpGettingPositionsFailureState());
    });
  }

  var genders = List<Gender>.empty(growable: true);
  void getGenders() {
    emit(SignUpGettingGenderLoadingState());
    genders.clear();
    signUpProvider.getGenders().then((value) {
      for (var gender in value.genders as List) genders.add(gender);
      emit(SignUpGettingGenderSuccessState());
    }).catchError((error) {
      emit(SignUpGettingGenderFailureState());
    });
  }

  var religions = List<Religion>.empty(growable: true);
  void getReligions() {
    emit(SignUpGettingReligionLoadingState());
    religions.clear();
    signUpProvider.getReligions().then((value) {
      for (var religion in value.data as List) religions.add(religion);
      emit(SignUpGettingReligionsSuccessState());
    }).catchError((error) {
      emit(SignUpGettingReligionFailureState());
    });
  }

  var maritalStatus = List<MaritalStatus>.empty(growable: true);
  void getMaritalStatus() {
    emit(SignUpGettingMaritalStatusLoadingState());
    maritalStatus.clear();
    signUpProvider.getMaritalStatus().then((value) {
      for (var marital in value.data as List) maritalStatus.add(marital);
      emit(SignUpGettingMaritalStatusSuccessState());
    }).catchError((error) {
      emit(SignUpGettingMaritalStatusFailureState());
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
