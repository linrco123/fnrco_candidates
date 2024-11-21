import 'package:dio2/dio2.dart';
import 'package:fnrco_candidates/constants/app_urls.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/core/classes/exceptions.dart';
import 'package:fnrco_candidates/core/classes/failure.dart';
import 'package:fnrco_candidates/data/models/management_content/survey_view_model.dart';
import 'package:fnrco_candidates/data/models/management_content/survies_model.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class SurveysProvider {
  late Dio dio;
  LoginProvider() {
    BaseOptions _baseOptions = BaseOptions(
        baseUrl: AppLinks.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000,
        receiveTimeout: 20 * 1000,
        headers: {
          'Accept': 'application/json',
          'content-Type': 'application/json',
          "Auth": "bearer ${CacheHelper.userToken}"
        });
    dio = Dio(_baseOptions);
  }

  Future<SurviesModel?> getSurveys() async {
    try {
      final response = await Dio(BaseOptions(
          baseUrl: AppLinks.baseUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 20 * 1000,
          receiveTimeout: 20 * 1000,
          headers: {
            'Accept': 'application/json',
            'content-Type': 'application/json',
            "Auth": "bearer ${CacheHelper.userToken}"
          })).get(AppLinks.survies);
      logger.e('======================= response =================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return SurviesModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      logger.e('======================= Error =================');
      logger.e('====>>>> $e');
        throw ApiException(
            failure:
                Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
    return null;
  }

  Future<SurveyViewModel?> getSurveyView(int surveyViewIndex) async {
    try {
      final response = await Dio(BaseOptions(
          baseUrl: AppLinks.baseUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 20 * 1000,
          receiveTimeout: 20 * 1000,
          headers: {
            'Accept': 'application/json',
            'content-Type': 'application/json',
            "Auth": "bearer ${CacheHelper.userToken}"
          })).get('${AppLinks.surveyView}/$surveyViewIndex');
      logger.e('======================= response =================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return SurveyViewModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      logger.e('======================= Error =================');
      logger.e('====>>>> $e');
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
    return null;
  }

  Future<bool?> sendSurveyView(int surveyID, Map data) async {
    try {
      final response =
          await Dio(BaseOptions(
          baseUrl: AppLinks.baseUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 20 * 1000,
          receiveTimeout: 20 * 1000,
          headers: {
            'Accept': 'application/json',
            'content-Type': 'application/json',
            "Auth": "bearer ${CacheHelper.userToken}"
          })).post('${AppLinks.surveyViewAnswer}/$surveyID', data: data);
      logger.e('======================= response =================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return response.data!['status'];
      }
    }on DioError catch (e) {
      logger.e('======================= Error =================');
      logger.e('====>>>> $e');
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
    return null;
  }
}
