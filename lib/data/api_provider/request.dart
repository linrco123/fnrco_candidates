import 'package:dio2/dio2.dart';
import '../../constants/app_urls.dart';
import '../../core/classes/dio_helper.dart';
import '../../core/classes/exceptions.dart';
import '../../core/classes/failure.dart';
import '../models/request_model.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class RequestProvider {
  //late Dio dio;
  RequestProvider();

  Future<bool> submitRequest(data) async {
    try {
      // final Response response = await DioHelper.dio.post(
      //   AppLinks.ticket,
      //   data: data
      // );
      var response =
          await DioHelper.dio.post(AppLinks.submit_request, data: data);

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

  Future<RequestModel> getRequestData() async {
    try {
      final Response response = await DioHelper.dio.get(
        AppLinks.get_request,
      );

      logger.e('====================response===requests===============');
      logger.e(response.data);

      if (response.statusCode == 200) {
        return RequestModel.fromJson(response.data);
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
