import 'package:fnrco_candidates/data/web_services/auth/log_in.dart';

class LogInRepository {
  LogInWebServices logInWebServices;
  LogInRepository({required this.logInWebServices});

  Future<LogInModel> postLogIn(path, Map data) async {
    try {
      var data = await logInWebServices.postLogIn(path);
      return LogInModel.fromJson(data);
    } catch (e, s) {
      return Future.error(e);
    }
  }
}

class LogInModel {
  LogInModel.fromJson(Map<String, dynamic> json);
}
