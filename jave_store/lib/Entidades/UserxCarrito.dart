//@dart=2.9
import 'dart:convert';

List<UserxCarrito> UserxCarritoFromJson(String str) => List<UserxCarrito>.from(
    json.decode(str).map((x) => UserxCarrito.fromJson(x)));

class UserxCarrito {
  String id;
  String email;
  String idCart;

  UserxCarrito({this.id, this.email, this.idCart});

  factory UserxCarrito.fromJson(Map<String, dynamic> json) => UserxCarrito(
      email: json["email"], id: json["UserID"], idCart: json["carritoID"]);
}
