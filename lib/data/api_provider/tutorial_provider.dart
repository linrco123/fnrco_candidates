import 'package:dio2/dio2.dart';
import '../../core/classes/exceptions.dart';
import '../../constants/app_urls.dart';
import '../../core/classes/dio_helper.dart';
import '../../core/classes/failure.dart';
import '../models/tutorial_model.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class TutorialProvider {
  //late Dio dio;
  TutorialProvider();

  Future<TutorialsModel> getTutorials() async {
    try {
      final Response response = await DioHelper.dio.get(
        AppLinks.tutorial,
      );
      logger.e('====================response==================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return TutorialsModel.fromJson(response.data);
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
