import 'package:dio/dio.dart';
import 'package:usedbookshop/shared/variable.dart';

class DioHelper2 {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: mainUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    var result = dio!.get(
      url,
      queryParameters: query,
    );
    return result;
  }

  static Future<Response> deletedata({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    return dio!.delete(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    required Object data,
    Map<String, dynamic>? query,
    bool t = true,
    String? token,
    String? socketId,
  }) async {
    dio!.options.headers = {
      'Authorization': token ?? '',
      if (t) 'Content-Type': 'application/json',
    };

    return dio!.post(
      url,
      queryParameters: query,
      data: data,
      /*options: (socketId != null)
          ? Options(
              headers: {
                'X-Socket-ID': socketId,
              },
            )
          : null,*/
    );
  }
}
