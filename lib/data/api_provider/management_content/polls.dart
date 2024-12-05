import 'package:dio2/dio2.dart';
import 'package:fnrco_candidates/constants/app_urls.dart';
import 'package:fnrco_candidates/core/classes/cache_helper.dart';
import 'package:fnrco_candidates/core/classes/dio_helper.dart';
import 'package:fnrco_candidates/core/classes/exceptions.dart';
import 'package:fnrco_candidates/core/classes/failure.dart';
import 'package:fnrco_candidates/data/models/management_content/poll_view_model.dart';
import 'package:fnrco_candidates/data/models/management_content/polls_model.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class PollsProvider {
  late Dio dio;
  PollsProvider() {
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

  Future<PollsModel> getPolls() async {
    try {
      final response = await DioHelper.dio.get(AppLinks.polls);
      logger.e('======================= response =================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return PollsModel.fromJson(response.data);
      }else{
        return Future.error(response.statusCode!);
      }
    } on DioError catch (e) {
      logger.e('======================= Error =================');
      logger.e('====>>>> $e');
        throw ApiException(
            failure:
                Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

  Future<PollViewModel?> getPollsView(int pollViewIndex) async {
    try {
      final response = await DioHelper.dio.get('${AppLinks.pollView}/$pollViewIndex');
      logger.e('======================= response =================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return PollViewModel.fromJson(response.data);
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

  Future<bool?> sendPollView(int surveyID, Map data) async {
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
          })).post('${AppLinks.pollViewAnswer}/$surveyID', data: data);
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
