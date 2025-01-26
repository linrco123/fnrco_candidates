import 'package:dio2/dio2.dart';
import '../../core/classes/exceptions.dart';
import '../models/ui_widget_model.dart';
import '../../constants/app_urls.dart';
import '../../core/classes/dio_helper.dart';
import '../../core/classes/failure.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class TicketProvider {
  //late Dio dio;
  TicketProvider();

  Future<bool> submitTicket(data) async {
    try {
      // final Response response = await DioHelper.dio.post(
      //   AppLinks.ticket,
      //   data: data
      // );
      var response = await DioHelper.dio.request(
        AppLinks.ticket,
        options: Options(
          method: 'POST',
          // headers: headers,
        ),
        data: data,
      );
      logger.e('====================response==================');
      logger.e(response.data);

      if (response.statusCode == 200) {
        return response.data['status'];
      } else {
        return await Future.error(response.statusCode!);
      }
    } on DioError catch (e) {
      logger.e('====================Error==================');
      logger.e(e);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

  Future<UiWidgetModel> getUIWidget() async {
    try {
      final Response response = await DioHelper.dio.get(
        AppLinks.ui_widget,
      );

      logger.e('====================response==================');
      logger.e(response.data);

      if (response.statusCode == 200) {
        return UiWidgetModel.fromJson(response.data);
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
