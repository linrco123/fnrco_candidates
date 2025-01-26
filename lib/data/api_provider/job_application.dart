import 'package:dio2/dio2.dart';
import '../../core/classes/exceptions.dart';
import '../../constants/app_urls.dart';
import '../../core/classes/dio_helper.dart';
import '../../core/classes/failure.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class JobApplicationProvider {
  //late Dio dio;
  JobApplicationProvider();

  Future<bool> applyJob(Map data) async {
    try {
      final Response response = await DioHelper.dio.post(
        AppLinks.applyJob,
        data: data
      );
      logger.e('====================response==================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return response.data['status'];
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
