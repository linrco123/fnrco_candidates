import 'package:dio2/dio2.dart';
import 'package:fnrco_candidates/constants/app_urls.dart';

class DioHelper {
  static late Dio dio;

  void init() {
    BaseOptions _baseOptions = BaseOptions(
      baseUrl: AppLinks.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000,
        receiveTimeout: 20 * 1000);
    dio = Dio(_baseOptions);
  }
}
