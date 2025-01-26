import 'package:dio2/dio2.dart';
import '../../../core/classes/dio_helper.dart';
import '../../../constants/app_urls.dart';
import '../../../core/classes/exceptions.dart';
import '../../../core/classes/failure.dart';
import '../../models/auth/sign_up/countries_model.dart';
import '../../models/auth/sign_up/gender_model.dart';
import '../../models/auth/sign_up/marital_status_model.dart';
import '../../models/auth/sign_up/positions_model.dart';
import '../../models/auth/sign_up/religion_model.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class PersonalDetailsProvider {
  //late Dio dio;
  PersonalDetailsProvider() {
    //   BaseOptions _baseOptions = BaseOptions(
    //       baseUrl: AppLinks.baseUrl,
    //       receiveDataWhenStatusError: true,
    //       connectTimeout: 20 * 1000,
    //       receiveTimeout: 20 * 1000,
    //       headers: {
    //         'Accept': 'application/json',
    //         'Content-Type': 'application/json',
    //         "Auth": "bearer ${CacheHelper.userToken}"
    //       });
    //   dio = Dio(_baseOptions);
  }

  Future<bool> submitPersonalData(data) async {
    try {
      final Response response = await DioHelper.dio.post(
        AppLinks.profile_update,
        data: data,
      );
      logger.d(
          '====================submitPersonalData============================');
      logger.e(response.data);

      if (response.statusCode == 200) {
        return response.data['status'];
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('========================Error========================');
      logger.e(e.response);
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
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
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
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
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
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
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
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
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
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }
}
