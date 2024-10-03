import 'package:fnrco_candidates/data/web_services/auth/sign_up.dart';

class SignUpRepository {
  SignUpWebServices signUpRepository;
  SignUpRepository({required this.signUpRepository});

  Future<SignUpModel> postLogIn(path, Map data) async {
    try {
      var data = await signUpRepository.postSignUp(path);
      return SignUpModel.fromJson(data as Map);
    } catch (e, s) {
      return Future.error(e);
    }
  }
}

class SignUpModel {
  SignUpModel.fromJson(Map json);
}