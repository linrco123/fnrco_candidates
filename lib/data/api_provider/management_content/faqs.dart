import 'package:dio2/dio2.dart';
import '../../../constants/app_urls.dart';
import '../../../constants/constances.dart';
import '../../../core/classes/dio_helper.dart';
import '../../../core/classes/exceptions.dart';
import '../../../core/classes/failure.dart';
import '../../models/management_content/faqs_model.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';

class FaqsProvider {
  //late Dio dio;
  FaqsProvider() {
    // BaseOptions _baseOptions = BaseOptions(
    //     baseUrl: AppLinks.baseUrl,
    //     receiveDataWhenStatusError: true,
    //     connectTimeout: 20 * 1000,
    //     receiveTimeout: 20 * 1000,
    //     headers: {
    //       'Accept': 'application/json',
    //       'content-Type': 'application/json',
    //       "Auth": "bearer ${CacheHelper.userToken}"
    //     });
    // dio = Dio(_baseOptions);
  }

  Future<FAQsModel> getFAQs() async {
    try {
      final response = await DioHelper.dio.get(AppLinks.faqs , queryParameters: {
        'module_id':MODULE_ID.toString()
      });
      logger.e('======================= response =================');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return FAQsModel.fromJson(response.data);
      }else{
        return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      logger.e('======================= Error =================');
      logger.e('====>>>> $e');
        throw ApiException(
            failure:
                Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }

  // Future<PollViewModel?> getPollsView(int pollViewIndex) async {
  //   try {
  //     final response = await DioHelper.dio.get('${AppLinks.pollView}/$pollViewIndex');
  //     logger.e('======================= response =================');
  //     logger.e(response.data);
  //     if (response.statusCode == 200) {
  //       return PollViewModel.fromJson(response.data);
  //     }
  //   } on DioError catch (e) {
  //     logger.e('======================= Error =================');
  //     logger.e('====>>>> $e');
  //     throw ApiException(
  //         failure:
  //             Failure(e.response!.statusCode!, e.response!.statusMessage!));
  //   }
  //   return null;
  // }

  }