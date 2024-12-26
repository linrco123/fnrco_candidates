part of 'home_page_cubit.dart';

@immutable
sealed class HomePageState {}

final class HomePageInitial extends HomePageState {}
final class HomePageChangeState extends HomePageState {}


final class LogoutLoadingState extends HomePageState{}
final class LogoutSuccessState extends HomePageState{}
final class LogoutFailureState extends HomePageState{
  final String error;

  LogoutFailureState({required this.error});
}


final class GetJobsLoadingState extends HomePageState{}

final class GetJobsSuccessState extends HomePageState{
  final List<Job> jobs;

  GetJobsSuccessState({required this.jobs});
}


final class GetJobsFailureState extends HomePageState{
  final String message;

  GetJobsFailureState({required this.message});
}

class HomePageGetAppliedJobsLoadingState extends HomePageState{}

class HomePageGetAppliedJobsSuccessState extends HomePageState{}

class HomePageGetAppliedJobsFailureState extends HomePageState{
  final String message;

  HomePageGetAppliedJobsFailureState({required this.message});

}
