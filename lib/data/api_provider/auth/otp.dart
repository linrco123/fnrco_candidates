import 'package:dio2/dio2.dart';
import 'package:fnrco_candidates/constants/app_urls.dart';
import 'package:fnrco_candidates/constants/exceptions.dart';

class OTPProvider {
  late Dio dio;
  OTPProvider() {
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
//     "message": "Code exists.",
//     "data": {
//         "code": 616957
//     }
// }
  Future<bool?> verifyOTP(data) async {
    //return otp code
    try {
      final response = await dio.post(AppLinks.otp, data: data);

       print(
          '========================forgetpassword=====response================================');
      print(response.data.runtimeType);
      print(response.data);
      if (response.statusCode == 200) {
        //show messages or snackbar of success
        return response.data['"status"'];
      }
    } on DioError catch (e) {
      print(e.type);
        print(
          '========================otp=====response================exception================');
      print(e.error+ '  ||||||||||||||| '+e.message);
      throw ApiException('otp code is not correct');
    }
    return null;
  }
}
