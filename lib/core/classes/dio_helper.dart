import 'package:dio2/dio2.dart';
import '../../constants/app_urls.dart';
import 'cache_helper.dart';

class DioHelper {
  static const String applicationJson = "application/json";
  static const String contentType = "content-type";
  static const String accept = "accept";
  static const int apiTimeOut = 60000;
  static late Dio dio;

  static Future<void> init() async {
    // BaseOptions _baseOptions = BaseOptions(
    //     baseUrl: AppLinks.baseUrl,
    //     receiveDataWhenStatusError: true,
    //     connectTimeout: 20 * 1000,
    //     receiveTimeout: 20 * 1000);
    // dio = Dio(_baseOptions);
    dio = Dio();

    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      "Auth": "bearer ${CacheHelper.userToken}"
    };

    dio.options = BaseOptions(
      baseUrl: AppLinks.baseUrl,
      headers: headers,
      receiveTimeout: apiTimeOut,
      sendTimeout: apiTimeOut,
      connectTimeout: apiTimeOut,
    );

    
  }

  static void updateAuthKey(){
    dio.options.headers
        .update("Auth", (value) => "bearer ${CacheHelper.userToken}");
  }
}
