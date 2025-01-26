import 'package:dio2/dio2.dart';
import '../models/management_content/polls_model.dart';
import '../models/management_content/survies_model.dart';
import '../../../constants/app_urls.dart';
import '../../../core/classes/dio_helper.dart';
import '../../../core/classes/exceptions.dart';
import '../../../core/classes/failure.dart';

class WelcomeProvider {
  WelcomeProvider() {}

  Future<PollsModel> getPolls() async {
    try {
      final response = await DioHelper.dio.get(AppLinks.polls);
      print(response.data);
      if (response.statusCode == 200) {
        return PollsModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      print('==================dio error=======================');
      print(e.message);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

  Future<SurveysModel> getSurveys() async {
    try {
      final response = await DioHelper.dio.get(AppLinks.survies);
      if (response.statusCode == 200) {
        return SurveysModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }
}
