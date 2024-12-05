import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fnrco_candidates/data/api_provider/profile_get/about_me_provider.dart';
import 'package:fnrco_candidates/data/models/profile/profile_section_model.dart';
import 'package:fnrco_candidates/data/models/profile_get/achievements_model.dart';
import 'package:fnrco_candidates/data/models/profile_get/contacts_model.dart';
import 'package:fnrco_candidates/data/models/profile_get/credentials_model.dart';
import 'package:fnrco_candidates/data/models/profile_get/education_model.dart';
import 'package:fnrco_candidates/data/models/profile_get/experiences_model.dart';
import 'package:fnrco_candidates/data/models/profile_get/keywords_model.dart';
import 'package:fnrco_candidates/data/models/profile_get/languages_model.dart';
import 'package:fnrco_candidates/data/models/profile_get/notes_model.dart';
import 'package:fnrco_candidates/data/models/profile_get/personal_data_model.dart';
import 'package:fnrco_candidates/data/models/profile_get/skills_model.dart';
import 'package:fnrco_candidates/ui/screens/profile_get/applied_jobs.dart';
import 'package:fnrco_candidates/ui/screens/profile_get/get_achievements.dart';
import 'package:fnrco_candidates/ui/screens/profile_get/get_contacts.dart';
import 'package:fnrco_candidates/ui/screens/profile_get/get_credentials.dart';
import 'package:fnrco_candidates/ui/screens/profile_get/get_education.dart';
import 'package:fnrco_candidates/ui/screens/profile_get/get_experiences.dart';
import 'package:fnrco_candidates/ui/screens/profile_get/get_keywords.dart';
import 'package:fnrco_candidates/ui/screens/profile_get/get_languages.dart';
import 'package:fnrco_candidates/ui/screens/profile_get/get_notes.dart';
import 'package:fnrco_candidates/ui/screens/profile_get/get_personal_details.dart';
import 'package:fnrco_candidates/ui/screens/profile_get/get_skills.dart';

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
        return GetPersonalDetailsScreen();
      case 1:
        return GetContactsScreen();
      case 2:
        return GetAchievementsScreen();
      case 3:
        return GetNotesScreen();
      case 4:
        return GetExperiencesScreen();
      case 5:
        return GetEducationScreen();
      case 6:
        return GetCredentialsScreen();
      case 7:
        return GetLanguagesScreen();
      case 8:
        return GetSkillsScreen();
      case 9:
        return GetKeywordsScreen();
      case 10:
        return AppliedJobsScreen();
      // default:
      // SizedBox();
    }
    return SizedBox();
  }

  int section = 0;

  void changeSection(int page) {
    section = page;
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
    Map<String, dynamic> data = {
      'k1': "v1",
      'k2': "v1",
      'k3': "v1",
    };
    data.keys;
  }
}
