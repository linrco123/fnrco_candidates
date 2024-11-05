import 'package:dio2/dio2.dart';
import 'package:fnrco_candidates/constants/app_urls.dart';
import 'package:fnrco_candidates/core/classes/exceptions.dart';

class ForgetPasswordProvider {
  late Dio dio;
  ForgetPasswordProvider() {
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


// {
//     "status": true,
//     "message": "Verifying code created successfully.",
//     "data": {
//         "code": 799025
//     }
// }
  Future<int?> forgetPassword(data) async {
    //return otp code
    try {
      final response = await dio.post(AppLinks.forgetPassword, data: data);

       print(
          '========================forgetpassword=====response================================');
      print(response.data.runtimeType);
      print(response.data);
      if (response.statusCode == 200) {
        //show messages or snackbar of success
        return response.data['data']['code'];
      }
    } on DioError catch (e) {
      print(e.type);
        print(
          '========================forgetpassword=====response================exception================');
      print(e.error+ '  ||||||||||||||| '+e.message);
      throw ApiException('Credentials entered are not correct');
    }
    return null;
  }
}
