import 'package:dio2/dio2.dart';
import '../../constants/app_urls.dart';
import '../../constants/constances.dart';
import '../../core/classes/dio_helper.dart';
import '../../core/classes/exceptions.dart';
import '../../core/classes/failure.dart';
import '../models/job_offer_model.dart';

class JobOfferProvider {

  Future<JobOfferModel> getJobApplications() async {
    try {
      final response = await DioHelper.dio.get(AppLinks.recruitment_process,
          queryParameters: {"stage": job_offer});
      if (response.statusCode == 200) {
        return JobOfferModel.fromJson(response.data);
      } else {
        return Future.error(response.statusCode!);
      }
    } on DioError catch (e) {
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

  Future<JobOfferModel> getJobOffer() async {
    try {
      final response = await DioHelper.dio.get(AppLinks.recruitment_process,
          queryParameters: {"stage": job_offer});
      if (response.statusCode == 200) {
        return JobOfferModel.fromJson(response.data);
      } else {
        return Future.error(response.statusCode!);
      }
    } on DioError catch (e) {
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

  Future<bool> sendJobOfferApproval(Map data) async {
    try {
      final response =
          await DioHelper.dio.post(AppLinks.application_approval, data: data);
      if (response.statusCode == 200) {
        return response.data['status'];
      } else {
        return Future.error(response.statusCode!);
      }
    } on DioError catch (e) {
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }
}
