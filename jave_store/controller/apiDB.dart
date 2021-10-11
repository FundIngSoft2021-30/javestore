// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jave_store/Entidades/Categoria.dart';
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
  var url = "http://localhost/jave/queryDB.php";
  Future getData() async {
     final response = await http.post(Uri.parse(url), body: {
      "query":
          "select producto,sum(cantidad) as cantidad,precio from Carrito_Productos group by id_producto;"
    });
    var rt= await CategoriaFromJson(response.body);
    print(rt);
  }
  getData();
}
