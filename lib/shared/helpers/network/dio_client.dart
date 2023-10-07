// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// class DioClient {
//   static Dio getClient({
//     String? baseUrl,
//     BaseOptions? options,
//     bool isAuthorized = true,
//   }) {
//     final baseOptions = options ??
//         BaseOptions(
//           baseUrl: baseUrl! ,
//           // connectTimeout: 20000,
//           contentType: 'application/json',
//         );
//     final dio = Dio(baseOptions);

//     dio.interceptors.add(logReq());
//     return dio;
//   }

//   static InterceptorsWrapper logReq() {
//     return InterceptorsWrapper(
//       onRequest: (options, handler) {
//         debugPrint('--- REQUEST ---');
//         debugPrint('${options.method}: ${options.uri}');
//         return handler.next(options);
//       },
//       onError: (e, handler) {
//         debugPrint('--- API ERROR ---');
//         debugPrint(e.message);
//         return handler.next(e);
//       },
//       onResponse: (res, handler) {
//         debugPrint('--- RESPONSE ---');
//         debugPrint('statuscode : ${res.statusCode} - ${res.statusMessage}');
//         return handler.next(res);
//       },
//     );
//   }
// }
