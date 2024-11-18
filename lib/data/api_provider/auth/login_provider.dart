// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:dio2/dio2.dart';
import 'package:fnrco_candidates/constants/app_urls.dart';
import 'package:fnrco_candidates/core/classes/exceptions.dart';
import 'package:fnrco_candidates/core/classes/failure.dart';
import 'package:fnrco_candidates/data/models/auth/login_model.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

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

  Future<LoginModel?> logIn(Map data) async {
    try {
      final Response response = await dio.post(
        AppLinks.logIn,
        data: data,
      );
      if (response.statusCode == 200 && response.data['status'] == true) {
        return LoginModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      print('========================login error ================');
      print('e.error   ======================= ${e.error}');
      print('e.message  ======================= ${e.message}');
      print('e.request!.data ======================= ${e.request!.data}');
      print(
          'e.response!.statusCode======================= ${e.response!.statusCode}');
      print('e.response!.data======================= ${e.response!.data}');
      logger.d(e.response!.data);

      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
    return null;
  }
}




  
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