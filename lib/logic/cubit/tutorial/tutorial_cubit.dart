// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:fnrco_candidates/data/models/tutorial_model.dart';
import 'package:meta/meta.dart';

import 'package:fnrco_candidates/data/api_provider/tutorial_provider.dart';

part 'tutorial_state.dart';

class TutorialCubit extends Cubit<TutorialState> {
  TutorialProvider tutorialProvider;
  TutorialCubit(
    this.tutorialProvider,
  ) : super(TutorialInitial());

  var tutorials = List<Tutorial>.empty(growable: true);
  void getTutorials() {
    emit(TutorialLoadingState());
    tutorialProvider.getTutorials().then((value) {
      emit(TutorialSuccessState(tutorials: value.tutorials!));
    }).catchError((error) {
      emit(TutorialFailureState(message: error.failure.message));
    });
  }
}
