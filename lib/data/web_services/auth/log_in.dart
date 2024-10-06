import 'package:dio2/dio2.dart';

class LogInWebServices {
  Dio? dio;

  LogInWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: '',
      method: '',
      headers: {
        'accept': 'application/json',
      },
    );
    dio = Dio(options);
  }

  Future<dynamic> postLogIn(String path) async {
    final response = await dio!.post(path);
    return response.data;
  }
}
