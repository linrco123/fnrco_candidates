import 'package:dio2/dio2.dart';
import '../../../constants/app_urls.dart';
import '../../../core/classes/cache_helper.dart';
import '../../../core/classes/dio_helper.dart';
import '../../../core/classes/exceptions.dart';
import '../../../core/classes/failure.dart';
import '../../models/management_content/survey_view_model.dart';
import '../../models/management_content/survies_model.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class SurveysProvider {
  late Dio dio;
  SurveysProvider() {
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

  Future<SurveysModel?> getSurveys() async {
    try {
      final response = await DioHelper.dio.get(AppLinks.survies);
      logger.e('======================= response =================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return SurveysModel.fromJson(response.data);
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
      final response = await DioHelper.dio.get('${AppLinks.surveyView}/$surveyViewIndex');
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
