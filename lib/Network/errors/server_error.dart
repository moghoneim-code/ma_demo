import 'dart:convert';

import 'package:dio/dio.dart';

class ServerError implements Exception {
  final String message;
  final List? errors;
  final bool success;
  final bool isBlocked;
  const ServerError._({
    required this.message,
    required this.errors,
    required this.success,
    required this.isBlocked,
  });

  factory ServerError.fromDioError(DioError e) {
    final data = e.response?.data ?? {};
    return ServerError.fromJson(data);
  }

  factory ServerError.fromRaw(String data) {
    final json = jsonDecode(data);
    return ServerError.fromJson(json);
  }

  factory ServerError.fromJson(Map<String, dynamic> json) {
    final jsonErrors = json['errors'];
    final errors = <String>[];
    if (jsonErrors is Map<String, dynamic>) {
      errors.addAll(jsonErrors.values.map((e) => "$e"));
    } else if (jsonErrors is List) {
      errors.addAll(jsonErrors.map((e) => "$e"));
    }
    return ServerError._(
      message: json['message'] ?? '',
      errors: errors.isEmpty ? null : errors,
      success: json['success'] ?? false,
      isBlocked: json['is_blocked'] ?? false,
    );
  }

  String? errorsString() {
    return errors?.join('\n');
  }

  @override
  String toString() {
    if (errors != null) {
      final errs = errors!.join('\n');
      return errs;
    }
    return message;
  }
}
