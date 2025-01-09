// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/profile_update/work_experiences.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/countries_model.dart';
part 'experience_state.dart';

class ExperienceCubit extends Cubit<ExperienceState> {
  ExperienceProvider experienceProvider;
  ExperienceCubit(
    this.experienceProvider,
  ) : super(ExperienceInitial());

  var formKey = GlobalKey<FormState>();
  final jobTitleCntroller = TextEditingController();
  final companyCntroller = TextEditingController();
  final jobDescCntroller = TextEditingController();
  String countryId = '';
  String? startDate;
  String? endDate;

  String? validateJobTitle(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_job_title");
    }
    return null;
  }

  String? validateCompany(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_company");
    }
    return null;
  }

  String? validateDescription(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_job_description");
    }
    return null;
  }

  void selectStartDate(context) async {
    DateTime? birthofDate = await showDatePicker(
        context: context, firstDate: DateTime(1950), lastDate: DateTime.now());
    startDate =
        "${birthofDate!.year.toString()}-${birthofDate.month.toString().padLeft(2, '0')}-${birthofDate.day.toString().padLeft(2, '0')}";
    emit(ExperiencesPickingUpStartDate());
    }

  void selectEndDate(context) async {
    DateTime? birthofDate = await showDatePicker(
        context: context, firstDate: DateTime(1950), lastDate: DateTime.now());
    endDate =
        "${birthofDate!.year.toString()}-${birthofDate.month.toString().padLeft(2, '0')}-${birthofDate.day.toString().padLeft(2, '0')}";
    emit(ExperiencesPickingUpEndDate());
    }

  void selectCountry(String value) {
    countryId = value;

    emit(WorkExperienceChoosingCountryState());
  }

  var countries = List<Country>.empty(growable: true);
  void getCountries() {
    emit(ExperiencesGettingCountriesLoadingState());
    countries.clear();
    experienceProvider.getCountries().then((value) {
      for (var country in value.data as List) countries.add(country);
      emit(ExperiencesGettingCountriesSuccessState(countries: countries));
    }).catchError((error) {
      emit(ExperiencesGettingCountriesErrorState(
          message: error.failure.message));
    });
  }

  List<Map<String, dynamic>> submittedExperiences = [];
  void addNewExperience() {
    if (formKey.currentState!.validate()) {
      if (countryId != '' && startDate != null && endDate != null) {
        submittedExperiences.add({
          "experience_job_title": jobTitleCntroller.text,
          "experience_company": companyCntroller.text,
          "experience_start_in": startDate,
          "experience_end_in": endDate,
          "country_id": countries
              .where((country) => country.countryName == countryId)
              .toList()
              .first
              .id,
              "experience_description":jobDescCntroller.text
        });
        Future.delayed(const Duration(seconds: 1)).then((value) {
          clearFields();
        });
      } else {
        emit(CheckExperienceEmptyFieldsState());
      }
    }
  }

  clearFields() {
    jobTitleCntroller.clear();
    companyCntroller.clear();
    jobDescCntroller.clear();
    countryId = '';
    startDate = null;
    endDate = null;
    emit(EmptyExperienceFieldsState());
  }

  void submit(){
    if(submittedExperiences.isEmpty){
      addNewExperience();
      if(submittedExperiences.isNotEmpty){
        _submitWorkExperience();
      }

    }else{
      _submitWorkExperience();
    }
  }

  void _submitWorkExperience() {
    var data = {"experiences": submittedExperiences};
    if (submittedExperiences.isNotEmpty) {
      emit(SubmitWorkExperienceLoadingState());
      experienceProvider.submitExperiences(data).then((value) {
        emit(SubmitWorkExperienceSuccessState());
      }).catchError((error) {
        emit(SubmitWorkExperienceFailureState(message: error.failure.message));
      });
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    jobTitleCntroller.dispose();
    companyCntroller.dispose();
    jobDescCntroller.dispose();

    return super.close();
  }
}
