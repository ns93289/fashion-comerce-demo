class ResponseWrapper<T> {
  static ApiResponse<T> fromJson<T>(dynamic json, T Function(Map<String, dynamic>) fromJsonT) {
    if (json['error'] != null) {
      return ApiError(ErrorModel.fromJson(json));
    } else {
      return ApiSuccess(fromJsonT(json));
    }
  }
}

sealed class ApiResponse<T> {
  const ApiResponse();
}

class ApiSuccess<T> extends ApiResponse<T> {
  final T data;

  const ApiSuccess(this.data);
}

class ApiError<T> extends ApiResponse<T> {
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
