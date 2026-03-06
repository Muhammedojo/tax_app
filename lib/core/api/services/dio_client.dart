import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../utils/const.dart';
import '../exceptions/api_exception.dart';
import '../exceptions/contracts/failure.dart';
import '../network/network_info.dart';
import 'api_response_impl.dart';
import 'contracts/api_client.dart';
import 'contracts/api_response.dart';
import 'endpoints.dart';
import 'interceptor.dart';

class DioClient implements IApiClient {
  late Dio _dio;
  late CancelToken _cancelToken;
  late NetworkInfo networkInfo;

  factory DioClient.createInstance(NetworkInfo value) {
    return DioClient(value);
  }

  @override
  setToken(String token) {
    _dio.options.headers['Authorization'] = token;
  }

  @override
  clearToken() {
    _dio.options.headers.remove('Authorization');
  }

  @override
  void cancelRequest() {
    _cancelToken.cancel("Request was manually canceled.");
  }

  DioClient(this.networkInfo) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseApi,
        headers: {
          "content-type": "application/json",
          KEY_CLIENT_AGENT: 'mobile',
        },
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(minutes: 1),
        sendTimeout: const Duration(minutes: 1),
      ),
    )
      ..options.connectTimeout = const Duration(seconds: 60)
      ..options.receiveTimeout = const Duration(seconds: 60)
      ..options.sendTimeout = const Duration(seconds: 60)
      ..interceptors.add(
        PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: true,
            error: true,
            compact: true,
            maxWidth: 90),
      );
  }

  @override
  Future<Either<Failure, ApiResponse<T>>> request<T>(
      String url,
      MethodType method,
      T Function(dynamic, {String? realUri}) fromJson,
      dynamic params,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headerOption,
      authInterceptor = const DioClientInterceptor()}) async {
    try {
      if (authInterceptor != null) {
        _dio.interceptors.add(authInterceptor);
      }

      _cancelToken = CancelToken();
      Response response;

      switch (method) {
        case MethodType.post:
          response = await _dio.post(
            url,
            data: params,
            queryParameters: queryParameters,
            options: Options(headers: headerOption),
            cancelToken: _cancelToken,
          );
          break;
        case MethodType.delete:
          response = await _dio.delete(
            url,
            data: params,
            queryParameters: queryParameters,
            options: Options(headers: headerOption), 
            cancelToken: _cancelToken,
          );
          break;
        case MethodType.patch:
          response = await _dio.patch(
            url,
            data: params,
            queryParameters: queryParameters,
            options: Options(headers: headerOption), // Added headerOption
            cancelToken: _cancelToken,
          );
          break;
        case MethodType.get:
          response = await _dio.get(
            url,
            data: params, // Note: GET requests typically use queryParameters, not data body
            queryParameters: queryParameters,
            options: Options(headers: headerOption), // Added headerOption
            cancelToken: _cancelToken,
          );
          break;
        case MethodType.put:
          response = await _dio.put(
            url,
            data: params,
            queryParameters: queryParameters,
            options: Options(headers: headerOption), // Added headerOption
            cancelToken: _cancelToken,
          );
          break;
      }

      // Check for successful HTTP status codes first
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        if (responseData != null) {
          // Check if the API indicates success via responseCode (if present)
          final String responseCode = responseData['responseCode']?.toString() ?? '100'; // Default to success if no code
          final bool isApiSuccess = _isRequestSuccessful(response.statusCode.toString(), responseCode);

          if (isApiSuccess) {
            // Determine where the actual data payload is
            dynamic dataPayload = responseData.containsKey('data') ? responseData['data'] : responseData;

            // Handle cases where the payload might be null unexpectedly after checks
            if (dataPayload == null) {
               return left(ServerFailure(message: "Successful response but data payload is null."));
            }

            return right(ApiResponseImpl<T>(
              fromJson(dataPayload, realUri: response.realUri.toString()),
              responseData['errors'] ?? responseData['detail'],
              responseData['message'],
              responseCode,
              total: responseData['total'] ?? responseData['total'],
              next: responseData['next'] ?? responseData['next_page_url'],
              previous: responseData['prev'] ?? responseData['prev_page_url'], // Assuming 'prev' is the key for previous URL
            ));
          } else {
            // API returned 2xx status but responseCode indicates failure
            return left(ValidationFailure(_formatApiErrorMessage(
                responseData['errors'] ?? responseData['detail'],
                responseData['message'] ?? 'API indicated failure despite 2xx status.')));
          }
        } else {
          // Successful status code but null response body
          return left(ServerFailure(message: "Successful response with null body."));
        }
      }

      // Handle non-2xx responses (errors)
      return left(_handleErrorResponse(response));

    } on DioException catch (dioError) {
      return left(_handleDioError(dioError));
    } finally {
       // Ensure interceptor is removed if it was added
       if (authInterceptor != null) {
         _dio.interceptors.remove(authInterceptor);
       }
    }
  }

  @override
  Future<Either<Failure, ApiResponse<T>>> multipartRequest<T>(
      String url,
      MethodType method, // MethodType might not be needed if always POST
      T Function(dynamic, {String? realUri}) fromJson,
      dynamic params, // Should be FormData
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headerOption,
      authInterceptor = const DioClientInterceptor()}) async {
    try {
      if (authInterceptor != null) {
        _dio.interceptors.add(authInterceptor);
      }
      _cancelToken = CancelToken();

      // Ensure headers are correctly set for multipart
      final options = Options(
        headers: {
          ...?headerOption, // Spread existing headers
          "Content-Type": "multipart/form-data", // Override Content-Type
        },
      );

      Response response;
      // Multipart is typically POST, but handle others if necessary
       switch (method) {
         case MethodType.post:
            response = await _dio.post(
              url,
              data: params,
              queryParameters: queryParameters,
              options: options,
              cancelToken: _cancelToken,
            );
            break;
         case MethodType.put: // Example: Handle PUT if needed
            response = await _dio.put(
              url,
              data: params,
              queryParameters: queryParameters,
              options: options,
              cancelToken: _cancelToken,
            );
            break;
         case MethodType.patch: // Example: Handle PATCH if needed
             response = await _dio.patch(
              url,
              data: params,
              queryParameters: queryParameters,
              options: options,
              cancelToken: _cancelToken,
            );
            break;
         default:
           // Throw an error or return a failure if method is not supported for multipart
           return left(ServerFailure(message: "Unsupported method type for multipart request: $method"));
       }


     // Check for successful HTTP status codes first
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        if (responseData != null) {
          // Check if the API indicates success via responseCode (if present)
          final String responseCode = responseData['responseCode']?.toString() ?? '100'; // Default to success if no code
          final bool isApiSuccess = _isRequestSuccessful(response.statusCode.toString(), responseCode);

          if (isApiSuccess) {
            // Determine where the actual data payload is
            dynamic dataPayload = responseData.containsKey('data') ? responseData['data'] : responseData;

             // Handle cases where the payload might be null unexpectedly after checks
            if (dataPayload == null) {
               return left(ServerFailure(message: "Successful response but data payload is null."));
            }

            return right(ApiResponseImpl<T>(
              fromJson(dataPayload, realUri: response.realUri.toString()),
              responseData['errors'] ?? responseData['detail'],
              responseData['message'],
              responseCode,
              total: responseData['count'] ?? responseData['total'],
              next: responseData['next'] ?? responseData['next_page_url'],
              previous: responseData['prev'] ?? responseData['prev_page_url'],
            ));
          } else {
            // API returned 2xx status but responseCode indicates failure
            return left(ValidationFailure(_formatApiErrorMessage(
                responseData['errors'] ?? responseData['detail'],
                responseData['message'] ?? 'API indicated failure despite 2xx status.')));
          }
        } else {
          // Successful status code but null response body
          return left(ServerFailure(message: "Successful response with null body."));
        }
      }

      // Handle non-2xx responses (errors)
      return left(_handleErrorResponse(response));

    } on DioException catch (dioError) {
      return left(_handleDioError(dioError));
    } finally {
       // Ensure interceptor is removed if it was added
       if (authInterceptor != null) {
         _dio.interceptors.remove(authInterceptor);
       }
    }
  }

  // Helper to handle error responses based on content
  Failure _handleErrorResponse(Response response) {
     final responseData = response.data;
     if (responseData != null && responseData is Map && (responseData.containsKey('errors') || responseData.containsKey('detail'))) {
        return ValidationFailure(_formatApiErrorMessage(
              responseData['errors'] ?? responseData['detail'],
              responseData['message']));
     } else if (response.statusCode == 500 || response.statusCode == 404) {
        // Try to get a message from response data if it's a map, otherwise use status message
        String? serverMessage;
        if (responseData is Map && responseData.containsKey('message')) {
           serverMessage = responseData['message']?.toString();
        }
        return ServerFailure(message: serverMessage ?? "Server error (${response.statusCode})");
     } else {
        return ServerFailure(message: "Unhandled error (${response.statusCode}): ${response.statusMessage}");
     }
  }

  bool _isRequestSuccessful(String? statusCode, String? responseCode) =>
      (statusCode == '200' || statusCode == '201') &&
      (responseCode == '100' || responseCode == '200'); // Assuming '100' and '200' are success codes

  Failure _handleDioError(DioException error) {
    if (error.error != null && error.error is SocketException) {
      return InternetFailure();
    }

    late Failure failureType;
    switch (error.type) {
      case DioExceptionType.cancel:
        failureType = CancelFailure();
        break;
      case DioExceptionType.connectionTimeout:
        failureType = ConnectionTimeOutFailure();
        break;
      case DioExceptionType.connectionError:
         // More specific check for connection refused or host lookup failed
        if (error.error is SocketException) {
           final socketError = error.error as SocketException;
           if (socketError.osError?.message.contains('Connection refused') ?? false) {
              failureType = ConnectionFailure(message: socketError.message);
           } else if (socketError.osError?.message.contains('Failed host lookup') ?? false) {
              failureType = ConnectionFailure(message: socketError.message);
           } else {
              failureType = ConnectionFailure(message: socketError.message);
           }
        } else {
           failureType = ConnectionFailure(message: error.message);
        }
        break;
      case DioExceptionType.badCertificate:
        failureType = BadCertificateFailure();
        break;
      case DioExceptionType.badResponse:
        if (error.response != null) {
           // Use the _handleErrorResponse logic for consistency
           failureType = _handleErrorResponse(error.response!);
        } else {
           // If response is null, it's likely a more fundamental issue
           failureType = BadResponseFailure(message: error.message ?? "Bad response with no details");
        }
        break;
      case DioExceptionType.receiveTimeout:
        failureType = ReceivedTimeOutFailure();
        break;
      case DioExceptionType.sendTimeout:
        failureType = SendTimeOutFailure();
        break;
      case DioExceptionType.unknown:
         // Provide more context if available from the underlying error
         final underlyingError = error.error?.toString();
         failureType = ServerFailure(message: underlyingError ?? error.message ?? "Unknown Dio error");
        break;
    }
    return failureType;
  }

  @override
  Future<Either<Failure, ApiResponse<T>>> download<T>(
      String url, String savePath, T Function(dynamic p1) fromJson, params, // params might not be needed for download
      {Map<String, dynamic>? queryParameters,
       ProgressCallback? onReceiveProgress, // Added progress callback
       authInterceptor = const DioClientInterceptor()}) async {
     try {
       if (authInterceptor != null) {
         _dio.interceptors.add(authInterceptor);
       }
       _cancelToken = CancelToken();

       Response response = await _dio.download(
         url,
         savePath, // Path where the file will be saved
         queryParameters: queryParameters,
         cancelToken: _cancelToken,
         onReceiveProgress: onReceiveProgress,
         // options: Options(headers: headerOption), // Add headers if needed
       );

       // For download, success is usually indicated by status code 200.
       // The response.data will be null for download requests.
       if (response.statusCode == 200) {
         // You might not need fromJson here, as the result is the file path.
         // If you need to return something specific, adjust accordingly.
         // Perhaps return the savePath or a custom success object.
         // Using a placeholder T for now, assuming fromJson handles null or path.
         return right(ApiResponseImpl<T>(
           fromJson(savePath), // Pass savePath or handle as needed
           null, // No errors object expected on successful download
           'Download successful', // Success message
           '100', // Success code
         ));
       } else {
         // Handle non-200 responses for download
         return left(ServerFailure(message: "Download failed with status: ${response.statusCode}"));
       }
     } on DioException catch (dioError) {
       return left(_handleDioError(dioError));
     } finally {
       if (authInterceptor != null) {
         _dio.interceptors.remove(authInterceptor);
       }
     }
  }

  @override
  void removeToken() {
    // Alias for clearToken for potentially different semantic meaning if needed
    clearToken();
  }
}

// Helper function for formatting API error messages (consider moving to a utility class)
String _formatApiErrorMessage(dynamic errors, String? message) {
  if (errors != null) {
    if (errors is Map) {
      // Handle map errors (e.g., field-specific errors)
      return errors.entries
          .map((e) => '${e.key}: ${e.value is List ? e.value.join(', ') : e.value}')
          .join('\n');
    } else if (errors is List) {
      // Handle list errors (e.g., non-field errors)
      return errors.join('\n');
    } else if (errors is String && errors.trim().isNotEmpty) {
       // Handle simple string errors
       return errors;
    }
  }
  return message ?? 'An unknown error occurred.';
}


// Enum for HTTP methods (already defined, just for context)
enum MethodType { post, get, put, delete, patch }

// Consider adding specific Failure types if needed
// class ConnectionRefusedFailure extends Failure {
//   ConnectionRefusedFailure({String message = "Connection refused by server."}) : super(message: message);
// }

// class HostLookupFailure extends Failure {
//   HostLookupFailure({String message = "Failed to resolve hostname."}) : super(message: message);
// }
