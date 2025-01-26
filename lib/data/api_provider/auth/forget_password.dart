import 'package:dio2/dio2.dart';
import '../../../core/classes/dio_helper.dart';
import '../../../constants/app_urls.dart';
import '../../../core/classes/exceptions.dart';
import '../../../core/classes/failure.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class ForgetPasswordProvider {
  //late Dio dio;
  ForgetPasswordProvider() {
    // BaseOptions _baseOptions = BaseOptions(
    //     baseUrl: AppLinks.baseUrl,
    //     receiveDataWhenStatusError: true,
    //     connectTimeout: 20 * 1000,
    //     receiveTimeout: 20 * 1000,
    //     headers: {
    //       'Accept': 'application/json',
    //       'content-Type': 'application/json',
    //       //"authorization": "bearer ${CacheHelper.getAuthToken()}"
    //     });
    // dio = Dio(_baseOptions);
  }
  Future<int> forgetPassword(data) async {
    try {
      final response =
          await DioHelper.dio.post(AppLinks.forgetPassword, data: data);
      logger.e('======================otp====================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return response.data['data']['code'];
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('======================error====================');
      logger.d(e.response!.data);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }
}
