part of 'resume_cubit.dart';

@immutable
sealed class ResumeState {}

final class ResumeInitial extends ResumeState {}


final class ResumePickAttachmentFileState extends ResumeState{}