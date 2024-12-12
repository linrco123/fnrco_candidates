part of 'job_application_cubit.dart';

@immutable
sealed class JobApplicationState {}

final class JobApplicationInitial extends JobApplicationState {}

final class JobApplicationLoadingState extends JobApplicationState {}

final class JobApplicationSuccessState extends JobApplicationState {}

final class JobApplicationFailureState extends JobApplicationState {
  final String error;

  JobApplicationFailureState({required this.error});
}

//Delete resume chosen

final class JobApplicationDeletionResumeState extends JobApplicationState {}

final class JobApplicationUploadResumeState extends JobApplicationState {}
