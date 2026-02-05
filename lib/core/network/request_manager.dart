import 'package:dio/dio.dart';
import 'package:elonchi/core/network/response_data.dart';

class RequestManager {
  final Dio dio;

  RequestManager({required this.dio});

  Future<ResponseData<T>> request<T>({
    required RequestType requestType,
    required String path,
    T? Function(dynamic jsonData)? dataParser,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? contentType,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final response = await dio.request(
        path,
        options: Options(method: requestType.method, contentType: contentType ?? "application/json"),
        data: data,
        queryParameters: queryParameters,
        onSendProgress: onSendProgress,
      );

      return ResponseData(
        data: dataParser?.call(response.data),
        statusCode: response.statusCode ?? 200,
        ok: true,
        response: response.data,
      );
    } on DioException catch (error, stacktrace) {
      //  printError("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseData(
        error: (error.response?.data is Map && error.response?.data.containsKey('detail'))
            ? error.response?.data['detail'].toString()
            : error.response?.data.toString(),
        statusCode: error.response?.statusCode ?? 500,
        response: error.response?.data,
      );
    } catch (error, stacktrace) {
      //   printError("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseData(error: "Something went wrong");
    }
  }
}

enum RequestType {
  get,
  post,
  put,
  delete,
  patch;

  String get method => toString().split('.').last.toUpperCase();
}
