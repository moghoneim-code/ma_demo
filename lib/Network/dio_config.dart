import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import '../constants/k_network.dart';
import 'errors/unauthorized_user.dart';
import 'interceptors/connectivity_interceptor.dart';



Dio dioClientWithRefreshToken(String baseUrl) {
  Dio dio = Dio();
  dio.options = BaseOptions(
    baseUrl: baseUrl,
    headers: {
      'content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${KNetwork.refreshToken}',
    },
  );
  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  // dio.interceptors.add(ConnectivityInterceptor());
  Dio tokenDio = Dio(); //Create a new instance to request the token.
  tokenDio.options = BaseOptions(baseUrl: dio.options.baseUrl, headers: {
    'content-Type': 'application/json',
  });
  dio.interceptors.add(InterceptorsWrapper(onError: (options, handler) {
    if (options.response?.statusCode == 401) {

    } else {
      handler.next(options);
    }
  }));

  return dio;
}
