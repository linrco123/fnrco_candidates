// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/data/models/management_content/classification_model.dart';
import 'package:fnrco_candidates/data/models/medical_questions.dart';

import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/medical_declare.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/countries_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/gender_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/marital_status_model.dart';
import 'package:toastification/toastification.dart';

part 'medical_declare_state.dart';

class MedicalDeclareCubit extends Cubit<MedicalDeclareState> {
  MedicalDeclareProvider medicalDeclareProvider;
  MedicalDeclareCubit(
    this.medicalDeclareProvider,
  ) : super(MedicalDeclareInitial());

  static MedicalDeclareCubit instance(context) => BlocProvider.of(context);

  //personal data
  final nameCntroller = TextEditingController();
  final phone1Cntroller = TextEditingController();
  final identity1Cntroller = TextEditingController();

  // family data
  final employeeCntroller = TextEditingController();
  final phone2Cntroller = TextEditingController();
  final identity2Cntroller = TextEditingController();
  final relationCntroller = TextEditingController();
  final heightCntroller = TextEditingController();
  final weightCntroller = TextEditingController();

  int currentStep = 1;
  var formKey = GlobalKey<FormState>();
  String countryId = '';
  String gender1Id = '';
  String gender2Id = '';
  String maritalStatusId = '';
  String relation = '';

  void submitPersonal(context) {
    if (countryId == '') {
      showToast(context,
          title: translateLang(context, 'warning'),
          desc: translateLang(context, "choose_country"),
          type: ToastificationType.warning);
    } else if (gender1Id == '') {
      showToast(context,
          title: translateLang(context, 'warning'),
          desc: translateLang(context, "choose_gender"),
          type: ToastificationType.warning);
    } else if (maritalStatusId == '') {
      showToast(context,
          title: translateLang(context, 'warning'),
          desc: translateLang(context, "choose_marital"),
          type: ToastificationType.warning);
    } else {
      if (formKey.currentState!.validate()) {
        var personalData = {};
        _incrementStepper();
      }
    }
  }

  final answerCntroller = TextEditingController();
  String date = '';
  String switchAnswer = '';

  void changeYesOrNo(String value) {
    switchAnswer = value;
    emit(ChangerYesOrNoState());
  }

