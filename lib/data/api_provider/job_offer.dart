import 'package:dio2/dio2.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
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
      logger.e('-===============response==============');
      logger.e(response.data);

      if (response.statusCode == 200) {
        return JobOfferModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('-==========================error================');
      logger.e(e);
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
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
       logger.e('-==========================error================');
      logger.e(e);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

  Future<bool> sendJobOfferApproval(FormData data) async {
    try {
      final response =
          await DioHelper.dio.post(AppLinks.application_approval, data: data);
      print('=======================response-==============');
      logger.e(response);
      if (response.statusCode == 200) {
        return response.data['status'];
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      print('=======================error-==============');
      logger.e(e.response);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }
}
