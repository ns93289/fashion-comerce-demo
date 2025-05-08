sealed class ApiResult<T> {
  const ApiResult();
}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;

  const ApiSuccess(this.data);
}

class ApiError<T> extends ApiResult<T> {
  final ErrorModel errorData;

  const ApiError(this.errorData);
}

class ErrorModel {
  String? _error;
  String? _message;

  ErrorModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
  }

  String get message => _message ?? "";

  String get error => _error ?? "";
}
