part of 'unregistered_cubit.dart';

@immutable
sealed class UnregisteredState {}

final class UnregisteredInitial extends UnregisteredState {}



class GetJobsLoadingState extends UnregisteredState{}


 class GetJobsSuccessState extends UnregisteredState{
  final List<Job> jobs;

  GetJobsSuccessState({required this.jobs});
 }
 
 class GetJobsFailureState extends UnregisteredState{
  final String message;

  GetJobsFailureState({required this.message});
 }

 
 class SearchJobsSuccessState extends UnregisteredState{
  final List<Job> jobs;

  SearchJobsSuccessState({required this.jobs});
 }