import 'package:dio2/dio2.dart';
import 'package:fnrco_candidates/constants/app_urls.dart';
import 'package:fnrco_candidates/core/classes/exceptions.dart';
import 'package:fnrco_candidates/core/classes/failure.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/countries_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/gender_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/marital_status_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/positions_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/register_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/religion_model.dart';

class PersonalDetailsProvider {
  late Dio dio;
  PersonalDetailsProvider() {
    BaseOptions _baseOptions = BaseOptions(
        baseUrl: AppLinks.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000,
        receiveTimeout: 20 * 1000,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          //"authorization": "bearer ${CacheHelper.getAuthToken()}"
        });
    dio = Dio(_baseOptions);
  }

  Future<RegisterModel> submitPersonalData(Map data) async {
    try {
      final Response response = await dio.post(
        AppLinks.signUp,
        data: data,
      );
      
      if (response.statusCode == 200) {
        return RegisterModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      print('error =====================  >>>>>>>>>>>> $e');
      // return await Future.error(
      //     Failure(e.response!.statusCode!, e.response!.data['message']));
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }



  Future<CountriesModel> getCountries() async {
    try {
      final Response response = await dio.get(
        AppLinks.country,
      );
      if (response.statusCode == 200) {
        return CountriesModel.fromJson(response.data);
      } else {
        return await Future.error(response.statusCode!);
      }
    } on DioError catch (e) {
      return await Future.error(
          Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

  Future<PositionsModel> getPositions() async {
    try {
      final Response response = await dio.get(
        AppLinks.position,
      );
      if (response.statusCode == 200) {
        return PositionsModel.fromJson(response.data);
      } else {
        return await Future.error(response.statusCode!);
      }
    } catch (e) {
      return await Future.error(e);
    }
  }

  Future<GenderModel> getGenders() async {
    try {
      final Response response = await dio.get(
        AppLinks.genderStatus,
      );
      if (response.statusCode == 200) {
        return GenderModel.fromJson(response.data);
      } else {
        return await Future.error(response.statusCode!);
      }
    } catch (e) {
      return await Future.error(e);
    }
  }

  Future<ReligionModel> getReligions() async {
    try {
      // final Response response = await dio.get(
      //   AppLinks.religion,
      // );
      final Response response = await Dio(
          BaseOptions(baseUrl: 'https://develop.fnrcoerp.com', headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      })).get('/religion');
      if (response.statusCode == 200) {
        return ReligionModel.fromJson(response.data);
      } else {
        return await Future.error(response.statusCode!);
      }
    } catch (e) {
      return await Future.error(e);
    }
  }

  Future<MaritalStatusModel> getMaritalStatus() async {
    try {
      final Response response = await dio.get(
        AppLinks.maritalStatus,
      );
      if (response.statusCode == 200) {
        return MaritalStatusModel.fromJson(response.data);
      } else {
        return await Future.error(response.statusCode!);
      }
    } catch (e) {
      return await Future.error(e);
    }
  }
}
