// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/core/functions/show_toast.dart';
import 'package:fnrco_candidates/data/models/management_content/classification_model.dart';
import 'package:fnrco_candidates/data/models/medical_declaration_app_model.dart';
import 'package:fnrco_candidates/data/models/medical_questions.dart';

import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/medical_declare.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/countries_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/gender_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/marital_status_model.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
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
  final phoneCntroller = TextEditingController();
  final passportCntroller = TextEditingController();
  final heightCntroller = TextEditingController();
  final weightCntroller = TextEditingController();

  int currentStep = 1;
  var formKey = GlobalKey<FormState>();
  String countryId = '';
  String genderId = '';
  String maritalStatusId = '';
  String relation = '';

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
  void submit(context, int appID) {
    if (currentStep == 1) {
      _incrementStepper();
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
      if (dependents.isEmpty) {
        emit(EnterOneFamilyMemberAtLeastState());
      } else {
        sendMedicalDeclare(appID);
      }
    }
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

  void _storeAnswer(String type) {
    switch (type) {
      case 'radio':
        answers.add({
          "umdf_item_id": mQuestions[currentQuestion].id,
          "person_umdf_value": mapYesNoTo10(switchAnswer),
        });
        break;
      case 'text':
        answers.add({
          "umdf_item_id": mQuestions[currentQuestion].id,
          "person_umdf_value": answerCntroller.text,
        });
        break;
      case 'date':
        answers.add({
          "umdf_item_id": mQuestions[currentQuestion].id,
          "person_umdf_value": date,
        });
        break;

      default:
        answers.add({
          "umdf_item_id": mQuestions[currentQuestion].id,
          "person_umdf_value": answerCntroller.text,
        });
      // break;
    }
  }

  int mapYesNoTo10(String answer) {
    if (answer == 'yes') {
      return 1;
    } else {
      return 0;
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
final medicalApplications = List<MedicalDeclarationApp>.empty(growable: true);
  void getMedicalApplications() {
    emit(GetMedicalApplicationsLoadingState());
    medicalDeclareProvider.getMedicalApplications().then((value) {
      medicalApplications.addAll(value.applications!);
      emit(GetMedicalApplicationsSuccessState(
          applications: value.applications!));
    }).catchError((error) {
      emit(GetMedicalApplicationsFailureState(message: error.failure.message));
    });
  }

  var dependents = List<Map<String, dynamic>>.empty(growable: true);

  void addNewRelative(context) {
    logger.e('=-======================================');
    if (genderId == '') {
      showToast(context,
          title: translateLang(context, 'warning'),
          desc: translateLang(context, "choose_gender"),
          type: ToastificationType.warning);
    } else if (relation == '') {
      showToast(context,
          title: translateLang(context, 'warning'),
          desc: translateLang(context, "choose_relation"),
          type: ToastificationType.warning);
    } else if (date == '') {
      showToast(context,
          title: translateLang(context, 'warning'),
          desc: translateLang(context, "choose_date"),
          type: ToastificationType.warning);
    } else {
      if (formKey.currentState!.validate()) {
        dependents.add(
          {
            "relation_classification_id": classifications
                .where((classifi) => classifi.metaDataText! == relation)
                .toList()
                .single
                .id!,
            "dependent_name": nameCntroller.text,
            "dependent_gender": genderId,
            "dependent_dob": date,
            "dependent_passport": passportCntroller.text,
            "dependent_boarder_number": null,
            "dependent_phone": phoneCntroller.text,
            "dependent_weight": weightCntroller.text,
            "dependent_weight_unit": "kg",
            "dependent_height": heightCntroller.text,
            "dependent_height_unit": "cm"
          },
        );
      }
      Future.delayed(const Duration(seconds: 1)).then((value) {
        _clearFamilyFields();
      });
    }
  }

  void sendMedicalDeclare(int candidate_app_id) {
    emit(SendMedicalDeclareLoadingState());
    var data = {
      // "identity_number": "5656565656",
      //"person_umdf_company_id": 63,
      "person_id": CacheHelper.getID(),
      "candidate_application_hdf_id": candidateApplicationHdfId,
      "items": answers,
      "dependent": dependents
    };
    logger.e('=================medical declaration==================');
    logger.e(data);

    medicalDeclareProvider.sendMedicalDeclare(data).then((data) {
      emit(SendMedicalDeclareSuccessState());
    }).catchError((error) {
      emit(SendMedicalDeclareFailureState(message: error.failure.message));
    });
  }

  _clearFamilyFields() {
    nameCntroller.clear();
    passportCntroller.clear();
    phoneCntroller.clear();
    weightCntroller.clear();
    heightCntroller.clear();
    date = '';
    emit(MedicalDeclarationClearState());
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

  void selectGender(String value) {
    genderId = value;
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

  String? validatePasport(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_passport");
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

  int? candidateApplicationHdfId;
  void storeHDF(int? candidateApplicationHdfId) {
    this.candidateApplicationHdfId = candidateApplicationHdfId;
  }
}
