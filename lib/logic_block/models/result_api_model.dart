class ResultApiModel {
  final bool success;
  final String message;
  final String slug;
  final dynamic data;
  final dynamic pagination;
  final dynamic attr;
  final String code;
  final String type;

  ResultApiModel({
    this.success,
    this.message,
    this.data,
    this.pagination,
    this.attr,
    this.code,
    this.type,
    this.slug,
  });

  factory ResultApiModel.fromJson(Map<String, dynamic> json) {
    try {
      return ResultApiModel(
        success: json['success'] as bool ?? true,
        message: json['message'] as String,
        type: json['type'] as String ?? '',
        data: json['data'],
        pagination: json['pagination'],
        attr: json['attr'],
        code: json['code'].toString() ?? 'Unknown',
        slug: json['slug'].toString() ?? 'Unknown',
      );
    } catch (error) {
      return ResultApiModel(
        success: false,
        data: null,
        message: "cannot init result api",
      );
    }
  }
}


class ResponseApi{
  final int code;
  final dynamic data;

  ResponseApi({this.code, this.data});

  factory ResponseApi.fromJson(Map<String, dynamic> json) {
    try {
      return ResponseApi(
        code: json['code'],
        data: json['data'],
      );
    } catch (error) {
      return ResponseApi(
        code: 500,
        data: null,
      );
    }
  }
}