class ApiResponse<T> {
  final T? data;
  final ApiStatus apiStatus;
  final String? errorMessage;
  final dynamic progress;

  ApiResponse._({this.data, required this.apiStatus, this.errorMessage, this.progress});

  static ApiResponse<T> loading<T>({dynamic progress}) {
    return ApiResponse._(apiStatus: ApiStatus.loading, progress: progress);
  }

  static ApiResponse<T> error<T>({T? data, String? message}) {
    return ApiResponse._(data: data, apiStatus: ApiStatus.error, errorMessage: message);
  }

  static ApiResponse<T> complete<T>({T? data}) {
    return ApiResponse._(data: data, apiStatus: ApiStatus.complete);
  }
}

enum ApiStatus { loading, error, complete }
