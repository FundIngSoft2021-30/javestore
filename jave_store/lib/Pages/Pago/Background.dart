//@dart=2.9
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Pago/Body.dart';

class background extends StatelessWidget {
  final url = "https://javestore.000webhostapp.com/jave/queryDB.php";
  Future getData() async {
    final response = await http.post(Uri.parse(url), body: {
      "query":
          "SELECT SUM(total_producto) FROM ( SELECT c.carritoID AS idcar, p.nombre AS producto, SUM(c.cantidad) * c.precio AS total_producto, SUM(c.cantidad) cantidad FROM Carrito_Productos c, Producto p, ItemsxCarrito AS ca WHERE c.id_producto = p.id GROUP BY c.carritoID, c.id_producto ) AS Cart"
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
      child: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? Center(
                  child: body(
                    total: snapshot.data.toString().split('}')[0].split(':')[1],
                  ),
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
