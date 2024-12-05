// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'education_and_qualification_cubit.dart';

@immutable
sealed class EducationAndQualificationState {}

final class EducationAndQualificationInitial extends EducationAndQualificationState {}

class EducationAndQualificationPickingUpCertIssueDate extends EducationAndQualificationState{}


class EducationAndQualificationPickingUpCertExpireDate extends EducationAndQualificationState{}



class EducationAndQualificationChoosingYearsState extends EducationAndQualificationState{}

class EducationGettingYearsLoadingState extends EducationAndQualificationState{}
class EducationGettingYearsSuccessState extends EducationAndQualificationState{
  final List<Year> years;

  EducationGettingYearsSuccessState({required this.years});
}
class EducationGettingYearsFailureState extends EducationAndQualificationState{
  final String message;

  EducationGettingYearsFailureState({required this.message});
}

class ExperiencesGettingYearsLoadingState extends EducationAndQualificationState{}
class ExperiencesGettingYearsSuccessState extends EducationAndQualificationState {
  final List<Year> years;
  ExperiencesGettingYearsSuccessState({
    required this.years,
  });
 }

 
 class  ExperiencesGettingYearsErrorState extends EducationAndQualificationState{
  final String message;

  ExperiencesGettingYearsErrorState({required this.message});
 }


 class CheckEducationAndQualificationEmptyFieldsState extends EducationAndQualificationState{}


 class EmptyEducationAndQualificationFieldsState extends EducationAndQualificationState{


 }


 class SubmitEducationAndQualificationLoadingState extends EducationAndQualificationState{}

  class SubmitEducationAndQualificationSuccessState extends EducationAndQualificationState{}
   class SubmitEducationAndQualificationFailureState extends EducationAndQualificationState{
    final String message;

  SubmitEducationAndQualificationFailureState({required this.message});
   }