  void selectDate(context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(1950), lastDate: DateTime.now());
    date =
        "${pickedDate!.year.toString()}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
    emit(MedicalChooseDateState());
  }

  int currentQuestion = 0;
  final answers = List<Map<String, dynamic>>.empty(growable: true);
  void submit(context) {
    if (currentStep == 1) {
      submitPersonal(context);
    } else if (currentStep == 2) {
      if (currentQuestion < mQuestions.length - 1) {
        if (answerCntroller.text.isNotEmpty ||
            date.isNotEmpty ||
            switchAnswer.isNotEmpty) {
          _storeAnswer(mQuestions[currentQuestion].type!);
          _clearDeclarationFields();
          _nextQuestion();
        } else {
          emit(MedicalSubmitAnswerState());
        }
      } else {
        if (answerCntroller.text.isNotEmpty ||
            date.isNotEmpty ||
            switchAnswer.isNotEmpty) {
          _storeAnswer(mQuestions[currentQuestion].type!);
          _incrementStepper();
        } else {
          emit(MedicalSubmitAnswerState());
        }
      }
    } else if (currentStep == 3) {
      _submitMedicalData();
    }
  }

  void _submitMedicalData() {
    if (formKey.currentState!.validate()) {}
  }

  void _nextQuestion() {
    currentQuestion++;
    emit(MoveToNextQuestionsState());
  }

  void _clearDeclarationFields() {
    answerCntroller.clear();
    date = '';
    switchAnswer = '';
  }

  // void _clearPersonalFields() {
  //   nameCntroller.clear();
  //   phoneCntroller.clear();
  //   identityCntroller.clear();
  //   countryId = '';
  //   genderId = '';
  //   maritalStatusId = '';
  // }

  void _storeAnswer(String type) {
    switch (type) {
      case 'switch':
        answers.add({
          "q": mQuestions[currentQuestion].id,
          "a": switchAnswer,
        });
        break;
      case 'text':
        answers.add({
          "q": mQuestions[currentQuestion].id,
          "a": answerCntroller.text,
        });
        break;
      case 'date':
        answers.add({
          "q": mQuestions[currentQuestion].id,
          "a": date,
        });
        break;
      default:
    }
  }

  var mQuestions = List<MedicalQuestion>.empty(growable: true);
  void getMedicalQuestions() {
    emit(GetMedicalQuestionsLoadingState());
    medicalDeclareProvider.getMedQuestions().then((value) {
      mQuestions.addAll(value.data!);
      emit(GetMedicalQuestionsSuccessState());
    }).catchError((error) {
      emit(GetMedicalQuestionsFailureState());
    });
  }

  void _incrementStepper() {
    if (currentStep < 3) {
      currentStep++;
    }
    emit(MedicalDeclarationIncrementStepperState());
  }

  void selectCountry(String value) {
    countryId = value;
    print(value);

    emit(MedicalDeclareChoosingCountryState());
  }

  void selectGender1(String value) {
    gender1Id = value;
    print(value);

    emit(MedicalDeclareChoosingGenderState());
  }

  void selectGender2(String value) {
    gender2Id = value;
    print(value);

    emit(MedicalDeclareChoosingGenderState());
  }

  void selectRelation(String value) {
    relation = value;

    emit(MedicalDeclareChoosingRelationState());
  }

  void selectMaritalStatus(String value) {
    maritalStatusId = value;
    print(value);

    emit(MedicalDeclareChoosingReligionState());
  }

  String? validateAnswer(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_answer");
    }
    return null;
  }

  String? validateName(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_first_name");
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

  String? validateIdentity(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_identity");
    }
    return null;
  }

  String? validateRelation(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_relation");
    }
    return null;
  }

  String? validateHeight(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_height");
    }
    return null;
  }

  String? validateWeight(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_weight");
    }
    return null;
  }

  var countries = List<Country>.empty(growable: true);
  void getCountries() {
    emit(MedicalDeclareettingCountriesLoadingState());
    countries.clear();
    medicalDeclareProvider.getCountries().then((value) {
      for (var country in value.data as List) countries.add(country);
      emit(MedicalDeclareGettingCountriesSuccessState(countries: countries));
    }).catchError((error) {
      emit(MedicalDeclareGettingCountriesFailureState());
    });
  }

  var genders = List<Gender>.empty(growable: true);
  void getGenders() {
    emit(MedicalDeclareGettingGenderLoadingState());
    genders.clear();
    medicalDeclareProvider.getGenders().then((value) {
      for (var gender in value.genders as List) genders.add(gender);
      emit(MedicalDeclareGettingGenderSuccessState());
    }).catchError((error) {
      emit(MedicalDeclareGettingGenderFailureState());
    });
  }

  var maritalStatus = List<MaritalStatus>.empty(growable: true);
  void getMaritalStatus() {
    emit(MedicalDeclareGettingMaritalStatusLoadingState());
    maritalStatus.clear();
    medicalDeclareProvider.getMaritalStatus().then((value) {
      for (var marital in value.data as List) maritalStatus.add(marital);
      emit(MedicalDeclareGettingMaritalStatusSuccessState());
    }).catchError((error) {
      emit(MedicalDeclareGettingMaritalStatusFailureState());
    });
  }

  var classifications = List<Classification>.empty(growable: true);
  getClasifications() {
    emit(MedicalDeclareGettingClassificationsLoadingState());
    maritalStatus.clear();
    medicalDeclareProvider.getClassifications().then((value) {
      for (var classification in value.classifications as List)
        classifications.add(classification);
      emit(MedicalDeclareGettingClassificationsSuccessState());
    }).catchError((error) {
      emit(MedicalDeclareGettingClassificationsFailureState());
    });
  }
}
