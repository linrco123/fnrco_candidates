import 'package:dio2/dio2.dart';

class DioHelper {
  static late Dio dio;

  void init() {
    BaseOptions _baseOptions = BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000,
        receiveTimeout: 20 * 1000);
    dio = Dio(_baseOptions);
  }
}
