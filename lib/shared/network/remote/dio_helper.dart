import 'package:dio/dio.dart';

class DioHelper {
  static var dio;
  static String token =
      "token";
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://pgpropertygroup.com/',
        receiveDataWhenStatusError: true,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    dio.options.headers["Authorization"] = "Bearer $token";
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    // String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      // 'lang': lang,
      // 'Authorization': token ?? '',
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
