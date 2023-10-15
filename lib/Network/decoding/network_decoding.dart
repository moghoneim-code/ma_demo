
import '../errors/decoding_error.dart';

T? decodeResponse<T>(Map<String, dynamic> data,
    Function(Map<String, dynamic> json) fromJsonModel) {
  try {
    return fromJsonModel(data);
  } catch (error) {
    print(error.toString());
    throw DecodingError();
  }
}

List<T>? decodeResponseList<T>(
    dynamic data, Function(Map<String, dynamic> json) fromJsonModel) {
  try {
    return List<T>.from(data.map((itemsJson) => fromJsonModel(itemsJson)));
  } catch (error) {
    print(error.toString());
    throw DecodingError();
  }
}
