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
      polls.add(value.poll!);
      emit(PollsSuccessState(polls: [value.poll!]));
    }).catchError((error) {
      emit(PollsFailureState(message: error.failure.message));
    });
  }

  List<String> pollViewQuestions = [];
  List<Map<String, dynamic>> answers = [];
  int question_number = 0;
  PollView? pollView;
  String answer = '';

  void chooseAnswer(String answer) {
    this.answer = answer;
    emit(ChooseAnswerState());
  }

  void getPollView(int pollViewindex) {
    emit(PollsViewLoadingState());
    pollsProvider.getPollsView(pollViewindex).then((value) {
      pollViewQuestions.add(value!.data!.pollText!);
      answer = value.data!.options!.first.pollOptText!;
      pollView = value.data!;
      emit(PollsViewSuccessState(questions: [value.data!.pollText!]));
    }).catchError((error) {
      emit(PollsFailureState(message: error.failure.message));
    });
  }

  void submitPollViewQuestion(String question) {
    if (answer.isNotEmpty) {
      if (question_number < pollViewQuestions.length - 1) {
        addNewAnswer(question);
      } else {
        addNewAnswer(question);
        // answer = '';
        sendPollView();
      }
    } else {
      emit(PickPollAnswerState());
    }
  }

  void sendPollView() {
    emit(SubmitPollViewLoadingState());
    //Map data = {"answers": answers};
    Map data = answers.single;
    print('===============polls==================');
    print(data);
    pollsProvider.sendPollView(data).then((value) {
      if (value == true) {
        question_number = 0;
        emit(SubmitPollViewSuccessState());
      }
    }).catchError((error) {
      emit(SubmitPollViewFailureState());
    });
  }

  void addNewAnswer(String question) {
    answers.add({
      "poll_id": pollView!.id,
      "poll_option_id": pollView!.options!
          .where((poll) => poll.pollOptText == answer)
          .toList()
          .single
          .id!
    });

    answer = '';
    if (question_number < pollViewQuestions.length - 1) {
      moveTONext();
    }
  }

  void moveTONext() {
    question_number++;
    emit(MoveToNextQuestionsState());
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
