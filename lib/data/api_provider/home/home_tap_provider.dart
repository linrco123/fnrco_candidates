import 'package:dio2/dio2.dart';
import '../../../constants/app_urls.dart';
import '../../../core/classes/dio_helper.dart';
import '../../../core/classes/exceptions.dart';
import '../../../core/classes/failure.dart';
import '../../models/home/jobs_model.dart';
import '../../models/profile_get/get_jobs_model.dart';
class HomePageProvider {
  // late Dio dio;
  HomePageProvider() {
    // BaseOptions _baseOptions = BaseOptions(
    //     baseUrl: AppLinks.baseUrl,
    //     receiveDataWhenStatusError: true,
    //     connectTimeout: 20 * 1000,
    //     receiveTimeout: 20 * 1000,
    //     headers: {
    //       'Accept': 'application/json',
    //       'content-Type': 'application/json',
    //       //"authorization": "bearer ${CacheHelper.getAuthToken()}"
    //     });
    // dio = Dio(_baseOptions);
  }

  Future<JobsModel> getJobs() async {
    try {
      final Response response = await DioHelper.dio.get(AppLinks.jobs);
      print(
          '=============================response================================');
      print(response.data.runtimeType);
      print(response.data);
      if (response.statusCode == 200) {
        //show messages or snackbar of success
        return JobsModel.fromJson(response.data);
      } else {
        //show messages or snackbar of failure
       return await Future.error(
            Failure(response.statusCode!, response.data['message']));
      }
    } on DioError catch (e) {
      print('error =================================>>>>>>>>>>>>> $e');
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }


  Future<GetJobsModel> getAppliedJobs() async {
    try {
      final Response response = await DioHelper.dio.get(AppLinks.appliedJobs);
      if (response.statusCode == 200) {
        return GetJobsModel.fromJson(response.data);
      } else {
        return await Future.error(response.statusCode!);
      }
    } on DioError catch (e) {
      throw ApiException(
          failure:
              Failure(e.response!.statusCode!, e.response!.data['message']));
    }
  }
}
