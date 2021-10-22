//@dart=2.9
import 'dart:convert';

List<Cuenta> CuentaFromJson(String str) =>
    List<Cuenta>.from(json.decode(str).map((x) => Cuenta.fromJson(x)));

class Cuenta {
  String email;
  String pass;
  String rol;
  Cuenta({this.pass, this.email, this.rol});

  @override
  String toString() => "email:${this.email} pass:${this.pass} rol:${this.rol}";

  factory Cuenta.fromJson(Map<String, dynamic> json) =>
      Cuenta(email: json["email"], pass: json["password"], rol: json["rol"]);
}
