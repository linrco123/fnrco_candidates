import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_personal_details_state.dart';

class GetPersonalDetailsCubit extends Cubit<GetPersonalDetailsState> {
  GetPersonalDetailsCubit() : super(GetPersonalDetailsInitial());



  void getPersonalDetails(){
    
  }
}
