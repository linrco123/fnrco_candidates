


import 'package:dio2/dio2.dart';
import 'package:fnrco_candidates/constants/app_urls.dart';
import 'package:fnrco_candidates/core/classes/exceptions.dart';

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

  Future<int?> resetPassword(data) async {
    //return otp code
    try {
      final response = await dio.post(AppLinks.forgetPassword, data: data);

       print(
          '========================resetpassword=====response================================');
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
      throw ApiException('Data entered is not correct');
    }
    return null;
  }
}
