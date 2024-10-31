import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fnrco_candidates/data/models/auth/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  // ignore: unused_field
  static late final SharedPreferences sharedPreferences;
  static late final FlutterSecureStorage secureStorage;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    secureStorage = FlutterSecureStorage();
    //storeBiometricStatus(false);
  }

  static void removeAll(){
    sharedPreferences.remove('user_email');
  }

  static void storeAuthToken(String authToken) async {
    await secureStorage.write(key: 'auth_key', value: authToken);
  }

  static Future<String?> getAuthToken() async {
    return await secureStorage.read(key: 'auth_key');
  }

  static void storeFCMToken(String fcmToken) async {
    await secureStorage.write(key: 'fcm_token', value: fcmToken);
  }

  static Future<String?> getFCMToken() async {
    return await secureStorage.read(key: 'fcm_token');
  }

  static void storePassword(String authToken) async {
    await secureStorage.write(key: 'password', value: authToken);
  }

  static Future<String?> getAPassword() async {
    return await secureStorage.read(key: 'password');
  }

  static storeBiometricStatus(bool value) async {
     await sharedPreferences.setBool('user_bio', value);
  }

  static bool getBiometricStatus() {
    return sharedPreferences.getBool('user_bio')?? false;
  }

  static storeName(String name) async {
    await sharedPreferences.setString('user_name', name);
  }

  static String? getName() {
    return sharedPreferences.getString('user_name');
  }

  static storePhone(String phone) async {
    await sharedPreferences.setString('user_phone', phone);
  }

  static String? getPhone() {
    return sharedPreferences.getString('user_phone');
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

  static void storeUserData(LoginModel userData) {
    storeName(userData.data!.candidateUserUname!.isNotEmpty
        ? userData.data!.candidateUserUname!
        : 'Guest');
    storeEmail(userData.data!.email!);
    storeAuthToken(userData.data!.accessToken!);
    storePhone('');
    storePassword('');
  }
}
