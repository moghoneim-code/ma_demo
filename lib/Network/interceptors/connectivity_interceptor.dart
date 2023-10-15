// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class ConnectivityInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // var connectivityResult = await (Connectivity().checkConnectivity());

    // if (connectivityResult == ConnectivityResult.none) {
    //   handler
    //       .reject(DioError(requestOptions: options, error: NoInternetError()));
    // }

    super.onRequest(options, handler);
  }
}
