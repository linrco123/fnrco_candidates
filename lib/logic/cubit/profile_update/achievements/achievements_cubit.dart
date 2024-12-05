// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/core/functions/translate.dart';
import 'package:fnrco_candidates/data/api_provider/profile_update/achievements.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

part 'achievements_state.dart';

class AchievementsCubit extends Cubit<AchievementsState> {
  AchievementsProvider achievementsProvider;
  AchievementsCubit(
    this.achievementsProvider,
  ) : super(AchievementsInitial());

  var formKey = GlobalKey<FormState>();
  final TextEditingController achvCntroller = TextEditingController();

  String? validateAch(context, String? value) {
    if (value!.isEmpty) {
      return translateLang(context, "msg_plz_enter_ach");
    }
    return null;
  }

  List<Map<String, dynamic>> submittedAchievements = [];
  void addNewAchievement() {
    if (formKey.currentState!.validate()) {
      submittedAchievements.add({"achievement_text": achvCntroller.text});
      Future.delayed(const Duration(seconds: 1)).then((value) {
        clearFields();
      });
    }
  }

  clearFields() {
    achvCntroller.clear();
    emit(EmptyAchievementsFieldsState());
  }

  void submitAchievements() {
    print('===============achievements============');
    logger.d(submittedAchievements);
    var data = {"achievements": submittedAchievements};
    if (submittedAchievements.isNotEmpty) {
      emit(SubmitAchievementsLoadingState());
      achievementsProvider.submitAChievements(data).then((value) {
        emit(SubmitAchievementsSuccessState());
      }).catchError((error) {
        emit(SubmitAchievementsFailureState(message: error.failure.message));
      });
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    achvCntroller.dispose();
    return super.close();
  }
}
