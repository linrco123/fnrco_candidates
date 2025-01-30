// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'education_and_qualification_cubit.dart';

@immutable
sealed   class  EducationAndQualificationState {}

final   class  EducationAndQualificationInitial extends EducationAndQualificationState {}

final class  EducationAndQualificationPickingUpCertIssueDate extends EducationAndQualificationState{}


final class  EducationAndQualificationPickingUpCertExpireDate extends EducationAndQualificationState{}



final class  EducationAndQualificationChoosingYearsState extends EducationAndQualificationState{}

final class  EducationGettingYearsLoadingState extends EducationAndQualificationState{}
final class  EducationGettingYearsSuccessState extends EducationAndQualificationState{
  final List<Year> years;

  EducationGettingYearsSuccessState({required this.years});
}
final class  EducationGettingYearsFailureState extends EducationAndQualificationState{
  final String message;

  EducationGettingYearsFailureState({required this.message});
}

final class  ExperiencesGettingYearsLoadingState extends EducationAndQualificationState{}
final class  ExperiencesGettingYearsSuccessState extends EducationAndQualificationState {
  final List<Year> years;
  ExperiencesGettingYearsSuccessState({
    required this.years,
  });
 }

 
 final class   ExperiencesGettingYearsErrorState extends EducationAndQualificationState{
  final String message;

  ExperiencesGettingYearsErrorState({required this.message});
 }


 final class  CheckEducationAndQualificationEmptyFieldsState extends EducationAndQualificationState{}


 final class  EmptyEducationAndQualificationFieldsState extends EducationAndQualificationState{


 }


 final class  SubmitEducationAndQualificationLoadingState extends EducationAndQualificationState{}

  final class  SubmitEducationAndQualificationSuccessState extends EducationAndQualificationState{}
   final class  SubmitEducationAndQualificationFailureState extends EducationAndQualificationState{
    final String message;

  SubmitEducationAndQualificationFailureState({required this.message});
   }