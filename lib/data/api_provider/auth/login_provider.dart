// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio2/dio2.dart';
import 'package:fnrco_candidates/constants/app_urls.dart';
import 'package:fnrco_candidates/data/models/auth/login_model.dart';

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

  Future<LoginModel> logIn(Map data) async {

    final Response response;
    try {
      final Response response = await dio.post(
        AppLinks.logIn,
        data: data,
      );
      print(response);
      print(
          '=============================response================================');
      print(response.data.runtimeType);
      print(response.data);
      if (response.statusCode == 200) {
        //show messages or snackbar of success
        return LoginModel.fromJson(response.data);
      } else {
        //show messages or snackbar of failure
        return  Future.error(response.statusCode!);
      }
    } catch (e) {
      print('error =================================>>>>>>>>>>>>> $e');
      return await Future.error(e);
    }
  }
  // Future<Response> postData(String endpoint, Map<String, dynamic> data) async {
  //   try {
  //     final response = await ApiClient.instance.post(endpoint, data: data);
  //     return response;
  //   } on DioError catch (e) {
  //     // Handle the DioError based on its type
  //     handleDioError(e);
  //     throw e; // Optionally rethrow the error if you want to handle it further up
  //   }
  // }
  //
  // void handleDioError(DioError error) {
  //   switch (error.type) {
  //     case DioErrorType.connectTimeout:
  //       print("Connection Timeout");
  //       break;
  //     case DioErrorType.sendTimeout:
  //       print("Send Timeout");
  //       break;
  //     case DioErrorType.receiveTimeout:
  //       print("Receive Timeout");
  //       break;
  //     case DioErrorType.response:
  //     // Handle specific status code errors
  //       print("Received Invalid Status Code: ${error.response?.statusCode}");
  //       print("Response data: ${error.response?.data}");
  //       break;
  //     case DioErrorType.cancel:
  //       print("Request to API was cancelled");
  //       break;
  //     case DioErrorType.other:
  //       print("Unexpected error: ${error.message}");
  //       break;
  //   }
  // }
}
