import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../constants/constances.dart';
import 'dio_helper.dart';
import '../../data/models/auth/login_model.dart';
import '../../data/models/auth/sign_up/register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  // ignore: unused_field
  static late final SharedPreferences sharedPreferences;
  static late final FlutterSecureStorage secureStorage;
  static String? userToken;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    secureStorage = const FlutterSecureStorage();
    await getAuthToken();
    //storeBiometricStatus(false);
  }

  static Future<void> removeAll() async {
    // await sharedPreferences.remove('user_name');
    // await sharedPreferences.remove('user_email');
    await secureStorage.delete(key: 'auth_key');
    userToken = null;
  }

  static setOnBoarding() async {
    await sharedPreferences.setBool('onBoarding', true);
  }

  static bool? getOnBoarding() {
    return sharedPreferences.getBool('onBoarding');
  }

  static void storeAuthToken(String authToken) async {
    userToken = authToken;
    await secureStorage.write(key: 'auth_key', value: authToken);
  }

  static Future<String?> getAuthToken() async {
    userToken = await secureStorage.read(key: 'auth_key');
    return userToken;
  }

  static void storeFCMToken(String fcmToken) async {
    await secureStorage.write(key: 'fcm_token', value: fcmToken);
  }

  static Future<String?> getFCMToken() async {
    return await secureStorage.read(key: 'fcm_token');
  }

  static void storePassword(String password) async {
    await secureStorage.write(key: 'password', value: password);
  }

  static Future<String?> getAPassword() async {
    return await secureStorage.read(key: 'password');
  }

  static storeBiometricStatus(bool value) async {
    await sharedPreferences.setBool('user_bio', value);
  }

  static bool getBiometricStatus() {
    return sharedPreferences.getBool('user_bio') ?? false;
  }

  static storeBrightnessMode(int value) async {
    print('========shared_preferences brightness mode ========== $value');

    await sharedPreferences.setInt('brightness_mode', value);
  }

  static int getBrightnessMode() {
    return sharedPreferences.getInt('brightness_mode') ?? LIGTH_MODE;
  }

  static storeName(String name) async {
    await sharedPreferences.setString('user_name', name);
  }

  static String? getName() {
    return sharedPreferences.getString('user_name');
  }

   static storeID(int id) async {
    await sharedPreferences.setInt('user_id', id);
  }

  static int? getID() {
    return sharedPreferences.getInt('user_id');
  }

  static storeLang(String name) async {
    await sharedPreferences.setString('lang', name);
  }

  static String getLang() {
    return sharedPreferences.getString('lang')??'en';
  }

  static storeEmail(String email) async {
    await sharedPreferences.setString('user_email', email);
  }

  static String? getEmail() {
    return sharedPreferences.getString('user_email');
  }

  static storeUserImage(String image) async {
    await sharedPreferences.setString('user_image', image);
  }

  static String? getImage() {
    return sharedPreferences.getString('user_image');
  }

  static void setPoll(){
    sharedPreferences.setBool('poll', true);
  }
  static bool? getPoll(){
    return sharedPreferences.getBool('poll');
  }

  static void setPollID(int pollID){
    sharedPreferences.setInt('poll_id', pollID);
  }
  static int? getPollID(){
    return sharedPreferences.getInt('poll_id');
  }

  static void setPollData(String pollData){
    sharedPreferences.setString('poll_data', pollData);
  }
  static String? getPollData(){
    return sharedPreferences.getString('poll_data');
  }
  static void setPollQuestion(String pollText) {
      sharedPreferences.setString('poll_question', pollText);
  }
  static String? getPollQuestion() {
        return sharedPreferences.getString('poll_question');

  }
   static void setSurvey(){
    sharedPreferences.setBool('survey', true);
  }
  static bool? getSurvey(){
    return sharedPreferences.getBool('survey');
  }
  

  static void storeUserData({LoginModel? userLData, RegisterModel? userRData}) {
    if (userLData != null) {
      storeName(userLData.data!.candidateUserUname!.isNotEmpty
          ? userLData.data!.candidateUserUname!
          : 'Guest');
      storeEmail(userLData.data!.email!);
      storeAuthToken(userLData.data!.accessToken!);
      storeID(userLData.data!.personId!);
    } else if (userRData != null) {
      storeName(userRData.data!.candidateUserUname!.isNotEmpty
          ? userRData.data!.candidateUserUname!
          : 'Guest');
      storeEmail(userRData.data!.email!);
      storeAuthToken(userRData.data!.accessToken!);
      storeID(userRData.data!.id!);
    }
    DioHelper.updateAuthKey();
  }

  

  
}
