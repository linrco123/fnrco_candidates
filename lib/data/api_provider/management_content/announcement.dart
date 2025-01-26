import 'package:dio2/dio2.dart';
import '../../../constants/app_urls.dart';
import '../../../core/classes/dio_helper.dart';
import '../../../core/classes/exceptions.dart';
import '../../../core/classes/failure.dart';
import '../../models/management_content/announcement_model.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class AnnouncementProvider {
  AnnouncementProvider() {
   
  }

  Future<AnnouncementModel> getAnnouncements() async {
    try {
      final response = await DioHelper.dio.get(AppLinks.announcement);
      logger.e('======================= response =================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return AnnouncementModel.fromJson(response.data);
      }else{
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('======================= Error =================');
      logger.e('====>>>> $e');
        throw ApiException(
            failure:
                Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

  // Future<SurveyViewModel?> getAnnouncementView(int surveyViewIndex) async {
  //   try {
  //     final response = await DioHelper.dio.get('${AppLinks.surveyView}/$surveyViewIndex');
  //     logger.e('======================= response =================');
  //     logger.e(response.data);
  //     if (response.statusCode == 200) {
  //       return SurveyViewModel.fromJson(response.data);
  //     }
  //   } on DioError catch (e) {
  //     logger.e('======================= Error =================');
  //     logger.e('====>>>> $e');
  //     throw ApiException(
  //         failure:
  //             Failure(e.response!.statusCode!, e.response!.statusMessage!));
  //   }
  //   return null;
  // }

}
