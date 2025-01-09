import 'package:dio2/dio2.dart';
import '../models/documents_category.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import '../../constants/app_urls.dart';
import '../../constants/constances.dart';
import '../../core/classes/dio_helper.dart';
import '../../core/classes/exceptions.dart';
import '../../core/classes/failure.dart';
import '../models/local_process_model.dart';

class LocalProcessProvider {
  LocalProcessProvider();

  Future<LocalProcessModel> getLocalProcess() async {
    try {
      final response = await DioHelper.dio.get(AppLinks.recruitment_process,
      queryParameters: {
        'stage':agency_local_process
      }
      );
      print('====================Local Proceess==============');
      logger.e(response.data);
      if (response.statusCode == 200) {
        return LocalProcessModel.fromJson(response.data);
      } else {
        return Future.error(response.statusCode!);
      }
    }  catch (e) {
      logger.e('====================Error==============');
      logger.e(e);
      throw Exception();
      // throw ApiException(
      //     failure:
      //         Failure(e.response!.statusCode!, e.response!.statusMessage!));
    }
  }
 Future<DocumentsCategoryModel> getDocumentsCategory() async {
    try {
      final response = await DioHelper.dio.get(
        AppLinks.meta_category,
      );
      if (response.statusCode == 200) {
        return DocumentsCategoryModel.fromJson(response.data);
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
