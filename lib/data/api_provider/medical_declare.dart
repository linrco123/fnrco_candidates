// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio2/dio2.dart';
import 'package:fnrco_candidates/constants/app_urls.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/core/classes/dio_helper.dart';
import 'package:fnrco_candidates/core/classes/exceptions.dart';
import 'package:fnrco_candidates/core/classes/failure.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/countries_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/gender_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/marital_status_model.dart';
import 'package:fnrco_candidates/data/models/management_content/classification_model.dart';
import 'package:fnrco_candidates/data/models/medical_declaration_app_model.dart';
import 'package:fnrco_candidates/data/models/medical_questions.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class MedicalDeclareProvider {
  //late Dio dio;
  MedicalDeclareProvider() {
    // BaseOptions _baseOptions = BaseOptions(
    //     baseUrl: AppLinks.baseUrl,
    //     receiveDataWhenStatusError: true,
    //     connectTimeout: 20 * 1000,
    //     receiveTimeout: 20 * 1000,
    //     headers: {
    //       'Accept': 'application/json',
    //       'Content-Type': 'application/json',
    //       //"authorization": "bearer ${CacheHelper.getAuthToken()}"
    //     });
    // dio = Dio(_baseOptions);
  }

  Future<MedicalDeclarationAppsModel> getMedicalApplications() async {
    try {
      final response = await DioHelper.dio
          .get(AppLinks.recruitment_process, queryParameters: {"stage": hdf});
      if (response.statusCode == 200) {
        return MedicalDeclarationAppsModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('====================Error==============');
      logger.e(e);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

  Future<CountriesModel> getCountries() async {
    try {
      final Response response = await DioHelper.dio.get(
        AppLinks.country,
      );
      if (response.statusCode == 200) {
        return CountriesModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));

      }
    } on DioError catch (e) {
      logger.e('================+Error=countries=========================');
      logger.e(e);
       throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

  Future<GenderModel> getGenders() async {
    try {
      final Response response = await DioHelper.dio.get(
        AppLinks.genderStatus,
      );
      if (response.statusCode == 200) {
        return GenderModel.fromJson(response.data);
      } else {
          return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    }on DioError catch (e) {
      logger.e('================+Error====Gender======================');
      logger.e(e);
       throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
    }
  

  Future<MaritalStatusModel> getMaritalStatus() async {
    try {
      final Response response = await DioHelper.dio.get(
        AppLinks.maritalStatus,
      );
      if (response.statusCode == 200) {
        return MaritalStatusModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    }on DioError catch (e) {
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

  Future<ClassificationsModel> getClassifications() async {
    try {
      final Response response = await DioHelper.dio.get(
        AppLinks.classification,
      );
      if (response.statusCode == 200) {
        return ClassificationsModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    }on DioError catch (e) {
      logger.e('===============+Error========================');
      logger.e(e);
       throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
    }
  

  Future<MedicalQuestionsModel> getMedQuestions() async {
    try {
      final Response response = await DioHelper.dio.get(
        AppLinks.medicalQuestions,
      );
      logger.e('====================response==================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return MedicalQuestionsModel.fromJson(response.data);
      } else {
         return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('====================Error=========Quesions================');
      logger.e(e.response);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

  Future<bool> sendMedicalDeclare(data) async {
    try {
      final Response response =
          await DioHelper.dio.post(AppLinks.submit_medical, data: data);
      logger.e('====================response==================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return response.data['status'];
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('====================Error==================');
      logger.e(e.response);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

}