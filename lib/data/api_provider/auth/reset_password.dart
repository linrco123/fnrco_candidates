import 'package:dio2/dio2.dart';
import 'package:fnrco_candidates/constants/app_urls.dart';
import 'package:fnrco_candidates/core/classes/exceptions.dart';
import 'package:fnrco_candidates/core/classes/failure.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class ResetPasswordprovider {
  late Dio dio;
  ResetPasswordprovider() {
    BaseOptions _baseOptions = BaseOptions(
        baseUrl: AppLinks.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000,
        receiveTimeout: 20 * 1000,
        headers: {
          'Accept': 'application/json',
          'content-Type': 'application/json',
          //"authorization": "bearer ${CacheHelper.getAuthToken()}"
        });
    dio = Dio(_baseOptions);
  }

  Future<bool?> resetPassword(data) async {
    try {
      final response = await dio.post(AppLinks.forgetPassword, data: data);

      logger.d(response.data);
      if (response.statusCode == 200) {
        return response.data['status'];
      }
    } on DioError catch (e) {
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
    return null;
  }
}
