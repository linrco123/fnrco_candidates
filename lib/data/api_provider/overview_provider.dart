import 'package:dio2/dio2.dart';
import 'package:fnrco_candidates/constants/constances.dart';
import 'package:fnrco_candidates/data/models/job_offer_model.dart';
import '../models/overview_model.dart';
import '../../constants/app_urls.dart';
import '../../core/classes/dio_helper.dart';
import '../../core/classes/exceptions.dart';
import '../../core/classes/failure.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class OverviewProvider {
  //late Dio dio;
  OverviewProvider();

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

  Future<AppOverviewModel> getOverViewData(int appID) async {
    try {
      final Response response = await DioHelper.dio.get(
        "/recruitment-process/view-app-details?candidate_application_id=$appID",
        // queryParameters: {"candidate_application_id": appID},
      );

      logger.e('====================overview===============');
      logger.e(response.data);

      if (response.statusCode == 200) {
        return AppOverviewModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('====================Error==================');
      logger.e(e.response);
      logger.e(e.message);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }
}
