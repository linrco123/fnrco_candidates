// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio2/dio2.dart';
import 'package:fnrco_candidates/constants/app_urls.dart';
import 'package:fnrco_candidates/data/models/auth/login_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/countries_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/gender_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/positions_model.dart';
import 'package:fnrco_candidates/data/models/auth/sign_up/religion_model.dart';

class SignUpProvider {
  late Dio dio;
  SignUpProvider() {
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

  Future<LoginModel> signUp(Map data) async {
    try {
      final Response response = await dio.post(
        AppLinks.logIn,
        data: data,
      );
      if (response.statusCode == 200) {
        //show messages or snackbar of success
        return LoginModel.fromJson(response.data);
      } else {
        //show messages or snackbar of failure
        return await Future.error(response.statusCode!);
      }
    } catch (e) {
      return await Future.error(e);
    }
  }

  Future<CountriesModel> getCountries() async {
    try {
      final Response response = await dio.get(
        AppLinks.country,
      );
      print('================response===========================');
      print(response.data);
      if (response.statusCode == 200) {
        //show messages or snackbar of success
        return CountriesModel.fromJson(response.data);
      } else {
        //show messages or snackbar of failure
        return await Future.error(response.statusCode!);
      }
    } catch (e) {
      print('================error===========================$e');

      return await Future.error(e);
    }
  }

  Future<PositionsModel> getPositions() async {
    try {
      final Response response = await dio.get(
        AppLinks.position,
      );
      print(
          '================PositionsModel  // response===========================');
      print(response.data);
      if (response.statusCode == 200) {
        //show messages or snackbar of success
        return PositionsModel.fromJson(response.data);
      } else {
        //show messages or snackbar of failure
        return await Future.error(response.statusCode!);
      }
    } catch (e) {
      print('================error===========================$e');

      return await Future.error(e);
    }
  }

  Future<GenderModel> getGenders() async {
    try {
      final Response response = await dio.get(
        AppLinks.genderStatus,
      );
      print(
          '================PositionsModel  // response===========================');
      print(response.data);
      if (response.statusCode == 200) {
        //show messages or snackbar of success
        return GenderModel.fromJson(response.data);
      } else {
        //show messages or snackbar of failure
        return await Future.error(response.statusCode!);
      }
    } catch (e) {
      print('================error===========================$e');

      return await Future.error(e);
    }
  }

  Future<ReligionModel> getReligions() async {
    try {
      final Response response = await dio.get(
        AppLinks.religion,
      );
      print(
          '================religions  // response===========================');
      print(response.data);
      if (response.statusCode == 200) {
        //show messages or snackbar of success
        return ReligionModel.fromJson(response.data);
      } else {
        //show messages or snackbar of failure
        return await Future.error(response.statusCode!);
      }
    } catch (e) {
      print('================error===========================$e');

      return await Future.error(e);
    }
  }
}
