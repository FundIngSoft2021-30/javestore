//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/Pages/Carrito/carrito.dart';
import 'package:jave_store/Pages/Pago/Body.dart';

class pago extends StatelessWidget {
  final String total;
  final List<Producto> productos;
  final String carritoId;

  pago({this.productos, this.total, this.carritoId});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            centerTitle: true,
            title: Text('Pedido'),
            backgroundColor: Colors.blue,
          ),
          body: Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
            child:
                body(total: total, productos: productos, carritoId: carritoId),
          )),
    );
  }
}
