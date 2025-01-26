import 'package:dio2/dio2.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import '../models/air_ticket_model.dart';
import '../../constants/app_urls.dart';
import '../../constants/constances.dart';
import '../../core/classes/dio_helper.dart';
import '../../core/classes/exceptions.dart';
import '../../core/classes/failure.dart';

class AirTicketProvider {
  Future<AirTicketModel> getAirApplications() async {
    try {
      final response = await DioHelper.dio.get(AppLinks.recruitment_process,
          queryParameters: {"stage": air_ticket});
          logger.e('========================response=============');
          logger.e(response.data);
      if (response.statusCode == 200) {
        return AirTicketModel.fromJson(response.data);
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

  Future<bool> sendAirTicketInfo(FormData data) async {
    try {
      final response =
          await DioHelper.dio.post(AppLinks.send_air_ticket, data: data);
      logger.e('=========================response=========');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return response.data['status'];
      } else {
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } catch (e) {
      logger.e('===================error===============');
      logger.e(e);
      throw Exception();
      // throw ApiException(
      //     failure:
      //         Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }
}
