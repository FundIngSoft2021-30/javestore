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
  Future<List<String>> suggestions() async {
    final url = "https://javestore.000webhostapp.com/jave/queryDB.php";
    final response = await http
        .post(Uri.parse(url), body: {"query": "select nombre from Producto"});
    print(response.body);
    List<String> rt = json.decode(response.body).map((x) => x);
    print("*************************");
    print(rt.toString());
    return rt;
  }

  suggestions();
}
