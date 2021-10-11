// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
    http.post(Uri.parse(url), body: {
      "query":
          "CREATE OR REPLACE VIEW Carrito_Productos as SELECT k.id as carritoID, p.id as id_producto,p.nombre as producto,c.cantidad as cantidad,p.precio as precio from Producto p,Compra c,Carrito k where p.id = c.Productoid and c.Carritoid = k.id and k.estado='0';"
    });
     final response = await http.post(Uri.parse(url), body: {
      "query":
          "select producto,sum(cantidad) as cantidad,precio from Carrito_Productos group by id_producto;"
    });
    var rt= await ProductoxCarritoFromJson(response.body);
    print(rt);
  }
  getData();
}
