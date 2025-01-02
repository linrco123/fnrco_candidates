// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/constants/app_pages_names.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/data/api_provider/welcome_provider.dart';

import 'package:fnrco_candidates/data/models/management_content/polls_model.dart';
import 'package:fnrco_candidates/data/models/management_content/survies_model.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  final WelcomeProvider welcomeProvider;
  WelcomeCubit(
    this.welcomeProvider,
  ) : super(WelcomeInitial());

  final polls = List<Poll>.empty(growable: true);
  final surveys = List<Survey>.empty(growable: true);

  void getPolls() {
    welcomeProvider.getPolls().then((value) {
      print('polls length  ================>>>> ${value.poll!.pollText}');
      polls.add(value.poll!);
    });
  }

  void getsurveys() {
    welcomeProvider.getSurveys().then((value) {
      print('polls length  ================>>>> ${value.survey!.id}');
      surveys.add(value.survey!);
    });
  }

  Future<void> moveToNextPage(context) async {
    if (CacheHelper.getPoll() == true) {
      handleTransition(context);
    } else if (CacheHelper.getPoll() == null) {
      if (polls.isEmpty) {
        handleTransition(context);
      } else if (polls.isNotEmpty) {
        CacheHelper.setPoll();
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppPagesNames.POLLS, (Route<dynamic> route) => false);
      }
    }
  }

  Future<void> handleTransition(context) async {
      if (await CacheHelper.getAuthToken() != null) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppPagesNames.HOMEPAGE, (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppPagesNames.AUTH, (Route<dynamic> route) => false);
      }
  }
}
