import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_achievements_state.dart';

class GetAchievementsCubit extends Cubit<GetAchievementsState> {
  GetAchievementsCubit() : super(GetAchievementsInitial());
}
