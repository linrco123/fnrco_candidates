import 'package:dio2/dio2.dart';
import '../../../core/classes/dio_helper.dart';
import '../../../constants/app_urls.dart';
import '../../../core/classes/exceptions.dart';
import '../../../core/classes/failure.dart';
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

  Future<bool> resetPassword(data) async {
    try {
      final response =
          await DioHelper.dio.post(AppLinks.resetPassword, data: data);
      logger.e('=======================response-==================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return response.data['status'];
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('==================++Error======================');
      logger.e(e.response);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }
}
