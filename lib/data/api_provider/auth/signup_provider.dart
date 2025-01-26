// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio2/dio2.dart';
import 'package:fnrco_candidates/constants/app_urls.dart';
import 'package:fnrco_candidates/core/classes/dio_helper.dart';
import 'package:fnrco_candidates/core/classes/exceptions.dart';
import 'package:fnrco_candidates/core/classes/failure.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/countries_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/gender_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/marital_status_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/positions_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/register_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/religion_model.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class SignUpProvider {
  //late Dio dio;
  SignUpProvider() {
    // BaseOptions _baseOptions = BaseOptions(
    //     baseUrl: AppLinks.baseUrl,
    //     receiveDataWhenStatusError: true,
    //     connectTimeout: 20 * 1000,
    //     receiveTimeout: 20 * 1000,
    //     headers: {
    //       'Accept': 'application/json',
    //       'Content-Type': 'application/json',
    //       //"authorization": "bearer ${CacheHelper.getAuthToken()}"
    //     });
    // dio = Dio(_baseOptions);
  }

  Future<RegisterModel> signUp(Map data) async {
    try {
      final Response response = await DioHelper.dio.post(
        AppLinks.signUp,
        data: data,
      );
      logger.e('============= signup=============================');
      logger.e(response.data);

      if (response.statusCode == 200) {
        return RegisterModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('=====================error===============');
      logger.e(e.response);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<int?> getOTP(data) async {
    try {
      final response =
          await DioHelper.dio.post(AppLinks.forgetPassword, data: data);
      logger.e('======================otp====================');
      logger.d(response.data);
      if (response.statusCode == 200) {
        return response.data['data']['code'];
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e(e.response!.data);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<CountriesModel> getCountries() async {
    try {
      final Response response = await DioHelper.dio.get(
        AppLinks.country,
      );
      if (response.statusCode == 200) {
        return CountriesModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<PositionsModel> getPositions() async {
    try {
      final Response response = await DioHelper.dio.get(
        AppLinks.position,
      );
      if (response.statusCode == 200) {
        return PositionsModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<GenderModel> getGenders() async {
    try {
      final Response response = await DioHelper.dio.get(
        AppLinks.genderStatus,
      );
      if (response.statusCode == 200) {
        return GenderModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<ReligionModel> getReligions() async {
    try {
      final Response response = await DioHelper.dio.get(
        AppLinks.religion,
      );

      if (response.statusCode == 200) {
        return ReligionModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<MaritalStatusModel> getMaritalStatus() async {
    try {
      final Response response = await DioHelper.dio.get(
        AppLinks.maritalStatus,
      );
      if (response.statusCode == 200) {
        return MaritalStatusModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }
}
