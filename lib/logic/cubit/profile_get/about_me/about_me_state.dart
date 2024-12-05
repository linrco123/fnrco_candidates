part of 'about_me_cubit.dart';

@immutable
sealed class AboutMeState {}

final class AboutMeInitial extends AboutMeState {}

final class AboutMeChangeSectionState extends AboutMeState {}

//////////////TODO:PersonalData.//////////////////////

class AboutMeGetPersonalDataLoadingState extends AboutMeState {}

class AboutMeGetPersonalDataSuccessState extends AboutMeState {
  final List<GetPData> pData;

  AboutMeGetPersonalDataSuccessState({required this.pData});
}

class AboutMeGetPersonalDataErrorState extends AboutMeState {
  final String message;

  AboutMeGetPersonalDataErrorState({required this.message});
}

//////////////TODO:Achievements.//////////////////////

class AboutMeGetAchievementsLoadingState extends AboutMeState {}

class AboutMeGetAchievementsSuccessState extends AboutMeState {
  final List<GetAchievement> achievements;

  AboutMeGetAchievementsSuccessState({required this.achievements});
}

class AboutMeGetAchievementsErrorState extends AboutMeState {
  final String message;

  AboutMeGetAchievementsErrorState({required this.message});
}

//////////////TODO:Experiences.//////////////////////
class AboutMeGetExperiencesLoadingState extends AboutMeState {}

class AboutMeGetExperiencesSuccessState extends AboutMeState {
  final List<GetExperience> experiences;

  AboutMeGetExperiencesSuccessState({required this.experiences});
}

class AboutMeGetExperiencesErrorState extends AboutMeState {
  final String message;

  AboutMeGetExperiencesErrorState({required this.message});
}

//////////////TODO:Contacts.//////////////////////
class AboutMeGetContactsLoadingState extends AboutMeState {}

class AboutMeGetContactsSuccessState extends AboutMeState {
  final List<GetContact> contacts;

  AboutMeGetContactsSuccessState({required this.contacts});
}

class AboutMeGetContactsErrorState extends AboutMeState {
  final String message;

  AboutMeGetContactsErrorState({required this.message});
}

//////////////TODO:Credentials.//////////////////////
class AboutMeGetCredentialsLoadingState extends AboutMeState {}

class AboutMeGetCredentialsSuccessState extends AboutMeState {
  final List<GetCredential> credentials;

  AboutMeGetCredentialsSuccessState({required this.credentials});
}

class AboutMeGetCredentialsErrorState extends AboutMeState {
  final String message;

  AboutMeGetCredentialsErrorState({required this.message});
}

//////////////TODO:educations.//////////////////////
class AboutMeGetEducationsLoadingState extends AboutMeState {}

class AboutMeGetEducationsSuccessState extends AboutMeState {
  final List<GetEducation> educations;

  AboutMeGetEducationsSuccessState({required this.educations});
}

class AboutMeGetEducationsErrorState extends AboutMeState {
  final String message;

  AboutMeGetEducationsErrorState({required this.message});
}

//////////////TODO:keywords.//////////////////////

class AboutMeGetkeywordsLoadingState extends AboutMeState {}

class AboutMeGetkeywordsSuccessState extends AboutMeState {
  final List<GetKeyword> keywords;

  AboutMeGetkeywordsSuccessState({required this.keywords});
}

class AboutMeGetkeywordsErrorState extends AboutMeState {
  final String message;

  AboutMeGetkeywordsErrorState({required this.message});
}

//////////////TODO:Languages.//////////////////////
class AboutMeGetLanguagesLoadingState extends AboutMeState {}

class AboutMeGetLanguagesSuccessState extends AboutMeState {
  final List<GetLanguage> languages;

  AboutMeGetLanguagesSuccessState({required this.languages});
}

class AboutMeGetLanguagesErrorState extends AboutMeState {
  final String message;

  AboutMeGetLanguagesErrorState({required this.message});
}

//////////////TODO:Notes.//////////////////////
class AboutMeGetNotesLoadingState extends AboutMeState {}

class AboutMeGetNotesSuccessState extends AboutMeState {
  final List<GetNote> notes;

  AboutMeGetNotesSuccessState({required this.notes});
}

class AboutMeGetNotesErrorState extends AboutMeState {
  final String message;

  AboutMeGetNotesErrorState({required this.message});
}

//////////////TODO:Skills.//////////////////////

class AboutMeGetSkillsLoadingState extends AboutMeState {}

class AboutMeGetSkillsSuccessState extends AboutMeState {
  final List<GetSkill> skills;

  AboutMeGetSkillsSuccessState({required this.skills});
}

class AboutMeGetSkillsErrorState extends AboutMeState {
  final String message;

  AboutMeGetSkillsErrorState({required this.message});
}


//////////////TODO:AppliedJobs.//////////////////////


class AboutMeGetAppliedJobsLoadingState extends AboutMeState {}

// class AboutMeGetAppliedJobsSuccessState extends AboutMeState {
//   final List<GetAppliedJob> appliedJobs;

//   AboutMeGetAppliedJobsSuccessState({required this.appliedJobs});
// }

class AboutMeGetAppliedJobsErrorState extends AboutMeState {
  final String message;

  AboutMeGetAppliedJobsErrorState({required this.message});
}