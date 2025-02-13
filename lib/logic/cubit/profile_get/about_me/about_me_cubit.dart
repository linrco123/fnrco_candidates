import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../data/api_provider/profile_get/about_me_provider.dart';
import '../../../../data/models/profile/profile_section_model.dart';
import '../../../../data/models/profile_get/achievements_model.dart';
import '../../../../data/models/profile_get/contacts_model.dart';
import '../../../../data/models/profile_get/credentials_model.dart';
import '../../../../data/models/profile_get/education_model.dart';
import '../../../../data/models/profile_get/experiences_model.dart';
import '../../../../data/models/profile_get/get_jobs_model.dart';
import '../../../../data/models/profile_get/keywords_model.dart';
import '../../../../data/models/profile_get/languages_model.dart';
import '../../../../data/models/profile_get/notes_model.dart';
import '../../../../data/models/profile_get/personal_data_model.dart';
import '../../../../data/models/profile_get/skills_model.dart';
import '../../../../ui/screens/profile_get/applied_jobs.dart';
import '../../../../ui/screens/profile_get/get_achievements.dart';
import '../../../../ui/screens/profile_get/get_contacts.dart';
import '../../../../ui/screens/profile_get/get_credentials.dart';
import '../../../../ui/screens/profile_get/get_education.dart';
import '../../../../ui/screens/profile_get/experience/get_experiences.dart';
import '../../../../ui/screens/profile_get/get_keywords.dart';
import '../../../../ui/screens/profile_get/get_languages.dart';
import '../../../../ui/screens/profile_get/get_notes.dart';
import '../../../../ui/screens/profile_get/get_personal_details.dart';
import '../../../../ui/screens/profile_get/get_skills.dart';

part 'about_me_state.dart';

class AboutMeCubit extends Cubit<AboutMeState> {
  AboutMeProvider aboutMeProvider;
  AboutMeCubit({required this.aboutMeProvider}) : super(AboutMeInitial());

  List<ProfileSectionModel> sections = [
    ProfileSectionModel(section: 'Personal Details', index: 0),
    ProfileSectionModel(section: 'contacts', index: 1),
    ProfileSectionModel(section: 'achievements', index: 2),
    ProfileSectionModel(section: 'notes', index: 3),
    ProfileSectionModel(section: 'experiences', index: 4),
    ProfileSectionModel(section: 'educations', index: 5),
    ProfileSectionModel(section: 'credentials', index: 6),
    ProfileSectionModel(section: 'languages', index: 7),
    ProfileSectionModel(section: 'skills', index: 8),
    ProfileSectionModel(section: 'keywords', index: 9),
    ProfileSectionModel(section: 'Applied Jobs', index: 10),
  ];
  Widget getBodyWidget() {
    switch (section) {
      case 0:
        return const GetPersonalDetailsScreen();
      case 1:
        return const GetContactsScreen();
      case 2:
        return const GetAchievementsScreen();
      case 3:
        return const GetNotesScreen();
      case 4:
        return const GetExperiencesScreen();
      case 5:
        return const GetEducationScreen();
      case 6:
        return const GetCredentialsScreen();
      case 7:
        return const GetLanguagesScreen();
      case 8:
        return const GetSkillsScreen();
      case 9:
        return const GetKeywordsScreen();
      case 10:
        return const AppliedJobsScreen();
      // default:
      // SizedBox();
    }
    return const SizedBox();
  }

  int section = 0;

  int first_clicked = 0;

  void changeSection(int page) {
    section = page;
   // first_clicked = 0;
    emit(AboutMeChangeSectionState());
  }

