// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:fnrco_candidates/data/models/management_content/poll_view_model.dart';
import 'package:fnrco_candidates/data/models/management_content/polls_model.dart';
import 'package:meta/meta.dart';
import 'package:fnrco_candidates/data/api_provider/management_content/polls.dart';
part 'polls_state.dart';

class PollsCubit extends Cubit<PollsState> {
  PollsProvider pollsProvider;
  PollsCubit(
    this.pollsProvider,
  ) : super(PollsInitial());

  List<Poll> polls = [];
  void getPolls() {
    emit(PollsLoadingState());
    pollsProvider.getPolls().then((value) {
      polls.addAll(value.polls!);
      
      emit(PollsSuccessState(polls: value.polls!));
    }).catchError((error) {
      emit(PollsFailureState(message: error.failure.message));
    });
  }

  List<PQuestion> pollViewQuestions = [];
  List<Map<String, dynamic>> answers = [];
  int question_number = 0;
  int pollViewID = 0;

  String answer = '';
  void chooseAnswer(String answer) {
    this.answer = answer;
    emit(ChooseAnswerState());
  }

  void getPollView(int pollViewindex) {
    emit(PollsViewLoadingState());
    pollsProvider.getPollsView(pollViewindex).then((value) {
      pollViewQuestions = value!.questions!;
      answer = value.questions!.first.options!.first.pollOptText!;
     // pollViewID = value;
      emit(PollsViewSuccessState(
          questions: value.questions!));
    }).catchError((error) {
      emit(PollsFailureState(message: error.failure.message));
    });
  }

  void submitPollViewQuestion(int questionID) {
    if (answer.isNotEmpty) {
      if (question_number < pollViewQuestions.length - 1) {
      addNewAnswer(questionID);
    } else {
      answers.add({
        "poll_question_id": questionID.toString(),
        "poll_answer_text": answer
      });
     // answer = '';
      sendPollView();
    }
    }else{
      emit(PickPollAnswerState());
    }
  }

  void sendPollView() {
    emit(SubmitPollViewLoadingState());
    Map data = {"answers": answers};
    print('===============polls==================');
    print(data);
    pollsProvider.sendPollView(pollViewID, data).then((value) {
      if (value == true) {
        question_number = 0;
        emit(SubmitPollViewSuccessState());
      }
    }).catchError((error) {
      emit(SubmitPollViewFailureState());
    });
  }

  void addNewAnswer(int questionID) {
    answers.add({
      "poll_question_id": questionID.toString(),
      "poll_answer_text": answer
    });
    answer = '';

    moveTONext();
  }

  void moveTONext() {
    question_number++;
    emit(MoveToNextQuestionsState());
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }







}
