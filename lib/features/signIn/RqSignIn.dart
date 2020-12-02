import 'package:m1/app_core/app_core.dart';

class RqSignIn implements ApiRequest {
  String email;
  String password;

  RqSignIn({this.email, this.password});

  RqSignIn.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['email'] = this.email;
  //   data['password'] = this.password;
  //   return data;
  // }
}
