//@dart=2.9

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jave_store/Pages/Carrito/cardProducto.dart';
import 'package:jave_store/Pages/Pago/Pago.dart';

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
              ? Stack(
                  children: [
                    ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Dismissible(
                          key: Key(snapshot.data[index].nombre),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color: Color(0xFFFFE6E6),
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                Spacer(),
                                Icon(Icons.remove_shopping_cart_sharp),
                              ],
                            ),
                          ),
                          child: CardProducto(item: snapshot.data[index]),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, -2),
                                blurRadius: 20,
                                color: Color(0000000).withOpacity(0.25)),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: 20, top: 20, end: 20),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.shopping_bag,
                                    size: 35,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      text: "Total: ",
                                      children: [
                                        TextSpan(text: "2000"),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => pago()));
                                    },
                                    child: Container(
                                      child: Stack(
                                        children: [
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 12,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
