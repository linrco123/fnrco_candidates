import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/personal_data/personal_details.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/countries_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/gender_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/marital_status_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/positions_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/religion_model.dart';
import 'package:toastification/toastification.dart';

part 'personal_details_state.dart';

class PersonalDetailsCubit extends Cubit<PersonalDetailsState> {
  PersonalDetailsProvider personalDetailsProvider;
  PersonalDetailsCubit({required this.personalDetailsProvider})
      : super(PersonalDetailsInitial());

  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final surNameController = TextEditingController();
  final countryController = TextEditingController();
  final emailController = TextEditingController();

  int countryId = 0;
  int Id = 0;
  int genderId = 0;
  int religionId = 0;
  int maritalStatusId = 0;
  String? birthDate;

  void selectDateOfBirth(context) async {
    DateTime? birthofDate = await showDatePicker(
        context: context, firstDate: DateTime(1950), lastDate: DateTime.now());
    if (birthofDate != null) {
      birthDate =
          "${birthofDate.month.toString().padLeft(2, '0')}/${birthofDate.day.toString().padLeft(2, '0')}/${birthofDate.year.toString()}";
      emit(PersonalDetailsPickingUpDate());
    }
  }

  void selectCountry(Object value) {
    countryId = int.parse(value.toString());

    emit(PersonalDetailsChoosingCountryState());
  }

  void selectGender(Object value) {
    genderId = int.parse(value.toString());

    emit(PersonalDetailsChoosingGenderState());
  }

  void selectReligion(Object value) {
    religionId = int.parse(value.toString());

    emit(PersonalDetailsChoosingReligionState());
  }

  void selectMaritalStatus(Object value) {
    maritalStatusId = int.parse(value.toString());

    emit(PersonalDetailsChoosingReligionState());
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

  String? validateSurName(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_surname");
    }
    return null;
  }

  void submitPersonalData(context) {
    if (countryId == 0) {
      showToast(context,
          title: translateLang(context, 'warning'),
          desc: translateLang(context, "choose_country"),
          type: ToastificationType.warning);
    } else if (genderId == 0) {
      showToast(context,
          title: translateLang(context, 'warning'),
          desc: translateLang(context, "choose_gender"),
          type: ToastificationType.warning);
    } else if (religionId == 0) {
      showToast(context,
          title: translateLang(context, 'warning'),
          desc: translateLang(context, "choose_religion"),
          type: ToastificationType.warning);
    } else if (maritalStatusId == 0) {
      showToast(context,
          title: translateLang(context, 'warning'),
          desc: translateLang(context, "choose_marital"),
          type: ToastificationType.warning);
    } else {
      if (formKey.currentState!.validate()) {
        emit(PersonalDetailsLoadingState());
        Map data = {
          "first_name": firstNameController.text,
          "second_name": secondNameController.text,
          "third_name": lastNameController.text,
          "email": emailController.text,
          "religion_id": religionId,
          "nationality": countryId,
          "gender": genders
              .where((gender) => gender.id! == genderId)
              .toList()
              .first
              .metaDataText,
          "martial_status": maritalStatus
              .where((marital) => marital.id == maritalStatusId)
              .toList()
              .first
              .metaDataText
        };
        print('======================Data===================================');
        print(data);
        personalDetailsProvider.submitPersonalData(data).then((value) {
          emit(PersonalDetailsSuccessState());
        }).catchError((error) {
          emit(PersonalDetailsErrorState(message: error.failure.message));
        });
      }
    }
  }

  var countries = List<Country>.empty(growable: true);
  void getCountries() {
    emit(PersonalDetailsGettingCountriesLoadingState());
    countries.clear();
    personalDetailsProvider.getCountries().then((value) {
      for (var country in value.data as List) countries.add(country);
      emit(PersonalDetailsGettingCountriesSuccessState(countries: countries));
    }).catchError((error) {
      emit(PersonalDetailsGettingCountriesFailureState());
    });
  }

  var positions = List<Position>.empty(growable: true);
  void getPositions() {
    emit(PersonalDetailsGettingPositionsLoadingState());
    positions.clear();
    personalDetailsProvider.getPositions().then((value) {
      for (var position in value.positions as List) positions.add(position);
      print(
          '=========================positions===============================');
      print(positions.length);
      emit(PersonalDetailsGettingPositionsSuccessState(countries: positions));
    }).catchError((error) {
      emit(PersonalDetailsGettingPositionsFailureState());
    });
  }

  var genders = List<Gender>.empty(growable: true);
  void getGenders() {
    emit(PersonalDetailsGettingGenderLoadingState());
    genders.clear();
    personalDetailsProvider.getGenders().then((value) {
      for (var gender in value.genders as List) genders.add(gender);
      emit(PersonalDetailsGettingGenderSuccessState());
    }).catchError((error) {
      emit(PersonalDetailsGettingGenderFailureState());
    });
  }

  var religions = List<Religion>.empty(growable: true);
  void getReligions() {
    emit(PersonalDetailsGettingReligionLoadingState());
    religions.clear();
    personalDetailsProvider.getReligions().then((value) {
      for (var religion in value.data as List) religions.add(religion);
      emit(PersonalDetailsGettingReligionsSuccessState());
    }).catchError((error) {
      emit(PersonalDetailsGettingReligionFailureState());
    });
  }

  var maritalStatus = List<MaritalStatus>.empty(growable: true);
  void getMaritalStatus() {
    emit(PersonalDetailsGettingMaritalStatusLoadingState());
    maritalStatus.clear();
    personalDetailsProvider.getMaritalStatus().then((value) {
      for (var marital in value.data as List) maritalStatus.add(marital);
      emit(PersonalDetailsGettingMaritalStatusSuccessState());
    }).catchError((error) {
      emit(PersonalDetailsGettingMaritalStatusFailureState());
    });
  }
}
