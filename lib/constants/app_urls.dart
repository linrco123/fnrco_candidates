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
   static const String classification = "$metaData/422";
  static const String skills = "$metaData/124";
  static const String years = "$metaData/129";
  static const String contactType = "$metaData/123";
  ////////////////////// TODO:Management::Content ////////////////////////////
  //------------------------surveys-------------------------------
  static const String survies = "/surveys?module_id=$moduleID";
  static const String surveyView = "/surveys/view/";
  static const String surveyViewAnswer = "/surveys/store-answers/";
  //------------------------polls------------------------------
    static const String polls = "/poll?module_id=$moduleID";
  static const String pollView = "/poll/view";
  static const String pollViewAnswer = "/polls/store-answers/";
  //---------------------------FAQs---------------------------------
    static const String faqs = "/faqs";
  //-------------------------tutorial------------------------------
  static const String tutorial = "/tutorial?module_id=$moduleID";
   // --------------------------------Announcement--------------------------
  static const String announcement = "/announcement?module_id=$moduleID";
   // --------------------------------contents--------------------------
  static const String contents = "/content?module_id=$moduleID";
    ////////////////////// TODO:Management::Polls //////////////////
  static const String profile_update = "/person/update";
///section//////////?sections=(skillls)
  static const String profile_section = "/person/sections";
  //////////////////////////////////TODO:GET_PROFILE.///////////////
  static const String profile_get = "/person/sections";
  ////////////////////////////////////////TODO:JObs/////////////////
  static const String jobs = "/jobs";

  static String applyJob = '/candidate/apply-job';
  static String appliedJobs = '/candidate/applied-jobs';
 //////////////////////////TODO:tickets/////////////////
  static String ticket = '/ticket';
  //////////////////////////TODO:Medical Declaration////////
  
  static String submit_medical = "/umdf/item";

  static String medicalQuestions= "/umdf/item";
  

}
