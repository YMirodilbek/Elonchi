class ResponseData<T> {
  final T? data;
  final dynamic response;
  final String? error;
  final bool ok;
  final int statusCode;

  ResponseData({this.data, this.response, this.error, this.ok = false, this.statusCode = 500});
}

enum ApiStatus { initial, loading, success, error }
