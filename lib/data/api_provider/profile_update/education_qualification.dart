import 'package:dio2/dio2.dart';
import '../../../constants/app_urls.dart';
import '../../../core/classes/dio_helper.dart';
import '../../../core/classes/exceptions.dart';
import '../../../core/classes/failure.dart';
import '../../models/profile/years_model.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class EducationAndQualificationProvider {
  //late Dio dio;
  EducationAndQualificationProvider();

  Future<YearsModel> getYears() async {
    try {
      final Response response = await DioHelper.dio.get(
        AppLinks.years,
      );
      if (response.statusCode == 200) {
        return YearsModel.fromJson(response.data);
      } else {
        return await Future.error(response.statusCode!);
      }
    } on DioError catch (e) {
      return await Future.error(
          Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<bool> submitEducationQualification(data) async {
    try {
      final Response response =
          await DioHelper.dio.put(AppLinks.profile_update, data: data);
      if (response.statusCode == 200) {
        return response.data['status'];
      } else {
        return await Future.error(response.statusCode!);
      }
    } on DioError catch (e) {
      logger.d(e.response!.statusMessage!);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }
}
