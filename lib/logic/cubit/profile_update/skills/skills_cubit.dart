// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/profile_update/skills.dart';
import 'package:fnrco_candidates/data/models/profile/skills_model.dart';

part 'skills_state.dart';

class SkillsCubit extends Cubit<SkillsState> {
  SkillsProvider skillsProvider;
  SkillsCubit(
    this.skillsProvider,
  ) : super(SkillsInitial());

  // final jobTitleCntroller = TextEditingController();
  // final companyCntroller = TextEditingController();
  // final descCntroller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final skillsCntroller = TextEditingController();
  String skillLevel = '';

  String? validateSkill(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_skill");
    }
    return null;
  }

  void chooseSkill(String Level) {
    skillLevel = Level;
    emit(ChooseSkillLevelState());
  }

  var skills = List<Skill>.empty(growable: true);
  void getSkills() {
    emit(GettingSkillsLevelLoadingState());
    skills.clear();
    skillsProvider.getSkills().then((value) {
      for (var skill in value.data as List) skills.add(skill);
      emit(GettingSkillsLevelSuccessState(skills));
    }).catchError((error) {
      emit(GettingSkillsLevelErrorState(message: error.failure.messse));
    });
  }

  List<Map<String, dynamic>> submittedSkills = [];
  void addNewSkill() {
    if (formKey.currentState!.validate()) {
      if (skillLevel != 0) {
        submittedSkills.add({
          "id": skills
              .where((skill) => skill.metaDataText == skillLevel)
              .toList()
              .single
              .id,
          "skill_name": skillsCntroller.text,
          "skill_level": skillLevel
        });
        Future.delayed(const Duration(seconds: 1)).then((value) {
          skillsCntroller.clear();
          skillLevel = '';
          emit(EmptySkillLevelstate());
        });
      } else {
        emit(CheckSkillLevelState());
      }
    }
  }

  void submit() {
    if (submittedSkills.isEmpty) {
      addNewSkill();
      if (submittedSkills.isNotEmpty) {
        _submitSkills();
      }
    } else {
      _submitSkills();
    }
  }

  void _submitSkills() {
    var data = {"skills": submittedSkills};
    if (submittedSkills.isNotEmpty) {
      emit(SubmitSkillsLoadingState());
      skillsProvider.submitSkills(data).then((value) {
        emit(SubmitSkillsSuccessState());
      }).catchError((error) {
        emit(SubmitSkillsFailureState(message: error.failure.message));
      });
    }
  }
}
