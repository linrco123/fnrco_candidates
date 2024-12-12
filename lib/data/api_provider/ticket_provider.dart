import 'package:dio2/dio2.dart';
import 'package:fnrco_candidates/constants/app_urls.dart';
import 'package:fnrco_candidates/core/classes/dio_helper.dart';
import 'package:fnrco_candidates/core/classes/failure.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class TicketProvider {
  //late Dio dio;
  TicketProvider();

  Future<bool> submitTicket(data) async {
    try {
      final Response response = await DioHelper.dio.post(
        AppLinks.ticket,
        data: data
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
      return await Future.error(
          Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }

}