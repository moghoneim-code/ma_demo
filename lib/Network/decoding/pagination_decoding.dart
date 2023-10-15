
import '../errors/decoding_error.dart';

class PaginationResponse<T> {
  List<T>? items;
  int? totalCount;

  PaginationResponse({this.items, this.totalCount});

  factory PaginationResponse.fromJson(Map<String, dynamic> jsonData,
      Function(Map<String, dynamic> json) fromJsonModel) {
    return PaginationResponse(
      items: jsonData['Items'] == null
          ? null
          : List<T>.from(
              jsonData['Items'].map((itemsJson) => fromJsonModel(itemsJson))),
      totalCount: jsonData['TotalCount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Items'] = this.items;
    data['TotalCount'] = this.totalCount;
    return data;
  }
}

List<T>? decodePagedList<T>(
    dynamic data, Function(Map<String, dynamic> json) fromJsonModel) {
  try {
    final response = PaginationResponse<T>.fromJson(data, fromJsonModel);

    return response.items;
  } catch (error) {
    print(error.toString());
    throw DecodingError();
  }
}