  // var countries = List<Country>.empty(growable: true);
  // void getCountries() {
  //   emit(AboutMeGettingCountriesLoadingState());
  //   countries.clear();
  //   aboutMeProvider.getCountries().then((value) {
  //     for (var country in value.data as List) countries.add(country);
  //     emit(AboutMeGettingCountriesSuccessState(countries: countries));
  //   }).catchError((error) {
  //     emit(AboutMeGettingCountriesErrorState(
  //         message: error.failure.message));
  //   });
  // }
  getPersonalData() {
    emit(AboutMeGetPersonalDataLoadingState());
    aboutMeProvider.getPersonalData().then((value) {
      emit(AboutMeGetPersonalDataSuccessState(pData: value.personalData!));
    }).catchError((error) {
      emit(AboutMeGetPersonalDataErrorState(message: error.failure.message));
    });
  }

  getContacts() {
    emit(AboutMeGetContactsLoadingState());
    aboutMeProvider.getContacts().then((value) {
      emit(AboutMeGetContactsSuccessState(contacts: value.contacts!));
    }).catchError((error) {
      emit(AboutMeGetContactsErrorState(message: error.failure.message));
    });
  }

  getCredentials() {
    emit(AboutMeGetCredentialsLoadingState());
    aboutMeProvider.getCredentials().then((value) {
      emit(AboutMeGetCredentialsSuccessState(credentials: value.credentials!));
    }).catchError((error) {
      emit(AboutMeGetCredentialsErrorState(message: error.failure.message));
    });
  }

  getAchievements() {
    emit(AboutMeGetAchievementsLoadingState());
    aboutMeProvider.getAchievements().then((value) {
      emit(AboutMeGetAchievementsSuccessState(
          achievements: value.achievements!));
    }).catchError((error) {
      emit(AboutMeGetAchievementsErrorState(message: error.failure.message));
    });
  }

  getNotes() {
    emit(AboutMeGetNotesLoadingState());
    aboutMeProvider.getNotes().then((value) {
      emit(AboutMeGetNotesSuccessState(notes: value.notes!));
    }).catchError((error) {
      emit(AboutMeGetNotesErrorState(message: error.failure.message));
    });
  }

  getLanguages() {
    emit(AboutMeGetLanguagesLoadingState());
    aboutMeProvider.getLanguages().then((value) {
      emit(AboutMeGetLanguagesSuccessState(languages: value.languages!));
    }).catchError((error) {
      emit(AboutMeGetLanguagesErrorState(message: error.failure.message));
    });
  }

  getExperiences() {
    emit(AboutMeGetExperiencesLoadingState());
    aboutMeProvider.getExperiences().then((value) {
      emit(AboutMeGetExperiencesSuccessState(experiences: value.experiences!));
    }).catchError((error) {
      emit(AboutMeGetExperiencesErrorState(message: error.failure.message));
    });
  }

  getEducation() {
    emit(AboutMeGetEducationsLoadingState());
    aboutMeProvider.getEducation().then((value) {
      emit(AboutMeGetEducationsSuccessState(educations: value.educations!));
    }).catchError((error) {
      emit(AboutMeGetEducationsErrorState(message: error.failure.message));
    });
  }

  getSkills() {
    emit(AboutMeGetSkillsLoadingState());
    aboutMeProvider.getSkills().then((value) {
      emit(AboutMeGetSkillsSuccessState(skills: value.skills!));
    }).catchError((error) {
      emit(AboutMeGetSkillsErrorState(message: error.failure.message));
    });
  }

  getKeywords() {
    emit(AboutMeGetkeywordsLoadingState());
    aboutMeProvider.getKeywords().then((value) {
      emit(AboutMeGetkeywordsSuccessState(keywords: value.keywords!));
    }).catchError((error) {
      emit(AboutMeGetkeywordsErrorState(message: error.failure.message));
    });
  }

  getAppliedJobs() {
    emit(AboutMeGetAppliedJobsLoadingState());
    aboutMeProvider.getAppliedJobs().then((value) {
      emit(AboutMeGetAppliedJobsSuccessState(appliedJobs: value.data!));
    }).catchError((error) {
      emit(AboutMeGetAppliedJobsErrorState(message: error.failure.message));
    });
  }
}
