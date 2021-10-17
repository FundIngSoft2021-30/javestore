// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jave_store/Entidades/Categoria.dart';
import 'package:jave_store/Entidades/Cuenta.dart';

List<ProductoxCarrito> ProductoxCarritoFromJson(String str) =>
    List<ProductoxCarrito>.from(
        json.decode(str).map((x) => ProductoxCarrito.fromJson(x)));

class ProductoxCarrito {
  String nombre;
  String cantidad;
  String precio;
  ProductoxCarrito({
    this.nombre,
    this.precio,
    this.cantidad,
  });
  @override
  String toString() {
    return "nombre:" +
        this.nombre +
        "precio:" +
        this.precio +
        "cantidad:" +
        this.cantidad;
  }

  factory ProductoxCarrito.fromJson(Map<String, dynamic> json) =>
      ProductoxCarrito(
          cantidad: json["cantidad"],
          nombre: json["producto"],
          precio: json["precio"]);
}

void main() {
  final url = "https://javestore.000webhostapp.com/jave/cuenta.php";
  Future<Cuenta> getData() async {
    final response = await http.post(Uri.parse(url),
        body: {"email": "tomae@gmail.com", "password": "tomatoe123"});
    List<Cuenta> c = CuentaFromJson(response.body);
    if (c.length == 0)
      print("Error");
    else {
      print(c);
      return c[0];
    }
    return null;
  }

  getData();
}
