import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    if (dioError is FormatException) {
      message = dioError.toString();
      return;
    }

    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout. Please try again later.";
        break;
      case DioErrorType.other:
        message = "Connection failed. Please check your internet connection.";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout. Please try again later.";
        break;
      case DioErrorType.response:
        if (dioError.response?.statusCode != null) {
          message = _handleError(
              dioError.response!.statusCode!, dioError.response?.data);
        } else {
          message = "Something went wrong";
        }
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout. Please try again later.";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String message = '';

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error.toString(); //'Bad request';
      case 404:
        return 'Not Found';
      case 500:
        return 'Internal server error';
      default:
        return 'Something went wrong';
    }
  }

  @override
  String toString() => message;
}
