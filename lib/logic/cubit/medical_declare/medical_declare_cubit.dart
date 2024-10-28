import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'medical_declare_state.dart';

class MedicalDeclareCubit extends Cubit<MedicalDeclareState> {
  MedicalDeclareCubit() : super(MedicalDeclareInitial());

  static MedicalDeclareCubit instance(context) => BlocProvider.of(context);

  int chosenRadioItem = 0;
  void changeRadioItem(int value){
    chosenRadioItem = value;
    emit(MedicalDeclarePickListRadionItemState());

  }
}
