import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'survey_view_state.dart';

class SurveyViewCubit extends Cubit<SurveyViewState> {
  SurveyViewCubit() : super(SurveyViewInitial());
}
