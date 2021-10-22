//@dart=2.9

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jave_store/Entidades/ProductoXcarrito.dart';
import 'package:jave_store/Pages/Carrito/cardProducto.dart';
import 'package:jave_store/Pages/Pago/Pago.dart';
import 'package:localstorage/localstorage.dart';

List<ProductoxCarrito> ProductoxCarritoFromJson(String str) =>
    List<ProductoxCarrito>.from(
        json.decode(str).map((x) => ProductoxCarrito.fromJson(x)));

class Carrito extends StatefulWidget {
  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  final LocalStorage storage = new LocalStorage('localstorage_app');
  final url = "https://javestore.000webhostapp.com/jave/queryDB.php";
  Future<List<ProductoxCarrito>> getData() async {
    http.post(Uri.parse(url), body: {
      "query":
          "CREATE OR REPLACE VIEW UserxCarrito AS SELECT u.id as UserID,c.email as email,ca.id as carritoID FROM Usuario u,Cuenta c,Carrito ca WHERE u.id=c.Usuarioid AND u.id=ca.Usuarioid AND ca.estado='0';"
    });
    http.post(Uri.parse(url), body: {
      "query":
          "CREATE OR REPLACE VIEW Carrito_Productos AS SELECT uc.carritoID AS carritoID,p.id AS idProducto,p.nombre AS producto,p.imagen AS imagen,i.cantidad AS cantidad,p.precio AS precio FROM UserxCarrito  uc,Carrito c,Producto p,ItemsxCarrito i WHERE p.id = i.Productoid AND c.id =uc.carritoID AND c.estado = '0' AND uc.email='${storage.getItem('email')}';"
    });

    final response = await http.post(Uri.parse(url), body: {
      "query":
          "select carritoID,producto,imagen,idProducto,sum(cantidad) as cantidad,precio from Carrito_Productos group by idProducto;"
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
                          onDismissed: (direction) {
                            dismissedItem(context, index, snapshot.data[index]);
                          },
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
                                        TextSpan(text: "555000"),
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

  void dismissedItem(
      BuildContext context, int index, ProductoxCarrito item) async {
    http.post(Uri.parse(url), body: {
      "query": "DELETE FROM ItemsxCarrito where Productoid='${item.idProducto}'"
    });
  }
}
