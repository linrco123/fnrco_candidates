import 'package:dio2/dio2.dart';
import 'package:fnrco_candidates/constants/app_urls.dart';
import 'package:fnrco_candidates/data/models/home/jobs_model.dart';

class LoginProvider {
  late Dio dio;
  LoginProvider() {
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

  Future<JobsModel> logIn(Map data) async {
    try {
      final Response response = await dio.post(
        AppLinks.logIn,
        data: data,
      );
      print(
          '=============================response================================');
      print(response.data.runtimeType);
      print(response.data);
      if (response.statusCode == 200) {
        //show messages or snackbar of success
        return JobsModel.fromJson(response.data);
      } else {
        //show messages or snackbar of failure
        return await Future.error(response.statusCode!);
      }
    } catch (e) {
      print('error =================================>>>>>>>>>>>>> $e');
      return await Future.error(e);
    }
  }
}
