import 'package:dio2/dio2.dart';
import '../../constants/app_urls.dart';
import '../../constants/constances.dart';
import '../../core/classes/dio_helper.dart';
import '../../core/classes/exceptions.dart';
import '../../core/classes/failure.dart';
import '../models/joining_date_model.dart';

class JoiningDateProvider {
  JoiningDateProvider();

  Future<JoiningDateModel> getJoiningDate() async {
    try {
      final response = await DioHelper.dio.get(AppLinks.recruitment_process,
      queryParameters: {
        'stage':joining_date
      }

      );
      if (response.statusCode == 200) {
        return JoiningDateModel.fromJson( response.data);
      } else {
        return Future.error(response.statusCode!);
      }
    } on DioError catch (e) {
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

 Future<bool> sendJoiningDate(Map data) async {
    try {
      final response =
          await DioHelper.dio.post(AppLinks.application_approval, data: data);
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
