// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:fnrco_candidates/data/api_provider/overview_provider.dart';
import 'package:fnrco_candidates/data/models/job_offer_model.dart';
import 'package:fnrco_candidates/data/models/overview_model.dart';
import 'package:meta/meta.dart';

part 'overview_state.dart';

class OverviewCubit extends Cubit<OverviewState> {
  OverviewProvider overViewProvider;

  OverviewCubit(
    this.overViewProvider,
  ) : super(OverviewInitial());

  final jobApplications = List<JobApplication>.empty(growable: true);
  getJobApplications() {
    emit(GetJobApplicationsLoadingState());
    jobApplications.clear();
    overViewProvider.getJobApplications().then((value) {
      jobApplications.addAll(value.applications!);
      emit(GetJobApplicationsSuccessState(applications: value.applications!));
    }).catchError((error) {
      emit(GetJobApplicationsFailureState(message: error.failure.message));
    });
  }

  void getOverViewData(int appId) {
    emit(GetOverviewDataLoadingState());
    overViewProvider.getOverViewData(appId).then((value) {
      emit(GetOverviewDataSuccessState(overviewData: value.overviewData!));
    }).catchError((error) {
      emit(GetOverviewDataFailureState(message: error.failure.message));
    });
  }

}
