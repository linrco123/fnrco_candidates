import 'package:dio2/dio2.dart';
import '../../../constants/app_urls.dart';
import '../../../constants/constances.dart';
import '../../../core/classes/dio_helper.dart';
import '../../../core/classes/exceptions.dart';
import '../../../core/classes/failure.dart';
import '../../models/profile_get/achievements_model.dart';
import '../../models/profile_get/contacts_model.dart';
import '../../models/profile_get/credentials_model.dart';
import '../../models/profile_get/education_model.dart';
import '../../models/profile_get/experiences_model.dart';
import '../../models/profile_get/get_jobs_model.dart';
import '../../models/profile_get/keywords_model.dart';
import '../../models/profile_get/languages_model.dart';
import '../../models/profile_get/notes_model.dart';
import '../../models/profile_get/personal_data_model.dart';
import '../../models/profile_get/skills_model.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class AboutMeProvider {
  AboutMeProvider() {}

  Future<PersonalDataModel> getPersonalData() async {
    try {
      final Response response = await DioHelper.dio.get(
        AppLinks.profile_get,
      );
      logger.e(response.data);
      if (response.statusCode == 200) {
        return PersonalDataModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('=================errorr===================');
      logger.e(e.response!.data!);

      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<ContactsModel> getContacts() async {
    try {
      final Response response = await DioHelper.dio
          .get(AppLinks.profile_get, queryParameters: {SECTION: CONTACTS});
      logger.e('====================+Contacts======================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return ContactsModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('====================error======================');
      logger.e(e.response);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<CredentialsModel> getCredentials() async {
    try {
      final Response response = await DioHelper.dio
          .get(AppLinks.profile_get, queryParameters: {SECTION: CREDENTIALS});
      logger.d('================response===============');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return CredentialsModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.d('================error===============');
      logger.e(e.message);

      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<AchievementsModel> getAchievements() async {
    try {
      final Response response = await DioHelper.dio
          .get(AppLinks.profile_get, queryParameters: {SECTION: ACHIEVEMENTS});

      logger.e('====================achievements======================');
      logger.e(response.data);

      if (response.statusCode == 200) {
        return AchievementsModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('====================error======================');
      logger.e(e.response);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<NotesModel> getNotes() async {
    try {
      final Response response = await DioHelper.dio
          .get(AppLinks.profile_get, queryParameters: {SECTION: NOTES});
      logger.e('====================+Contacts======================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return NotesModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('====================error======================');
      logger.e(e.response);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<LanguagesModel> getLanguages() async {
    try {
      final Response response = await DioHelper.dio
          .get(AppLinks.profile_get, queryParameters: {SECTION: LANGUAGES});
      logger.e('====================language======================');
      logger.e(response.data);

      if (response.statusCode == 200) {
        return LanguagesModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('====================error======================');
      logger.e(e.response);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<ExperiencesModel> getExperiences() async {
    try {
      final Response response = await DioHelper.dio
          .get(AppLinks.profile_get, queryParameters: {SECTION: EXPERIENCES});
      logger.e('====================experience======================');
      logger.e(response.data);

      if (response.statusCode == 200) {
        return ExperiencesModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('====================error======================');
      logger.e(e.response);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<EducationsModel> getEducation() async {
    try {
      final Response response = await DioHelper.dio
          .get(AppLinks.profile_get, queryParameters: {SECTION: EDUCATIONS});
      logger.e('====================education======================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return EducationsModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('====================error======================');
      logger.e(e.response);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<GetSkillsModel> getSkills() async {
    try {
      final Response response = await DioHelper.dio
          .get(AppLinks.profile_get, queryParameters: {SECTION: SKILLS});
      logger.e('====================skills======================');
      logger.e(response.data);

      if (response.statusCode == 200) {
        return GetSkillsModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('====================error======================');
      logger.e(e.response);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<ReferencesModel> getReferences() async {
    try {
      final Response response = await DioHelper.dio
          .get(AppLinks.profile_get, queryParameters: {SECTION: REFERENCES});
      logger.e('=====================Response=================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return ReferencesModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('=====================Error=================');
      logger.e(e.error);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<GetJobsModel> getAppliedJobs() async {
    try {
      final Response response = await DioHelper.dio.get(AppLinks.appliedJobs);
      logger.e('=====================Response=================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return GetJobsModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('=====================Error=================');
      logger.e(e.error);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }
}
