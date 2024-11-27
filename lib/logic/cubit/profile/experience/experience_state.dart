part of 'experience_cubit.dart';

@immutable
sealed class ExperienceState {}

final class ExperienceInitial extends ExperienceState {}

final class ExperiencesGettingCountriesLoadingState extends ExperienceState{

}

final class ExperiencesGettingCountriesSuccessState extends ExperienceState{
  final List<Country> countries;

  ExperiencesGettingCountriesSuccessState({required this.countries});
  
}
final class ExperiencesGettingCountriesErrorState extends ExperienceState{
  final String message;

  ExperiencesGettingCountriesErrorState({required this.message});
  
}

class ExperiencesChooseCountryState extends ExperienceState{

}

class ExperiencesPickingUpStartDate extends ExperienceState{}

class ExperiencesPickingUpEndDate extends ExperienceState{}


class WorkExperienceChoosingCountryState extends ExperienceState{}

class EmptyExperienceFieldsState extends ExperienceState{}
class CheckExperienceEmptyFieldsState extends ExperienceState{}

class SubmitWorkExperienceLoadingState extends ExperienceState{}
class SubmitWorkExperienceSuccessState extends ExperienceState{}
class SubmitWorkExperienceFailureState extends ExperienceState{
  final String message;

  SubmitWorkExperienceFailureState({required this.message});
}

