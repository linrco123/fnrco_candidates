// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/profile_update/education_qualification.dart';
import 'package:fnrco_candidates/data/models/profile/years_model.dart';
part 'education_and_qualification_state.dart';

class EducationAndQualificationCubit
    extends Cubit<EducationAndQualificationState> {
  EducationAndQualificationProvider educationAndQualificationProvider;
  EducationAndQualificationCubit(
    this.educationAndQualificationProvider,
  ) : super(EducationAndQualificationInitial());

  var formKey = GlobalKey<FormState>();
  final degreeCntroller = TextEditingController();
  final spcCntroller = TextEditingController();
  final eduYrsCntroller = TextEditingController();
  final instituteCntroller = TextEditingController();
  final certCntroller = TextEditingController();
  String yearsId = '';
  int yearsNumber = 1;
  String? certIssueDate;
  String? certExpireDate;
  ///////////////////////////////////////////////////////////
  final yearsNumCntroller = TextEditingController()..text = '1';

  //var ContractServiceAcceptance = false.obs;
  void increaseYearsNumber() {
    yearsNumber++;
    yearsNumCntroller.text = yearsNumber.toString();
  }

  void decreaseyearsNumber() {
    if (yearsNumber > 1) {
      yearsNumber--;
    }
    yearsNumCntroller.text = yearsNumber.toString();
  }

  //void Function(String)? onChanged
  void onChanged(String number) {
    if (number.isEmpty) {
      yearsNumber = 1;
      yearsNumCntroller.text = yearsNumber.toString();
    } else {
      if (number.startsWith('1')) {
        String num = number.split('1')[1];

        yearsNumCntroller.text = '';
        yearsNumCntroller.text = num;
        yearsNumber = int.parse(num);
      } else {
        yearsNumCntroller.text = '';
        yearsNumCntroller.text = number;
        yearsNumber = int.parse(number);
      }
    }
  }

  String? validateDegree(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_degree");
    }
    return null;
  }

  String? validateSpecialization(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_spec");
    }
    return null;
  }

  String? validateYearsNumber(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_years");
    }
    return null;
  }

  String? validateInstitution(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_instit");
    }
    return null;
  }

  String? validateCertification(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_cert");
    }
    return null;
  }

  void selectIssueDate(context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(1950), lastDate: DateTime.now());
    certIssueDate =
        "${pickedDate!.year.toString()}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
    emit(EducationAndQualificationPickingUpCertIssueDate());
    }

  void selectExpiryDate(context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(1950), lastDate: DateTime.now());
    certExpireDate =
        "${pickedDate!.year.toString()}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
    emit(EducationAndQualificationPickingUpCertExpireDate());
    }

  void selectYear(String value) {
    yearsId = value;

    emit(EducationAndQualificationChoosingYearsState());
  }

  var years = List<Year>.empty(growable: true);
  void getYears() {
    emit(EducationGettingYearsLoadingState());
    years.clear();
    educationAndQualificationProvider.getYears().then((value) {
      for (var year in value.years! as List) years.add(year);
      emit(EducationGettingYearsSuccessState(years: years));
    }).catchError((error) {
      emit(EducationGettingYearsFailureState(message: error.failure.message));
    });
  }

  List<Map<String, dynamic>> submittedQualifications = [];
  void addNewEducationAndQualification() {
    if (formKey.currentState!.validate()) {
      if (yearsId != 0 && certIssueDate != null && certExpireDate != null) {
        submittedQualifications.add({
          "edu_degree": degreeCntroller.text,
          "edu_years": yearsNumber.toString(),
          "edu_field_of_study": spcCntroller.text,
          "edu_institution_name": instituteCntroller.text,
          "edu_graduation_year": yearsId,
          "edu_certification_name": certCntroller.text,
          "edu_certification_issues_in": certIssueDate,
          "edu_certification_expiry_in": certExpireDate
        });
        Future.delayed(const Duration(seconds: 1)).then((value) {
          clearFields();
        });
      } else {
        emit(CheckEducationAndQualificationEmptyFieldsState());
      }
    }
  }

  clearFields() {
    degreeCntroller.clear();
    spcCntroller.clear();
    instituteCntroller.clear();
    certCntroller.clear();
    yearsId = '';
    certExpireDate = null;
    certIssueDate = null;
    emit(EmptyEducationAndQualificationFieldsState());
  }


  
  void submit(){
    if(submittedQualifications.isEmpty){
      addNewEducationAndQualification();
      if(submittedQualifications.isNotEmpty){
        _SubmitEducationAndQualification();
      }

    }else{
      _SubmitEducationAndQualification();
    }
  }
  void _SubmitEducationAndQualification() {
    var data = {"educations": submittedQualifications};
    if (submittedQualifications.isNotEmpty) {
      emit(SubmitEducationAndQualificationLoadingState());
      educationAndQualificationProvider
          .submitEducationQualification(data)
          .then((value) {
        emit(SubmitEducationAndQualificationSuccessState());
      }).catchError((error) {
        emit(SubmitEducationAndQualificationFailureState(
            message: error.failure.message));
      });
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    degreeCntroller.dispose();
    spcCntroller.dispose();
    eduYrsCntroller.dispose();
    instituteCntroller.dispose();
    certCntroller.dispose();

    return super.close();
  }
}
