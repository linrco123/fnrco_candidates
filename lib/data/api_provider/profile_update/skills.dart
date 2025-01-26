import 'package:dio2/dio2.dart';
import '../../../constants/app_urls.dart';
import '../../../core/classes/cache_helper.dart';
import '../../../core/classes/dio_helper.dart';
import '../../../core/classes/exceptions.dart';
import '../../../core/classes/failure.dart';
import '../../models/profile/skills_model.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class SkillsProvider {
  late Dio dio;
  SkillsProvider() {
    BaseOptions _baseOptions = BaseOptions(
        baseUrl: AppLinks.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000,
        receiveTimeout: 20 * 1000,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          "Auth": "bearer ${CacheHelper.userToken}"
        });
    dio = Dio(_baseOptions);
  }

  Future<SkillsModel> getSkills() async {
    try {
      final Response response = await dio.get(
        AppLinks.skills,
      );
      logger.e('=====================response======================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return SkillsModel.fromJson(response.data);
      } else {
        return await Future.error(response.statusCode!);
      }
    } on DioError catch (e) {
            throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<bool> submitSkills(data) async {
    try {
      final Response response =
          await DioHelper.dio.put(AppLinks.profile_update, data: data);
      if (response.statusCode == 200) {
        return response.data['status'];
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('-==================error===========================');
      logger.e(e);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }
}
