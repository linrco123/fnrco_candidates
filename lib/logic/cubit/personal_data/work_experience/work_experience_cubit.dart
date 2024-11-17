import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'work_experience_state.dart';

class WorkExperienceCubit extends Cubit<WorkExperienceState> {
  WorkExperienceCubit() : super(WorkExperienceInitial());
}
