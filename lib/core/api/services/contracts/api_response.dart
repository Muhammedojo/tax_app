abstract class ApiResponse<T> {
  String? get message;
  String? get responseCode;
  dynamic get errors;
  T? get data;
  int? get itemCount;
  String? get nextUrl;
  String? get previousUrl;
  bool? get isSuccess;
  String? get defaultErrorMessage;
  @override
  String toString() {
    return data?.toString() ?? '';
  }
}
