import 'package:dio/dio.dart';
import 'package:m1/app_core/app_core.dart';
import 'package:m1/features/home/home_data.dart';

class HomeRepo extends Repository<HomeData> {
  @override
  Future<ApiResponse<HomeData>> apiGet() async {
    try {
      final Response response = await locator<ApiService>().dioClient.get(
            'http://demo4833373.mockable.io/menu',
          );
      return ApiResponse<HomeData>.fromJson(
        json: response.data,
        fromJsonCallback: (json) => HomeData.fromJson(json),
        toJsonCallback: () => HomeData().toJson(),
      );
    } catch (error) {
      return ApiResponse.makeError(error);
    }
  }

  // static Future<RslAds> getAds() async {
  //   try {
  //     final Response response = await locator<ApiService>().dioClient.get(
  //           '${locator<ApiService>().dioClient.options.baseUrl}ads',
  //         );
  //     return RslAds.fromJson(response.data);
  //   } on DioError {
  //     // throw FetchDataException('No Internet connection');
  //     throw FetchDataException(DioError().error);
  //   }
  // }
}
// locator<DrawerManager>().getData()