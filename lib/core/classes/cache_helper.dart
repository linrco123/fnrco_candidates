import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  // ignore: unused_field
  static late final SharedPreferences sharedPreferences;
  static late final FlutterSecureStorage secureStorage;

  void init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    secureStorage = FlutterSecureStorage();
  }

  void storeAuthKey(String authKey)async{

   await secureStorage.write(key: 'auth_key', value: authKey);
  }
  
   Future<String?> getAuthKey( )async{

   return await secureStorage.read(key: 'auth_key');
  }
  
    void storeName(String name)async{

   await secureStorage.write(key: 'user_name', value: name);
  }
  
   Future<String?> getName( )async{

   return await secureStorage.read(key: 'user_name');
  }

}


