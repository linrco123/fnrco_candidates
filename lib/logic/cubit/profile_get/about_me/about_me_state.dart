part of 'about_me_cubit.dart';

@immutable
sealed   class  AboutMeState {}

final   class  AboutMeInitial extends AboutMeState {}
 
final   class  AboutMeChangeSectionState extends AboutMeState {}

//////////////TODO:PersonalData.//////////////////////

final class  AboutMeGetPersonalDataLoadingState extends AboutMeState {}

final class  AboutMeGetPersonalDataSuccessState extends AboutMeState {
  final List<GetPData> pData;

  AboutMeGetPersonalDataSuccessState({required this.pData});
}

final class  AboutMeGetPersonalDataErrorState extends AboutMeState {
  final String message;

  AboutMeGetPersonalDataErrorState({required this.message});
}

//////////////TODO:Achievements.//////////////////////

final class  AboutMeGetAchievementsLoadingState extends AboutMeState {}

final class  AboutMeGetAchievementsSuccessState extends AboutMeState {
  final List<GetAchievement> achievements;

  AboutMeGetAchievementsSuccessState({required this.achievements});
}

final class  AboutMeGetAchievementsErrorState extends AboutMeState {
  final String message;

  AboutMeGetAchievementsErrorState({required this.message});
}

//////////////TODO:Experiences.//////////////////////
final class  AboutMeGetExperiencesLoadingState extends AboutMeState {}

final class  AboutMeGetExperiencesSuccessState extends AboutMeState {
  final List<GetExperience> experiences;

  AboutMeGetExperiencesSuccessState({required this.experiences});
}

final class  AboutMeGetExperiencesErrorState extends AboutMeState {
  final String message;

  AboutMeGetExperiencesErrorState({required this.message});
}

//////////////TODO:Contacts.//////////////////////
final class  AboutMeGetContactsLoadingState extends AboutMeState {}

final class  AboutMeGetContactsSuccessState extends AboutMeState {
  final List<GetContact> contacts;

  AboutMeGetContactsSuccessState({required this.contacts});
}

final class  AboutMeGetContactsErrorState extends AboutMeState {
  final String message;

  AboutMeGetContactsErrorState({required this.message});
}

//////////////TODO:Credentials.//////////////////////
final class  AboutMeGetCredentialsLoadingState extends AboutMeState {}

final class  AboutMeGetCredentialsSuccessState extends AboutMeState {
  final List<GetCredential> credentials;

  AboutMeGetCredentialsSuccessState({required this.credentials});
}

final class  AboutMeGetCredentialsErrorState extends AboutMeState {
  final String message;

  AboutMeGetCredentialsErrorState({required this.message});
}

//////////////TODO:educations.//////////////////////
final class  AboutMeGetEducationsLoadingState extends AboutMeState {}

final class  AboutMeGetEducationsSuccessState extends AboutMeState {
  final List<GetEducation> educations;

  AboutMeGetEducationsSuccessState({required this.educations});
}

final class  AboutMeGetEducationsErrorState extends AboutMeState {
  final String message;

  AboutMeGetEducationsErrorState({required this.message});
}

//////////////TODO:References.//////////////////////

final class  AboutMeGetReferencesLoadingState extends AboutMeState {}

final class  AboutMeGetReferencesSuccessState extends AboutMeState {
  final List<GetReference> references;

  AboutMeGetReferencesSuccessState({required this.references});
}

final class  AboutMeGetReferencesErrorState extends AboutMeState {
  final String message;

  AboutMeGetReferencesErrorState({required this.message});
}

//////////////TODO:Languages.//////////////////////
final class  AboutMeGetLanguagesLoadingState extends AboutMeState {}

final class  AboutMeGetLanguagesSuccessState extends AboutMeState {
  final List<GetLanguage> languages;

  AboutMeGetLanguagesSuccessState({required this.languages});
}

final class  AboutMeGetLanguagesErrorState extends AboutMeState {
  final String message;

  AboutMeGetLanguagesErrorState({required this.message});
}

//////////////TODO:Notes.//////////////////////
final class  AboutMeGetNotesLoadingState extends AboutMeState {}

final class  AboutMeGetNotesSuccessState extends AboutMeState {
  final List<GetNote> notes;

  AboutMeGetNotesSuccessState({required this.notes});
}

final class  AboutMeGetNotesErrorState extends AboutMeState {
  final String message;

  AboutMeGetNotesErrorState({required this.message});
}

//////////////TODO:Skills.//////////////////////

final class  AboutMeGetSkillsLoadingState extends AboutMeState {}

final class  AboutMeGetSkillsSuccessState extends AboutMeState {
  final List<GetSkill> skills;

  AboutMeGetSkillsSuccessState({required this.skills});
}

final class  AboutMeGetSkillsErrorState extends AboutMeState {
  final String message;

  AboutMeGetSkillsErrorState({required this.message});
}


//////////////TODO:AppliedJobs.//////////////////////


final class  AboutMeGetAppliedJobsLoadingState extends AboutMeState {}

final class  AboutMeGetAppliedJobsSuccessState extends AboutMeState {
  final List<GetJob> appliedJobs;

  AboutMeGetAppliedJobsSuccessState({required this.appliedJobs});
}

final class  AboutMeGetAppliedJobsErrorState extends AboutMeState {
  final String message;

  AboutMeGetAppliedJobsErrorState({required this.message});
}


////////////TODO: Delete an item from Section ///////////////
///
class AboutMeDeleteLoadingState extends AboutMeState {}
class AboutMeDeleteSuccessState extends AboutMeState {}
class  AboutMeDeleteErrorState extends AboutMeState {}