// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import '../../../config/di/app_initializer.dart';
// import '../../storage/istorage.dart';

// class DioClientInterceptor extends Interceptor {
//   const DioClientInterceptor();

//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     var bearerToken =
//         AppInitializer.instanceLocator.get<String>(instanceName: 'accessToken');
//     if (bearerToken.isEmpty) {
//       final user = await GetIt.I.get<LocalStorage>().getLoggedInUser();
//       bearerToken = user.token ?? "";
//     }
//     if (bearerToken.isNotEmpty) {
//       options.headers['Authorization'] = 'Bearer $bearerToken';
//     }
//     handler.next(options);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     handler.next(err);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     handler.next(response);
//   }
// }
