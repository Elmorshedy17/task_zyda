import 'package:flutter/foundation.dart';

typedef FromJsonCallback<T> = T Function(Map<String, dynamic> json);
typedef ToJsonCallback<T> = Map<String, dynamic> Function();

class ApiResponse<T> {
  int status;
  String message;
  T dataObj;
  FromJsonCallback<T> fromJsonCallback;
  ToJsonCallback<T> toJsonCallback;
  var error;

  ApiResponse({this.status, this.message, this.dataObj});
  ApiResponse.makeError(this.error);

  ApiResponse.fromJson(
      {@required Map<String, dynamic> json,
      @required this.fromJsonCallback,
      this.toJsonCallback}) {
    status = json['status'];
    message = json['message'];
    dataObj = json['data'] != null ? fromJsonCallback(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.dataObj != null) {
      // data['data'] = this.dataObj.toJson();
      data['data'] = this.toJsonCallback();
    }
    return data;
  }
}
