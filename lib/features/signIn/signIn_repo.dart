import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:m1/app_core/app_core.dart';
import 'package:m1/features/signIn/signIn_data.dart';

class SignInRepo extends Repository<SignInData> {
  @override
  Future<ApiResponse<SignInData>> apiPost(ApiRequest request) async {
    FormData formData = FormData.fromMap(request.toJson());
    try {
      final Response response = await locator<ApiService>().dioClient.post(
            '${locator<ApiService>().dioClient.options.baseUrl}loginm',
            data: formData,
          );
      return ApiResponse<SignInData>.fromJson(
        json: response.data,
        fromJsonCallback: (json) => SignInData.fromJson(json),
        toJsonCallback: () => SignInData().toJson(),
      );
    } catch (error) {
      print('xXx ${error.error}');

      return ApiResponse.makeError(error);
    }
  }
}
