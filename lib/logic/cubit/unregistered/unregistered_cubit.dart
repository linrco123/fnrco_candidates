// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:fnrco_candidates/data/api_provider/home/home_tap_provider.dart';
import 'package:fnrco_candidates/data/models/home/jobs_model.dart';

part 'unregistered_state.dart';

class UnregisteredCubit extends Cubit<UnregisteredState> {
  HomePageProvider homePageProvider;
  UnregisteredCubit(
    this.homePageProvider,
  ) : super(UnregisteredInitial());
  
  final searchController = TextEditingController();
  var searchedJobs = List<Job>.empty(growable: true);
  var jobs = List<Job>.empty(growable: true);
  
  void searchAJob() {
    if(searchController.text.isNotEmpty){
       searchedJobs = jobs
        .where((job) => job.position!
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();
    emit(SearchJobsSuccessState(jobs: searchedJobs));
    }
   
  }

  getJobs() {
    emit(GetJobsLoadingState());
    homePageProvider.getJobs().then((value) {
      jobs.addAll(value.jobs!);
      emit(GetJobsSuccessState(jobs: jobs));
    }).catchError((error) {
      emit(GetJobsFailureState(message: error.failure.message));
    });
  }
}
