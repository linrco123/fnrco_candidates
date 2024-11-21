class AppLinks {
  // ignore: unused_field
  static const moduleID = '91';
  static const String baseUrl = 'https://develop.fnrcoerp.com/api';

  static const String metaData = '/meta-data';
  static const String candidate = '/candidate';

  ////////////////////////TODO: Authentication////////////////////////////////
  static const String logIn = '/candidate/login';
  static const String signUp = '/candidate/register';
  static const String otp = '/auth/verify-code';
  static const String resendOtp = '/resendOtp';
  static const String forgetPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  ////////////////////////////////TODO: MetaData////////////////////////////
  static const String country = "/country/index";
  static const String position = "/position";
  static const String genderStatus = "$metaData/221";
  static const String religion = "/religion";
  static const String maritalStatus = "$metaData/120";
  static const String skill = "$metaData/124";
  ////////////////////// TODO:Management::Content ////////////////////////////
  static const String survies = "/surveys?module_id=91";
  static const String surveyView = "/surveys/view/";
  static const String surveyViewAnswer = "/surveys/store-answers/";
  static const String profile_update = "/person/update";
///section//////////?sections=(skillls)
  static const String profile_section = "/person/sections";
}
