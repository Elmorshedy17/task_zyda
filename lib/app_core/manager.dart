import 'app_core.dart';

abstract class Manager<T> {
  /// For Api Get.
  Stream<ApiResponse<T>> getStream() => null;

  /// For Api Post.
  void getFuture() => null;
  void dispose();
}
