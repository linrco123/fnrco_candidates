import 'package:dio2/dio2.dart';
import '../../../constants/app_urls.dart';
import '../../../core/classes/dio_helper.dart';
import '../../../core/classes/exceptions.dart';
import '../../../core/classes/failure.dart';
import '../../models/management_content/survey_view_model.dart';
import '../../models/management_content/survies_model.dart';

class SurveysProvider {
  SurveysProvider() {
  }

  Future<SurveysModel> getSurveys() async {
    try {
      final response = await DioHelper.dio.get(AppLinks.survies);
      if (response.statusCode == 200) {
        return SurveysModel.fromJson(response.data);
      } else {
        return Future.error(response.statusCode!);
      }
    } on DioError catch (e) {
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

  Future<SurveyViewModel> getSurveyView(int surveyViewIndex) async {
    try {
      final response =
          await DioHelper.dio.get('${AppLinks.surveyView}/$surveyViewIndex');
      if (response.statusCode == 200) {
        return SurveyViewModel.fromJson(response.data);
      } else {
        return Future.error(response.statusCode!);
      }
    } on DioError catch (e) {

      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

  Future<bool?> sendSurveyView(int surveyID, Map data) async {
    try {
      final response = await DioHelper.dio
          .post('${AppLinks.surveyViewAnswer}/$surveyID', data: data);

      if (response.statusCode == 200) {
        return response.data!['status'];
      } else {
        return Future.error(response.statusCode!);
      }
    } on DioError catch (e) {
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }
}
