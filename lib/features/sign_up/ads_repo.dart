// import 'package:dio/dio.dart';
// import 'package:m1/app_core/app_core.dart';
// import 'package:m1/features/ads/ads_data.dart';
//
// class AdsRepo extends Repository<AdsData> {
//   @override
//   Future<ApiResponse<AdsData>> apiGet() async {
//     try {
//       final Response response = await locator<ApiService>().dioClient.get(
//             'http://demo4833373.mockable.io/men',
//           );
//       return ApiResponse<AdsData>.fromJson(
//         json: response.data,
//         fromJsonCallback: (json) => AdsData.fromJson(json),
//         toJsonCallback: () => AdsData().toJson(),
//       );
//     } catch (error) {
//       return ApiResponse.makeError(error);
//     }
//   }
//
//   // static Future<RslAds> getAds() async {
//   //   try {
//   //     final Response response = await locator<ApiService>().dioClient.get(
//   //           '${locator<ApiService>().dioClient.options.baseUrl}ads',
//   //         );
//   //     return RslAds.fromJson(response.data);
//   //   } on DioError {
//   //     // throw FetchDataException('No Internet connection');
//   //     throw FetchDataException(DioError().error);
//   //   }
//   // }
// }
