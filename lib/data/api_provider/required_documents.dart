import 'package:dio2/dio2.dart';
import '../../constants/constances.dart';
import '../models/job_offer_model.dart';
import '../models/required_documents.dart';
import '../models/documents_category.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import '../../constants/app_urls.dart';
import '../../core/classes/dio_helper.dart';
import '../../core/classes/exceptions.dart';
import '../../core/classes/failure.dart';

class RequiredDocumentsProvider {
  RequiredDocumentsProvider();


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

  Future<RequiredDocumentsModel> getRequiredDocuments(int appID) async {
    try {
      final response = await DioHelper.dio.get(
        AppLinks.required_document,
         queryParameters: {'candidate_application_id': appID}
      );
      print('====================Local Proceess==============');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return RequiredDocumentsModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('====================Error==============');
      logger.e(e);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

  Future<DocumentsCategoryModel> getDocumentsCategory() async {
    try {
      final response = await DioHelper.dio.get(
        AppLinks.meta_category,
      );
      if (response.statusCode == 200) {
        return DocumentsCategoryModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('====================Error==============');
      logger.e(e);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }
}
