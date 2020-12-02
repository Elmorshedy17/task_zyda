import '../app_core.dart';

abstract class Repository<T> {
  /// Api Get
  Future<ApiResponse<T>> apiGet() async => null;

  /// Api Post
  Future<ApiResponse<T>> apiPost(ApiRequest request) async => null;
}
