import 'package:dio/dio.dart';
import 'package:rotation_app/config/logger.dart';


Map<String, dynamic> dioErrorHandle(DioError error) {
  UtilLogger.log("ERROR", error);
  switch (error.type) {
    case DioErrorType.RESPONSE:
      return error.response?.data;
    case DioErrorType.SEND_TIMEOUT:
    case DioErrorType.RECEIVE_TIMEOUT:
      return {"success": false, "code": "request_time_out"};
    default:
      return {"success": false, "code": "connect_to_server_fail"};
  }
}

class HTTPManager {
  BaseOptions baseOptions = BaseOptions(
    baseUrl: "https://tmp.ptravels.kz/api",
    connectTimeout: 30000,
    receiveTimeout: 30000,
    contentType: Headers.formUrlEncodedContentType,
    responseType: ResponseType.json,
  );

  ///Post method
  Future<dynamic> post({
    String url,
    Map<String, dynamic> data,
    Options options,
  }) async {
    UtilLogger.log("POST URL", baseOptions.baseUrl + url);
    UtilLogger.log("DATA", data);
    Dio dio = new Dio(baseOptions);
    try {
      final response = await dio.post(
        url,
        data: data,
        options: options,
      );
      return {"code": response.statusCode, "data": response.data};
    } on DioError catch (error) {
      return {"code": error.response.statusCode, "data": error.response.data};
      return error.response;
    }
  }

/*  Future<dynamic> post({
    String url,
    Map<String, dynamic> data,
    Options options,
  }) async {
    UtilLogger.log("POST URL", baseOptions.baseUrl + url);
    UtilLogger.log("DATA", data);
    Dio dio = new Dio(baseOptions);
    try {
      final response = await dio.post(
        url,
        data: data,
        options: options,
      );
      return response.data;
    } on DioError catch (error) {
      return dioErrorHandle(error);
    }
  }*/

  ///Get method
  Future<dynamic> get({String url, Map<String, dynamic> params, Options options,}) async {
    UtilLogger.log("POST URL", baseOptions.baseUrl + url);
    UtilLogger.log("DATA", params);
    Dio dio = new Dio(baseOptions);
    try {
      final response = await dio.get(
        url,
        queryParameters: params,
        options: options,
      );
      return {"code": response.statusCode, "data": response.data};
    } on DioError catch (error) {
      return {"code": error.response.statusCode, "data": error.response.data};
      return error.response;
    }
  }

  factory HTTPManager() {
    return HTTPManager._internal();
  }

  HTTPManager._internal();
}

HTTPManager httpManager = HTTPManager();
