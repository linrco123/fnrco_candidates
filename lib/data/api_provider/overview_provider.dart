import 'package:dio2/dio2.dart';
import 'package:fnrco_candidates/data/models/overview_model.dart';
import '../../constants/app_urls.dart';
import '../../core/classes/dio_helper.dart';
import '../../core/classes/exceptions.dart';
import '../../core/classes/failure.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class OverviewProvider {
  //late Dio dio;
  OverviewProvider();

  Future<OverviewModel> getOverViewData() async {
    try {
      final Response response = await DioHelper.dio.get(
        AppLinks.overview,
      );

      logger.e('====================overview===============');
      logger.e(response.data);

      if (response.statusCode == 200) {
        return OverviewModel.fromJson(response.data);
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
