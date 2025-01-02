// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:fnrco_candidates/data/api_provider/local_process.dart';

part 'local_process_state.dart';

class LocalProcessCubit extends Cubit<LocalProcessState> {
  LocalProcessProvider localProcessProvider;
  LocalProcessCubit(
    this.localProcessProvider,
  ) : super(LocalProcessInitial());

  getLocalProcessData() {
    emit(GetLocalProcessDataLoadingState());
    localProcessProvider
        .getLocalProcess()
        .then((value) {
        emit(GetLocalProcessDataSuccessState(data:[]));  
        })
        .catchError((error) {
          emit(GetLocalProcessDataFailureState(message:error.failure.message));
        });
  }

  
}
