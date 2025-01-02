import 'package:dio2/dio2.dart';
import 'package:fnrco_candidates/data/models/air_ticket_model.dart';
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
      if (response.statusCode == 200) {
        return AirTicketModel.fromJson(response.data);
      } else {
        return Future.error(response.statusCode!);
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
      if (response.statusCode == 200) {
        return response.data['status'];
      } else {
        return Future.error(response.statusCode!);
      }
    } on DioError catch (e) {
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }
}
