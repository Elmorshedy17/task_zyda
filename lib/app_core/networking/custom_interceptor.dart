import 'dart:io';

import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';

import '../app_core.dart';
import 'custom_exception.dart';
// import 'dio_connectivity_request_recall.dart';

class CustomInterceptor implements Interceptor {
  // final DioConnectivityRequestRecall requestRecall;

  // CustomInterceptor({@required this.requestRecall});

  @override
  Future onRequest(RequestOptions options) async {
    options.headers = {
      // 'Auth': '\$2y\$10\$0HkTz09Oaj1Cyoy0F15vfeiPAf6LUhhOHpGEFBA0PEZBsGDj1WBVy',
      // 'Auth': locator<PrefsService>().userObj?.authorization ?? '',
      'Lang': locator<PrefsService>().appLanguage ?? 'en',
      'Platform': Platform.isAndroid ? 'android' : 'ios',
      // 'FirebaseToken': locator<FcmTokenManager>().currentFcmToken ?? '',
    };
    // print(options.headers);
    // print(options);
    return options;
  }

  @override
  Future onResponse(Response response) async {
    if (response.statusCode < 500) {
      return response;
    } else {
      throw FetchDataException(
          '''Error occurred while Communication with Server with StatusCode :
             ${response.statusCode}''');
    }

//     switch (response.statusCode) {
//       case 200:
//         // print(response);
//         return response;
//       case 400:
//         throw BadRequestException(response.data.toString());
//       case 401:
// // return response;
//       case 403:
//         throw UnauthorizedException(response.data.toString());
//       case 500:

//       default:
//         throw FetchDataException(
//             '''Error occurred while Communication with Server with StatusCode :
//              ${response.statusCode}''');
//     }
  }

  @override
  Future onError(DioError err) async {
    // if (_shouldRecall(err)) {
    //   try {
    //     return requestRecall.scheduleRequestRecall(err.request);
    //   } catch (e) {
    //     return e;
    //   }
    // }

    return err;
  }

  // bool _shouldRecall(DioError err) {
  //   return err.type == DioErrorType.DEFAULT &&
  //       err.error != null &&
  //       err.error is SocketException;
  // }
}
