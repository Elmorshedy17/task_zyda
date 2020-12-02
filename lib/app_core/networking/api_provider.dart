import 'package:dio/dio.dart';

import '../app_core.dart';

class ApiService {
  static final interceptors = [
    CustomInterceptor(
        // requestRecall: DioConnectivityRequestRecall(),
        ),
    LogInterceptor(
      requestHeader: true,
      request: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
    )
  ];
  final Dio dioClient = Dio(
    BaseOptions(
//      baseUrl: 'http://grasse-kw.com/fawtara/api/',
      baseUrl: 'https://fawtara.net/api/',
      connectTimeout: 60000,
      receiveTimeout: 60000,
      // validateStatus: (status) => status < 500,
    ),
  )..interceptors.addAll(interceptors);
}
