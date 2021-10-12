//@dart=2.9
import 'dart:convert';

List<LoginResponseModel> LoginResponseModelFromJson(String str) =>
    List<LoginResponseModel>.from(
        json.decode(str).map((x) => LoginResponseModel.fromJson(x)));

class LoginResponseModel {
  final String token;
  LoginResponseModel({this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        token: json["token"],
      );
}

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({
    this.email,
    this.password,
  });
}
