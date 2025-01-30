part of 'unregistered_cubit.dart';

@immutable
sealed   class  UnregisteredState {}

final   class  UnregisteredInitial extends UnregisteredState {}



final class  GetJobsLoadingState extends UnregisteredState{}


 final class  GetJobsSuccessState extends UnregisteredState{
  final List<Job> jobs;

  GetJobsSuccessState({required this.jobs});
 }
 
 final class  GetJobsFailureState extends UnregisteredState{
  final String message;

  GetJobsFailureState({required this.message});
 }

 
 final class  SearchJobsSuccessState extends UnregisteredState{
  final List<Job> jobs;

  SearchJobsSuccessState({required this.jobs});
 }