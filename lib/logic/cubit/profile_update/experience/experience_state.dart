part of 'experience_cubit.dart';

@immutable
sealed   class  ExperienceState {}

  final class  ExperienceInitial extends ExperienceState {}

  final class  ExperiencesGettingCountriesLoadingState extends ExperienceState{

}

  final class  ExperiencesGettingCountriesSuccessState extends ExperienceState{
  final List<Country> countries;

  ExperiencesGettingCountriesSuccessState({required this.countries});
  
}
  final class  ExperiencesGettingCountriesErrorState extends ExperienceState{
  final String message;

  ExperiencesGettingCountriesErrorState({required this.message});
  
}

final class  ExperiencesChooseCountryState extends ExperienceState{

}

final class  ExperiencesPickingUpStartDate extends ExperienceState{}

final class  ExperiencesPickingUpEndDate extends ExperienceState{}


final class  WorkExperienceChoosingCountryState extends ExperienceState{}

final class  EmptyExperienceFieldsState extends ExperienceState{}
final class  CheckExperienceEmptyFieldsState extends ExperienceState{}

final class  SubmitWorkExperienceLoadingState extends ExperienceState{}
final class  SubmitWorkExperienceSuccessState extends ExperienceState{}
final class  SubmitWorkExperienceFailureState extends ExperienceState{
  final String message;

  SubmitWorkExperienceFailureState({required this.message});
}

