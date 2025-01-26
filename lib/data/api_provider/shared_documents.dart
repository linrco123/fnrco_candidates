import 'package:dio2/dio2.dart';
import '../../constants/constances.dart';
import '../../core/classes/exceptions.dart';
import '../models/job_offer_model.dart';
import '../models/shared_documents.dart';
import '../../constants/app_urls.dart';
import '../../core/classes/dio_helper.dart';
import '../../core/classes/failure.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class SharedDocumentsProvider {
  //late Dio dio;
  SharedDocumentsProvider();

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

  Future<SharedDocumentsModel> getAppDocs(int candidateAppId) async {
    try {
      final Response response = await DioHelper.dio.get(
          '${AppLinks.get_shared_documents}$candidateAppId',
         );
       
      logger.e('====================response==================');
      logger.e(response.data);

      if (response.statusCode == 200) {
        return SharedDocumentsModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('====================Error==================');
      logger.e(e);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

}
