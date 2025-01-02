import 'package:dio2/dio2.dart';
import '../../constants/constances.dart';
import '../models/visa_approval_model.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import '../../../constants/app_urls.dart';
import '../../../core/classes/dio_helper.dart';
import '../../../core/classes/exceptions.dart';
import '../../../core/classes/failure.dart';

class VisaApprovalProvider {
  VisaApprovalProvider() {}

  Future<bool> sendVisaApproval(Map data) async {
    try {
      final response =
          await DioHelper.dio.post(AppLinks.application_approval, data: data);
          print('=================response==================');
          logger.e(response.data);
      if (response.statusCode == 200) {
        return response.data['status'];
      } else {
        return Future.error(response.statusCode!);
      }
    } on DioError catch (e) {
      logger.e('==========================================');
      logger.e(e.message);
      logger.e(e.response);
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

  Future<VisaApprovalModel> getVisadata() async {
    try {
      final response = await DioHelper.dio.get(AppLinks.recruitment_process,
      queryParameters: {
        'stage':visa_selection
      }
      );
      if (response.statusCode == 200) {
        return VisaApprovalModel.fromJson( response.data);
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
