import 'package:dio2/dio2.dart';
import 'package:fnrco_candidates/constants/app_urls.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/core/classes/dio_helper.dart';
import 'package:fnrco_candidates/core/classes/exceptions.dart';
import 'package:fnrco_candidates/core/classes/failure.dart';
import 'package:fnrco_candidates/data/models/air_ticket_model.dart';
import 'package:fnrco_candidates/data/models/job_contract_model.dart';
import 'package:fnrco_candidates/data/models/job_offer_model.dart';
import 'package:fnrco_candidates/data/models/joining_date_model.dart';
import 'package:fnrco_candidates/data/models/visa_approval_model.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class NotificationsProvider {
  // NotificationsProvider();

  Future<JobContractModel> getContractApplications() async {
    try {
      final response = await DioHelper.dio.get(AppLinks.recruitment_process,
          queryParameters: {"stage": candidate_contract});
      logger.e('======================Contracts================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return JobContractModel.fromJson(response.data);
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

  Future<JobOfferModel> getJobApplications() async {
    try {
      final response = await DioHelper.dio.get(AppLinks.recruitment_process,
          queryParameters: {"stage": job_offer});
      logger.e('=====================job-offer=====================');
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

  Future<AirTicketModel> getAirApplications() async {
    try {
      final response = await DioHelper.dio.get(AppLinks.recruitment_process,
          queryParameters: {"stage": air_ticket});
      logger.e('========================Air-ticket=============');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return AirTicketModel.fromJson(response.data);
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

  Future<JoiningDateModel> getJoiningDate() async {
    try {
      final response = await DioHelper.dio.get(AppLinks.recruitment_process,
          queryParameters: {'stage': joining_date, "joining_dates": true});
      print('==================Joining-dates==============');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return JoiningDateModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      print('==================error==============');
      logger.e(e.response);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

  Future<VisaApprovalModel> getVisadata() async {
    try {
      final response = await DioHelper.dio.get(AppLinks.recruitment_process,
          queryParameters: {'stage': visa_selection});
      logger.e('==========================Visa-approval===================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return VisaApprovalModel.fromJson(response.data);
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
