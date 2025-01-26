import 'package:dio2/dio2.dart';
import '../../constants/app_urls.dart';
import 'cache_helper.dart';

class DioHelper {
  static const String applicationJson = "application/json";
  static const String contentType = "content-type";
  static const String accept = "accept";
  static const int apiTimeOut = 60000;
  static late Dio dio;

  static Future<void> init() async {
    // BaseOptions _baseOptions = BaseOptions(
    //     baseUrl: AppLinks.baseUrl,
    //     receiveDataWhenStatusError: true,
    //     connectTimeout: 20 * 1000,
    //     receiveTimeout: 20 * 1000);
    // dio = Dio(_baseOptions);
    dio = Dio();

    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      "Accept-Language":"en",
      "Auth": "bearer ${CacheHelper.userToken}"
    };

    dio.options = BaseOptions(
      baseUrl: AppLinks.baseUrl,
      headers: headers,
      receiveTimeout: apiTimeOut,
      sendTimeout: apiTimeOut,
      connectTimeout: apiTimeOut,
    );
    
    //dio.interceptors.add(element);

    
  }

  static void updateAuthKey(){
    dio.options.headers
        .update("Auth", (value) => "bearer ${CacheHelper.userToken}");
  }
}

// class TokenService implements ITokenService {
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

//   @override
//   Future<String?> getAccessToken() async {
//     return await _secureStorage.read(key: 'accessToken');
//   }

//   @override
//   Future<String?> getRefreshToken() async {
//     return await _secureStorage.read(key: 'refreshToken');
//   }

//   @override
//   Future<void> setAccessToken(String accessToken) async {
//     await _secureStorage.write(key: 'accessToken', value: accessToken);
//   }

//   @override
//   Future<void> setRefreshToken(String refreshToken) async {
//     await _secureStorage.write(key: 'refreshToken', value: refreshToken);
//   }

//   @override
//   Future<void> clearTokens() async {
//     await _secureStorage.delete(key: 'accessToken');
//     await _secureStorage.delete(key: 'refreshToken');
//   }

//   @override
//   Future<String?> refreshAccessToken(Dio client) async {
//     final String? refreshToken = await getRefreshToken();
//     if (refreshToken == null) return null;

//     try {
//       final response = await client.get(
//         'your_refresh_token_endpoint',
//         queryParameters: {'token': refreshToken},
//       );

//       if (response.statusCode == 200) {
//         final String? newAccessToken = response.data['accessToken'];
//         if (newAccessToken != null) {
//           await setAccessToken(newAccessToken);
//           return newAccessToken;
//         }
//       }
//     } catch (e) {
//       if (e is DioException && e.response?.statusCode == 403) {
//         // Refresh token expired, clear tokens
//         await clearTokens();
//       }
//     }
//     return null;
//   }
// }


// class AppInterceptors extends Interceptor {
//   final Dio client;
//   final ITokenService tokenService;

//   AppInterceptors(this.client, this.tokenService);

//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     final String? accessToken = await tokenService.getAccessToken();
//     if (accessToken != null) {
//       options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
//     }
//     super.onRequest(options, handler);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     if (err.response?.statusCode == 401) {
//       // Unauthorized error
//       final String? newAccessToken =
//           await tokenService.refreshAccessToken(client);

//       if (newAccessToken != null) {
//         final options = err.requestOptions;
//         options.headers[HttpHeaders.authorizationHeader] =
//             'Bearer $newAccessToken';

//         return handler.resolve(await _retry(options));
//       }
//     }
//     return handler.next(err); // Continue with the error if token refresh fails
//   }

//   Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
//     final options = Options(
//       method: requestOptions.method,
//       headers: requestOptions.headers,
//     );
//     return client.request<dynamic>(
//       requestOptions.path,
//       data: requestOptions.data,
//       queryParameters: requestOptions.queryParameters,
//       options: options,
//     );
//   }
// }

