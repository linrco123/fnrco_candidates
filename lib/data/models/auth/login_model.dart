class LoginModel {
  User? user;
  String? accessToken;

  LoginModel({this.user, this.accessToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['access_token'] = this.accessToken;
    return data;
  }
}

class User {
  int? id;
  String? candidateUserUname;
  String? email;

  User({this.id, this.candidateUserUname, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    candidateUserUname = json['candidate_user_uname'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['candidate_user_uname'] = this.candidateUserUname;
    data['email'] = this.email;
    return data;
  }
}