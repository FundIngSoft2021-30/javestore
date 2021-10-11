//@dart=2.9

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jave_store/Pages/Carrito/cardProducto.dart';

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

class Carrito extends StatefulWidget {
  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  final url = "http://10.0.2.2/jave/queryDB.php";
  Future<List<ProductoxCarrito>> getData() async {
    http.post(Uri.parse(url), body: {
      "query":
          "CREATE OR REPLACE VIEW Carrito_Productos as SELECT k.id as carritoID, p.id as id_producto,p.nombre as producto,c.cantidad as cantidad,p.precio as precio from Producto p,Compra c,Carrito k where p.id = c.Productoid and c.Carritoid = k.id and k.estado='0';"
    });
    final response = await http.post(Uri.parse(url), body: {
      "query":
          "select producto,sum(cantidad) as cantidad,precio from Carrito_Productos group by id_producto;"
    });
    List<ProductoxCarrito> rt = ProductoxCarritoFromJson(response.body);
    return rt;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder<List<ProductoxCarrito>>(
          future: getData(),
          builder: (context, AsyncSnapshot<List<ProductoxCarrito>> snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return CardProducto(item: snapshot.data[index]);
                    })
                : new Center(
                    child: new CircularProgressIndicator(),
                  );
          }),
    );
  }
}
