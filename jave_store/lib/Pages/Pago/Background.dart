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
          "select sum(total_producto) from (select c.carritoID as idcar,p.nombre as producto,SUM(c.cantidad)*c.precio as total_producto,SUM(c.cantidad) cantidad, i.porcentaje as impuestos from Carrito_Productos c, Producto p,Carrito_Impuesto ci,Impuesto i,Carrito as ca where c.id_producto =p.id and i.id=ci.Impuestoid and ci.Carritoid=ca.id and ca.estado='0' group by c.carritoID,c.id_producto,i.id) as Cart;"
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
