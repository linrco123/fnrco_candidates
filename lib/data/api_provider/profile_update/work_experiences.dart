import 'package:dio2/dio2.dart';
import '../../../constants/app_urls.dart';
import '../../../core/classes/dio_helper.dart';
import '../../../core/classes/exceptions.dart';
import '../../../core/classes/failure.dart';
import '../../models/auth/sign_up/countries_model.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class ExperienceProvider {
  //late Dio dio;
  ExperienceProvider() {}

  Future<CountriesModel> getCountries() async {
    try {
      final Response response = await DioHelper.dio.get(
        AppLinks.country,
      );
      if (response.statusCode == 200) {
        return CountriesModel.fromJson(response.data);
      } else {
        return await Future.error(response.statusCode!);
      }
    } on DioError catch (e) {
      return await Future.error(
          Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<bool> submitExperiences(data) async {
    try {
      final Response response =
          await DioHelper.dio.put(AppLinks.profile_update, data: data);
      if (response.statusCode == 200) {
        return response.data['status'];
      } else {
        return await Future.error(response.statusCode!);
      }
    } on DioError catch (e) {
      logger.e('-==================error===========================');
      logger.e(e);
      logger.d(e.response!.statusMessage!);
      logger.d(e.response!.data['message']);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }
}
